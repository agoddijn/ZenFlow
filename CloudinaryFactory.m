//
//  CloudinaryFactory.m
//  ZenFlow3
//
//  Created by Alexander Goddijn on 20/03/2015.
//  Copyright (c) 2015 Alexander Goddijn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudinaryFactory.h"

@implementation CloudinaryFactory

+ (CLUploader*)create:(CLCloudinary *)cl delegate:(id <CLUploaderDelegate> )delegate
{
    return [[CLUploader alloc] init:cl delegate:delegate];
}

@end