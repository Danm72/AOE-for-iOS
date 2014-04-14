//
// Created by Dan Malone on 18/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TouchHandlers.h"
#import "Builder.h"
#import "Building.h"

@implementation TouchHandlers {

    SKNode *_worldNode_firstLayer;
    TileMapLayer *_bgLayer;
    TileMapLayer *_buildingLayer_secondLayer;
    JSTileMap *_tileMap_thirdLayer;
    BOOL unitNode;
    BOOL buildingNode;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
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
    _worldNode_firstLayer = worldNode;
    _bgLayer = bgLayer;
    _buildingLayer_secondLayer = buildingLayer;
    _tileMap_thirdLayer = tileMap;
}

- (void)didMoveToView {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[scene view] addGestureRecognizer:panGestureRecognizer];

    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
    [[scene view] addGestureRecognizer:pinchGestureRecognizer];

//    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
//    [[scene view] addGestureRecognizer:rotationGestureRecognizer];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
    longPressGestureRecognizer.minimumPressDuration = 0.25;
    [[scene view] addGestureRecognizer:longPressGestureRecognizer];
    [longPressGestureRecognizer setDelegate:self];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [[scene view] addGestureRecognizer:tapGestureRecognizer];

}

- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer {
    static CGFloat lastScale = 0;
    static CGFloat previousScale = 0;

//    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
//    recognizer.scale = 1;

    // [_worldNode_firstLayer runAction:[SKAction scaleTo:recognizer.velocity/1000 duration:5.0]];
    // [_worldNode_firstLayer runAction:[SKAction scaleTo:.75 duration:5.0]];

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
            NSLog(@"Scale : %f, Size x: %f, Size x: %f", recognizer.scale, scene.size.width, scene.size.height);
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        previousScale = recognizer.scale;
    }
}

- (void)handleRotationFrom:(UIRotationGestureRecognizer *)recognizer {
//    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
//    recognizer.rotation = 0;
}

- (void)handleLongPressFrom:(UILongPressGestureRecognizer *)recognizer {
    //  recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
//    recognizer.rotation = 0;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchLocation = [recognizer locationInView:(scene.view)];

        touchLocation = [scene convertPointFromView:touchLocation];
        touchLocation = [scene convertPoint:touchLocation toNode:_worldNode_firstLayer];

        [self selectNodeForTouch:touchLocation];
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {

    }
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {

    CGPoint touchLocation = [recognizer locationInView:(scene.view)];

    touchLocation = [scene convertPointFromView:touchLocation];
    touchLocation = [scene convertPoint:touchLocation toNode:_worldNode_firstLayer];

    CGPoint newPos = CGPointMake(touchLocation.x, touchLocation.y);


    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //   _selectedNode = nil;
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        unitNode = [[_selectedNode name] isEqualToString:unitNodeType];
        if (unitNode) {
            [((Unit *)_selectedNode) move:newPos];
        }
        // _selectedNode = nil;
    }

}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    NSDate *start = [NSDate date];
    // do stuff...

    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        CGPoint touchLocation = [recognizer locationInView:(scene.view)];
//        NSLog(@"Touch1 X: %f, Y : %f", touchLocation.x, touchLocation.y);
//
//        touchLocation = [scene convertPointFromView:touchLocation];
//        touchLocation = [scene convertPoint:touchLocation toNode:_worldNode_firstLayer];

        //   [self selectNodeForTouchRemoveSelection:touchLocation];

    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        // CGPoint velocity = [recognizer velocityInView:scene.view];
        translation = CGPointMake(translation.x, -translation.y);

        // translation = [self convertPoint:translation toNode:_worldNode_firstLayer];

//        NSLog(@"Drag X: %f, Y : %f", translation.x, translation.y);

        [self panForTranslation:translation];

        // [self centerViewOn:translation];

        [recognizer setTranslation:CGPointZero inView:recognizer.view];


    } else if (recognizer.state == UIGestureRecognizerStateEnded) {


        if (_selectedNode != nil) {
/*
            unitNode = [[_selectedNode name] isEqualToString:unitNodeType];
            if (unitNode) {
                SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Builder_walk"];

                if (newPos.y > _selectedNode.position.y)
                    [(Builder *) _selectedNode animateWalk:atlas :NORTH];
                if (newPos.y < _selectedNode.position.y)
                    [(Builder *) _selectedNode animateWalk:atlas :SOUTH];

                SKAction *moveTo = [SKAction moveTo:newPos duration:scrollDuration];
                [moveTo setTimingMode:SKActionTimingEaseOut];
                [_selectedNode runAction:moveTo];

            }*/

            buildingNode = [[_selectedNode name] isEqualToString:buildingNodeType];
            if (buildingNode) {
                SKAction *returnToRegularRotation = [SKAction rotateToAngle:0.0f duration:0.1];
                SKAction *returnToRegularColour = [SKAction colorizeWithColorBlendFactor:0.0 duration:0.0];

                SKAction *returnToNormalSequence = [SKAction sequence:@[
                        returnToRegularColour, returnToRegularRotation]];

                [_selectedNode removeAllActions];

                [_selectedNode runAction:returnToNormalSequence];

                _selectedNode = nil;
            }

        }

    }
}


- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode;

    /*   BOOL nodeIsABuilding = [touchedNode.name isEqualToString:buildingNodeType];
       BOOL nodeIsAUnit = [touchedNode.name isEqualToString:unitNodeType];
       //BOOL nodeIsATile = [touchedNode.name isEqualToString:tileNodeType];


       BOOL nodeIsATile = (touchedNode = (SKSpriteNode *) [_buildingLayer_secondLayer nodeAtPoint:touchLocation]).name == nil;
       BOOL nodeIsNotTile = (touchedNode = (SKSpriteNode *) [_worldNode_firstLayer nodeAtPoint:touchLocation]).name == unitNodeType;*/

    if (touchedNode == nil) {
        touchedNode = (SKSpriteNode *) [_worldNode_firstLayer nodeAtPoint:touchLocation];
    }
    if (touchedNode == nil) {
        touchedNode = (SKSpriteNode *) [_buildingLayer_secondLayer nodeAtPoint:touchLocation];
    }
    if (touchedNode == nil) {
        touchedNode = (SKSpriteNode *) [_tileMap_thirdLayer nodeAtPoint:touchLocation];
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
        buildingNode = [[touchedNode name] isEqualToString:buildingNodeType];
        if (buildingNode) {
            SKAction *sequence= [Building selectedBuildingAction];

            [_selectedNode runAction:[SKAction repeatActionForever:sequence]];
        }
        unitNode = [[touchedNode name] isEqualToString:unitNodeType];

        if (unitNode) {
        }

    }

}



CGPoint mult(const CGPoint v, const CGFloat s) {
    return CGPointMake(v.x * s, v.y * s);
}

- (void)panForTranslation:(CGPoint)translation {
   SKSpriteNode * parent = [_selectedNode parent];
    CGPoint position = [_selectedNode position];
    CGFloat z = _tileMap_thirdLayer.yScale - position.y;

    if ([[_selectedNode name] isEqualToString:buildingNodeType]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
//        [_selectedNode setZPosition:(z)];

    } else {
        CGPoint newPos = CGPointMake(-translation.x, -translation.y);

        newPos = [scene convertPoint:newPos toNode:_worldNode_firstLayer];

        //_worldNode_firstLayer.position = [self centerViewOn:newPos];

        [self centerViewOn:newPos];
    }
}


- (void)centerViewOn:(CGPoint)centerOn {
    _worldNode_firstLayer.position = [self pointToCenterViewOn:centerOn :_bgLayer];
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