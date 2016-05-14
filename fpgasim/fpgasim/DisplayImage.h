//
//  DisplayImage.h
//  fpgasim
//
//  Created by Lawrence Kesteloot on 5/13/16.
//  Copyright © 2016 Earwig, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface DisplayImage : NSObject

- (NSImage *)swapBuffers;
- (void)clear;

@end
