//
//  DisplayImage.m
//  fpgasim
//
//  Created by Lawrence Kesteloot on 5/13/16.
//  Copyright © 2016 Earwig, Inc. All rights reserved.
//

#import "DisplayImage.h"

#define WIDTH 800
#define HEIGHT 600
#define TILE 50

@interface DisplayImage () {
    // We're displaying the front buffer;
    NSImage *frontBuffer;

    // We're drawing in the back buffer.
    NSImage *backBuffer;
}

@end

@implementation DisplayImage

- (id)init {
    self = [super init];

    if (self) {
	frontBuffer = [[NSImage alloc] initWithSize:NSMakeSize(WIDTH, HEIGHT)];
	backBuffer = [[NSImage alloc] initWithSize:NSMakeSize(WIDTH, HEIGHT)];
    }

    return self;
}

- (NSColor *)colorFromBuffer:(vec3ub)color {
    return [NSColor colorWithRed:color[0]/255.0 green:color[1]/255.0 blue:color[2]/255.0 alpha:1.0];
}

// Returns new front buffer.
- (NSImage *)swapBuffers {
    NSImage *tmp = backBuffer;
    backBuffer = frontBuffer;
    frontBuffer = tmp;

    // We'll eventually want to remove this, since the hardware won't do it:
    [self fillCheckerboard];

    return frontBuffer;
}

- (void)fillCheckerboard {
    @autoreleasepool {
    [backBuffer lockFocus];
    NSRect rect = NSMakeRect(0, 0, backBuffer.size.width, backBuffer.size.height);
    [[NSColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] set];
    NSRectFill(rect);

    [[NSColor colorWithRed:.6 green:.6 blue:.6 alpha:1.0] set];
    for (int y = 0; y < rect.size.height/TILE; y++) {
	for (int x = 0; x < rect.size.width/TILE; x++) {
	    if ((x + y) % 2 == 0) {
		NSRect tile = NSMakeRect(x*TILE, y*TILE, 50, 50);
		NSRectFill(tile);
	    }
	}
    }
    [backBuffer unlockFocus];
    }
}

- (void)clear:(vec3ub)color {
    @autoreleasepool {
    [backBuffer lockFocus];
    NSRect rect = NSMakeRect(0, 0, backBuffer.size.width, backBuffer.size.height);
    [[self colorFromBuffer:color] set];
    NSRectFill(rect);
    [backBuffer unlockFocus];
    }
}

@end
