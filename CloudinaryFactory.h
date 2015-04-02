//
//  CloudinaryFactory.h
//  ZenFlow3
//
//  Created by Alexander Goddijn on 20/03/2015.
//  Copyright (c) 2015 Alexander Goddijn. All rights reserved.
//

#ifndef ZenFlow3_CloudinaryFactory_h
#define ZenFlow3_CloudinaryFactory_h
#import "Cloudinary/Cloudinary.h"

@interface CloudinaryFactory : NSObject
+ (CLUploader*)create:(CLCloudinary *)cl delegate:(id <CLUploaderDelegate> )delegate;
@end

#endif
