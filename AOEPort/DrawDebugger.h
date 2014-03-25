//
// Created by Dan Malone on 25/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawDebugger : SKSpriteNode
+ (void)attachDebugFrameFromPath:(CGPathRef)bodyPath :(SKSpriteNode *)node;

+ (void)attachDebugRectWithSize:(CGSize)s :(SKSpriteNode *)node;
@end