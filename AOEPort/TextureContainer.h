//
//  TextureContainer.h
//  AOEPort
//
//  Created by Dan Malone on 17/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextureContainer : NSObject
@property(nonatomic,retain)NSString *str;

@property(strong,retain)SKTextureAtlas *builderWalk;
@property(strong,retain)SKTextureAtlas *builderIdle;
@property(strong,retain)SKTextureAtlas *builderBuild;
@property(strong,retain)SKTextureAtlas *tiles;
@property(strong,retain)SKTextureAtlas *trees;
@property(strong,retain)SKTextureAtlas *buildings;
@property(strong,retain)SKTextureAtlas *resources;
//@property(nonatomic,retain)SKTextureAtlas *trees;





+(TextureContainer*)getInstance;
@end

