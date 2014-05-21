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

@synthesize builderWalk;
@synthesize builderIdle;
@synthesize builderBuild;
@synthesize tiles;
@synthesize trees;
@synthesize buildings;
@synthesize resources;

@synthesize idleTextures;
@synthesize buildTextures;


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
