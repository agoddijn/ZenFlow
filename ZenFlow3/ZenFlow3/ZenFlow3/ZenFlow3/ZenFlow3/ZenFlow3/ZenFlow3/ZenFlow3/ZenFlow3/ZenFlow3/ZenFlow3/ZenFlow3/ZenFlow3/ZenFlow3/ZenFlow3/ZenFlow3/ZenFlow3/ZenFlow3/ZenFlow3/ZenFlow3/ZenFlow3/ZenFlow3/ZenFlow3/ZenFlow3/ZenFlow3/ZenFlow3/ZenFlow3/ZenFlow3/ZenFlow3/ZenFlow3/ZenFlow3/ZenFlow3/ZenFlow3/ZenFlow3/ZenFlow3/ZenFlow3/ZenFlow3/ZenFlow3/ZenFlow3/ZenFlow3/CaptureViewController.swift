//
//  CaptureViewController.swift
//  ZenFlow3
//
//  Created by Alexander Goddijn on 14/03/2015.
//  Copyright (c) 2015 Alexander Goddijn. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var myManager = PhotoManager()
    var captureManager = CaptureSessionManager()
    
    @IBOutlet weak var captureFrame: UIView!
    @IBOutlet weak var flashView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func switchCamera(sender: AnyObject) {
        self.captureManager.switchCamera()
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: {
            self.flashView.alpha = 0.7
            self.flashView.alpha = 0
        })
        captureManager.takePhoto(myManager)
    }
    
    
    @IBAction func library(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .PhotoLibrary
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let photo = info[UIImagePickerControllerOriginalImage] as UIImage
        myManager.push(photo)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
        if let previewLayer = captureManager.previewLayer {
            captureFrame.layer.addSublayer(previewLayer)
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
            captureManager.run()
            spinner.stopAnimating()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        if let previewLayer = captureManager.previewLayer {
            previewLayer.frame = captureFrame.bounds
        }
    }
}