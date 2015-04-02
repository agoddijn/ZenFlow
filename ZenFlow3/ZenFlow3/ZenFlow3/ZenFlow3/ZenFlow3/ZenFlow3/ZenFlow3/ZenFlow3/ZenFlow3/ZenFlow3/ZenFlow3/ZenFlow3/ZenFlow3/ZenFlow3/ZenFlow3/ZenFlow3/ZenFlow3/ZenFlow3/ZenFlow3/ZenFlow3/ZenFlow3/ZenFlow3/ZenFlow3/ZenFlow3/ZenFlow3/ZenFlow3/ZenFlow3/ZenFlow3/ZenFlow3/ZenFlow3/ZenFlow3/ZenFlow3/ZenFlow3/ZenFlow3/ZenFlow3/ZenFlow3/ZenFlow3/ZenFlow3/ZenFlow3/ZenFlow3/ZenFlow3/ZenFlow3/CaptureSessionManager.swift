//
//  CaptureSessionManager.swift
//  ZenFlow3
//
//  Created by Alexander Goddijn on 17/03/2015.
//  Copyright (c) 2015 Alexander Goddijn. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CaptureSessionManager {
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    let devices = AVCaptureDevice.devices()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var cam = false
    
    init() {
        // Create session and select preset (settings)
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        // Choose input device
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    backCamera = device as? AVCaptureDevice
                }
                if(device.position == AVCaptureDevicePosition.Front) {
                    frontCamera = device as? AVCaptureDevice
                }
            }
        }
        
        if (frontCamera == nil && backCamera == nil) {
            NSLog("Could not find camera")
        } else {
            cam = true
            if let camera = backCamera {
                addInputFromDevice(camera)
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            }
        }
    }
    
    func takePhoto(manager: PhotoManager){
        if cam {
            if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
                stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
                    var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    var dataProvider = CGDataProviderCreateWithCFData(imageData)
                    var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, kCGRenderingIntentDefault)
                    var image = UIImage(CGImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.Right)
                    manager.push(image!)
                    }
                )
            }
        }
    }
    
    func addInputFromDevice(device: AVCaptureDevice) {
        // Prepare to accept input on device
        var error: NSError?
        var input = AVCaptureDeviceInput(device: device, error: &error)
        
        // Associate capture device with session
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput!)
            }
        }
    }
    
    func switchCamera() {
        if cam {
            previewLayer!.hidden = true
            var curInput: AVCaptureDeviceInput = captureSession?.inputs[0] as AVCaptureDeviceInput
            var curOutput: AVCaptureStillImageOutput = captureSession?.outputs[0] as AVCaptureStillImageOutput
            captureSession?.removeInput(curInput)
            captureSession?.removeOutput(curOutput)
            if curInput.device == backCamera {
                if let camera = frontCamera {
                    addInputFromDevice(camera)
                }
            } else {
                if let camera = backCamera {
                    addInputFromDevice(camera)
                }
            }
            previewLayer!.hidden = false
        }
    }
    
    func run() {
        captureSession?.startRunning()
    }
    
    func stop() {
        captureSession?.stopRunning()
    }
}