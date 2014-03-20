//
// Created by Dan Malone on 18/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TouchHandlers.h"


@implementation TouchHandlers {
    SKNode *_worldNode;
    TileMapLayer *_bgLayer;
    TileMapLayer *_buildingLayer;
    JSTileMap *_tileMap;
}

- (instancetype)initWithScene:(SKScene *)scene1 {
    self = [super init];
    if (self) {
        scene = scene1;
    }

    return self;
}

- (void)registerTouchEvents {
    [self didMoveToView];
}

- (void)passPointers:(SKNode *)worldNode :(TileMapLayer *)bgLayer :(TileMapLayer *)buildingLayer :(JSTileMap *)tileMap {
    _worldNode = worldNode;
    _bgLayer = bgLayer;
    _buildingLayer = buildingLayer;
    _tileMap = tileMap;
}

- (void)didMoveToView {

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[scene view] addGestureRecognizer:panGestureRecognizer];

    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
    [[scene view] addGestureRecognizer:pinchGestureRecognizer];

//    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
//    [[self view] addGestureRecognizer:rotationGestureRecognizer];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
    // longPressGestureRecognizer.minimumPressDuration = 1.0;
    [[scene view] addGestureRecognizer:longPressGestureRecognizer];
}


- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer {
    static CGFloat lastScale = 0;
    static CGFloat previousScale = 0;

//    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
//    recognizer.scale = 1;

    // [_worldNode runAction:[SKAction scaleTo:recognizer.velocity/1000 duration:5.0]];
    // [_worldNode runAction:[SKAction scaleTo:.75 duration:5.0]];

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (previousScale > 0)
            recognizer.scale = previousScale;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat scaleDifference = recognizer.scale - lastScale;
        CGFloat heightDifference = scene.size.height * scaleDifference;
        CGFloat widthDifference = scene.size.width * scaleDifference;
        CGSize potentialSize = CGSizeMake(scene.size.width + widthDifference, scene.size.height + heightDifference);

        if (potentialSize.width < 3200 && potentialSize.height < 3200) {
            scene.size = potentialSize;
            lastScale = recognizer.scale;
            NSLog(@"Scale : %f, Size: %f", recognizer.scale, scene.size.width);
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        previousScale = recognizer.scale;
    }
}

- (void)handleRotationFrom:(UIRotationGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;

}

- (void)handleLongPressFrom:(UILongPressGestureRecognizer *)recognizer {
    //  recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
//    recognizer.rotation = 0;
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint touchLocation = [recognizer locationInView:(scene.view)];

        touchLocation = [scene convertPointFromView:touchLocation];
        touchLocation = [scene convertPoint:touchLocation toNode:_worldNode];

        [self selectNodeForTouch:touchLocation];
    }
}


- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    NSDate *start = [NSDate date];
    // do stuff...

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchLocation = [recognizer locationInView:(scene.view)];
        NSLog(@"Touch1 X: %f, Y : %f", touchLocation.x, touchLocation.y);

        touchLocation = [scene convertPointFromView:touchLocation];
        touchLocation = [scene convertPoint:touchLocation toNode:_worldNode];

        [self selectNodeForTouchRemoveSelection:touchLocation];

    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        NSTimeInterval timeInterval = [start timeIntervalSinceNow];

        CGPoint translation = [recognizer translationInView:recognizer.view];

        translation = CGPointMake(translation.x, -translation.y);

        // translation = [self convertPoint:translation toNode:_worldNode];

        NSLog(@"Drag X: %f, Y : %f", translation.x, translation.y);

        [self panForTranslation:translation];

        // [self centerViewOn:translation];

        [recognizer setTranslation:CGPointZero inView:recognizer.view];


    } else if (recognizer.state == UIGestureRecognizerStateEnded) {

        if (![[_selectedNode name] isEqualToString:buildingNodeType]) {
            float scrollDuration = 0.2;
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            CGPoint pos = [_selectedNode position];
            CGPoint p = mult(velocity, scrollDuration);

            CGPoint newPos = CGPointMake(pos.x + p.x, pos.y + p.y);
            NSLog(@"End Position X: %f, Y : %f", newPos.x, newPos.y);


            SKAction *moveTo = [SKAction moveTo:newPos duration:scrollDuration];
            [moveTo setTimingMode:SKActionTimingEaseOut];

            [_selectedNode removeAllActions];
//
            SKAction *returnToRegularRotation = [SKAction rotateToAngle:0.0f duration:0.1];
            SKAction *returnToRegularColour = [SKAction colorizeWithColorBlendFactor:0.0 duration:0.0];

            SKAction *returnToNormalSequence = [SKAction sequence:@[
                    returnToRegularColour, returnToRegularRotation]];

            [_selectedNode runAction:returnToNormalSequence];
            _selectedNode = nil;

        } else {
            [_selectedNode removeAllActions];
        }

    }
}

