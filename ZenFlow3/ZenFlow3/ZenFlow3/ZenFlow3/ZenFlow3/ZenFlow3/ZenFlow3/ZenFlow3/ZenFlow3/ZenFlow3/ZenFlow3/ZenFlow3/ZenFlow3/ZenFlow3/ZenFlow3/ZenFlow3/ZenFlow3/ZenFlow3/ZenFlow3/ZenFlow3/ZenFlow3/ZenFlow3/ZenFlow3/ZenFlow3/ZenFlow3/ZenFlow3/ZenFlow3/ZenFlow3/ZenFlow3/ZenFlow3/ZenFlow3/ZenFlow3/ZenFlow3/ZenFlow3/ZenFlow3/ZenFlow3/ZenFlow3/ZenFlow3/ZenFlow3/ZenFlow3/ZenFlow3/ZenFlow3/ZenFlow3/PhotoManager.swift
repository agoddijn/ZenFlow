//
//  PhotoManager.swift
//  ZenFlow3
//
//  Created by Alexander Goddijn on 14/03/2015.
//  Copyright (c) 2015 Alexander Goddijn. All rights reserved.
//

import Foundation
import UIKit

class PhotoManager: NSObject, CLUploaderDelegate {
    
    let numPhotos = 5
    var photos: Queue<UIImage> = Queue<UIImage>()
    var Cloudinary = CLCloudinary(url: "cloudinary://211749683225582:Oy4o2qrzljQLi_lFP9iUcgzQYTQ@dptjiyh0z")
    
    func push(photo: UIImage) {
        photos.enQueue(photo)
        uploadToCloudinary()
    }
    
    func pop() -> UIImage? {
        return photos.deQueue()
    }
    
    func uploadToCloudinary(){
        let forUpload = UIImageJPEGRepresentation(photos.peek(), 0.7) as NSData
        let uploader = CloudinaryFactory.create(Cloudinary, delegate: self)
        
        uploader.upload(forUpload, options: ["public_id":"", "exif": true])
    }
    
    func uploaderSuccess(result: [NSObject : AnyObject]!, context: AnyObject!) {
        println("uploaded")
    }
    
    func uploaderError(result: String!, code: Int, context: AnyObject!) {
        println(result)
    }
    
    func uploaderProgress(bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int, context: AnyObject!) {

    }
    
}
