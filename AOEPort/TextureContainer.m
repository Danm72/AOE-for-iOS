//
//  TextureContainer.m
//  AOEPort
//
//  Created by Dan Malone on 17/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TextureContainer.h"

@implementation TextureContainer

@synthesize str;

static TextureContainer *instance = nil;

+(TextureContainer *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            NSLog(@"TEXCON CALLED");
            instance= [TextureContainer new];
        }
    }
    return instance;
}

@end