- (void)selectNodeForTouchRemoveSelection:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode;

    BOOL nodeIsATile = (touchedNode = (SKSpriteNode *) [_buildingLayer nodeAtPoint:touchLocation]).name == nil;
    if (nodeIsATile) {
        touchedNode = (SKSpriteNode *) [_tileMap nodeAtPoint:touchLocation];
    }

    //2
    if (![_selectedNode isEqual:touchedNode]) {
/*        [_selectedNode removeAllActions];

        SKAction *returnToRegularRotation = [SKAction rotateToAngle:0.0f duration:0.1];
        SKAction *returnToRegularColour = [SKAction colorizeWithColorBlendFactor:0.0 duration:0.0];

        SKAction *returnToNormalSequence = [SKAction sequence:@[
                returnToRegularColour, returnToRegularRotation]];

        [_selectedNode runAction:returnToNormalSequence];*/

        _selectedNode = touchedNode;
    }

}


- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode;

    BOOL nodeIsATile = (touchedNode = (SKSpriteNode *) [_buildingLayer nodeAtPoint:touchLocation]).name == nil;
    if (nodeIsATile) {
        touchedNode = (SKSpriteNode *) [_tileMap nodeAtPoint:touchLocation];
    }

    //2
    if (![_selectedNode isEqual:touchedNode]) {
/*        [_selectedNode removeAllActions];

        SKAction *returnToRegularRotation = [SKAction rotateToAngle:0.0f duration:0.1];
        SKAction *returnToRegularColour = [SKAction colorizeWithColorBlendFactor:0.0 duration:0.0];

        SKAction *returnToNormalSequence = [SKAction sequence:@[
                returnToRegularColour, returnToRegularRotation]];

        [_selectedNode runAction:returnToNormalSequence];*/

        _selectedNode = touchedNode;

        //3
        if ([[touchedNode name] isEqualToString:buildingNodeType]) {
            SKAction *pulseGreen = [SKAction sequence:@[
                    [SKAction colorizeWithColor:[SKColor greenColor] colorBlendFactor:1.0 duration:0.15],
                    [SKAction waitForDuration:0.1],
                    [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];

            SKAction *rotate = [SKAction sequence:@[
                    [SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
                    [SKAction rotateByAngle:0.0 duration:0.1],
                    [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];

            SKAction *sequence = [SKAction sequence:@[
                    rotate, pulseGreen]];

            [_selectedNode runAction:[SKAction repeatActionForever:sequence]];
        }
    }

}

CGPoint mult(const CGPoint v, const CGFloat s) {
    return CGPointMake(v.x * s, v.y * s);
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    if ([[_selectedNode name] isEqualToString:buildingNodeType]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    } else {
        CGPoint newPos = CGPointMake(-translation.x, -translation.y);

        newPos = [scene convertPoint:newPos toNode:_worldNode];

        //_worldNode.position = [self centerViewOn:newPos];

        [self centerViewOn:newPos];
    }
}

float degToRad(float degree) {
    return degree / 180.0f * M_PI;
}

- (void)centerViewOn:(CGPoint)centerOn {
    _worldNode.position = [self pointToCenterViewOn:centerOn :_bgLayer];
}

- (CGPoint)pointToCenterViewOn:(CGPoint)centerOn :(TileMapLayer *)layer {
    CGSize size = scene.size;

    CGFloat x = Clamp(centerOn.x, size.width / 2,
            layer.layerSize.width - size.width / 2);

    CGFloat y = Clamp(centerOn.y, size.height / 2,
            layer.layerSize.height - size.height / 2);

    return CGPointMake(-x, -y);
}

@end