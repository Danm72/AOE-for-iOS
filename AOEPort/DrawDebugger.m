//
// Created by Dan Malone on 25/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "DrawDebugger.h"
#import "Constants.h"

@implementation DrawDebugger {

}

+ (void)attachDebugFrameFromPath:(CGPathRef)bodyPath:(SKSpriteNode*) node {
//1
    if (kDebugDraw == NO) return; //2
    SKShapeNode *shape = [SKShapeNode node];
//3
    shape.path = bodyPath;
    shape.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0
                                        alpha:0.5];
    shape.lineWidth = 1.0;
//4
    [node addChild:shape];
}

+ (void)attachDebugRectWithSize:(CGSize)s:(SKSpriteNode*) node {
    CGPathRef bodyPath = CGPathCreateWithRect(CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height), nil);
    [DrawDebugger attachDebugFrameFromPath:bodyPath:node];
    CGPathRelease(bodyPath);
}
@end