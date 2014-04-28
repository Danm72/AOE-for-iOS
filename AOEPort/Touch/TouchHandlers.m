//
// Created by Dan Malone on 18/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TouchHandlers.h"
#import "Builder.h"
#import "Building.h"
#import "DrawSelectionBox.h"

@implementation TouchHandlers {

    SKNode *_worldNode_firstLayer;
    TileMapLayer *_bgLayer;
    TileMapLayer *_buildingLayer_secondLayer;
//    JSTileMap *_tileMap_thirdLayer;
    BOOL unitNode;
    BOOL buildingNode;
@private
    DrawSelectionBox *_selectionBox;
}

@synthesize selectionBox = _selectionBox;

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
        _selectedNodes = [NSMutableArray array];

    }

    return self;
}

- (void)registerTouchEvents {
    [self didMoveToView];
}

- (void)passPointers:(SKNode *)worldNode :(TileMapLayer *)bgLayer :(TileMapLayer *)buildingLayer {
    _worldNode_firstLayer = worldNode;
    _bgLayer = bgLayer;
    _buildingLayer_secondLayer = buildingLayer;
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

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (previousScale > 0)
            recognizer.scale = previousScale;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat scaleDifference = recognizer.scale - lastScale;
        CGFloat heightDifference = scene.size.height * scaleDifference;
        CGFloat widthDifference = scene.size.width * scaleDifference;
        CGSize potentialSize = CGSizeMake(scene.size.width + widthDifference, scene.size.height + heightDifference);

        if ((potentialSize.width < 3200 && potentialSize.height < 3200) && (potentialSize.width > 0 && potentialSize.height > 0)) {
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
//        touchLocation = [scene convertPoint:touchLocation toNode:_buildingLayer_secondLayer];
        touchLocation = [scene convertPoint:touchLocation toNode:_worldNode_firstLayer];

        CGPoint newPos = CGPointMake(touchLocation.x, touchLocation.y);

//        if (pointOne.x == 0) {
//            pointOne = newPos;
//            isSelecting = true;
//        }
/*        else if (pointTwo.x == 0) {
            pointTwo = newPos;

            CGSize size = CGSizeMake((pointOne.x - pointTwo.x), (pointOne.y - pointTwo.y));

            selectionBox = [DrawSelectionBox attachDebugRectWithSize:size :_worldNode_firstLayer :newPos];

            [_worldNode_firstLayer addChild:selectionBox];
            pointOne.x = 0;
            pointTwo.x = 0;
            isSelecting = false;
        }*/

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


/*    if (pointOne.x == 0) {
        pointOne = newPos;
    } else if (pointTwo.x == 0) {
        pointTwo = newPos;

        CGSize size = CGSizeMake((pointOne.x - pointTwo.x), (pointOne.y - pointTwo.y));

        selectionBox = [DrawSelectionBox attachDebugRectWithSize:size :_worldNode_firstLayer :newPos];

        [_worldNode_firstLayer addChild:selectionBox];
        pointOne.x = 0;
        pointTwo.x = 0;
    }*/

    if (recognizer.state == UIGestureRecognizerStateBegan) {
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {

        for (SKSpriteNode *node in _selectedNodes) {
            unitNode = [[node name] isEqualToString:unitNodeType];
            if (unitNode) {
                [((Unit *) node) move:newPos];
            }
//            [_selectedNodes removeObject:node];
        }
    }

}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    NSDate *start = [NSDate date];
    // do stuff...

    if (recognizer.state == UIGestureRecognizerStateBegan) {


    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        // CGPoint velocity = [recognizer velocityInView:scene.view];
        translation = CGPointMake(translation.x, -translation.y);


        if (isSelecting) {
            [_selectionBox expandSelectionBox:translation];

        } else {
            [self panForTranslation:translation];
        }


        [recognizer setTranslation:CGPointZero inView:recognizer.view];


    } else if (recognizer.state == UIGestureRecognizerStateEnded) {


        if ([_selectedNodes count] != 0) {

            for (SKSpriteNode *node in _selectedNodes) {
                [self removeBuildingActions:node];
            }
        }
        [self resetSelectionBox];
    }
}


- (void)resetSelectionBox {
    pointOne.x = 0;
    pointTwo.x = 0;
    isSelecting = false;
    [_selectionBox removeFromParent];
}

- (void)removeBuildingActions:(SKSpriteNode *)node {
    buildingNode = [[node name] isEqualToString:buildingNodeType];
    if (buildingNode) {
                    SKAction *returnToRegularRotation = [SKAction rotateToAngle:0.0f duration:0.1];
                    SKAction *returnToRegularColour = [SKAction colorizeWithColorBlendFactor:0.0 duration:0.0];

                    SKAction *returnToNormalSequence = [SKAction sequence:@[
                            returnToRegularColour, returnToRegularRotation]];

                    [node removeAllActions];

                    [node runAction:returnToNormalSequence];

                    [_selectedNodes removeAllObjects];
                }
}


- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode;


    if ([[_buildingLayer_secondLayer nodeAtPoint:touchLocation] isKindOfClass:[Building class]]) {
        touchedNode = (Building *) [_buildingLayer_secondLayer nodeAtPoint:touchLocation];
    } else if ([[_worldNode_firstLayer nodeAtPoint:touchLocation] isKindOfClass:[Unit class]]) {
        touchedNode = (Unit *) [_worldNode_firstLayer nodeAtPoint:touchLocation];
    }

    //2
    if (![_selectedNodes isEqual:touchedNode]) {

        if (touchedNode != nil) {
            [_selectedNodes addObject:touchedNode];

            //3
            buildingNode = [[touchedNode name] isEqualToString:buildingNodeType];
            unitNode = [[touchedNode name] isEqualToString:unitNodeType];

            if (buildingNode) {
                SKAction *sequence = [Building selectedBuildingAction];
                for (SKSpriteNode *node in _selectedNodes) {

                    [node runAction:[SKAction repeatActionForever:sequence]];
                }
            } else if (unitNode) {

            }
        } else {
            if (pointOne.x == 0) {
                pointOne = touchLocation;
                isSelecting = true;

                CGSize size = CGSizeMake((0), (0));

//                self.selectionBox = [DrawSelectionBox addSelectionBox:size :touchLocation];

                self.selectionBox = [[DrawSelectionBox alloc] initWithPointAndSize:touchLocation :size];
                [_worldNode_firstLayer addChild:self.selectionBox];

            }
        }

    }

}


CGPoint mult(const CGPoint v, const CGFloat s) {
    return CGPointMake(v.x * s, v.y * s);
}

- (void)panForTranslation:(CGPoint)translation {

    if ([_selectedNodes count] > 0) {
        for (SKSpriteNode *node in _selectedNodes) {
            [self moveBuilding:translation node:node];
        }
    } else {
        CGPoint newPos = CGPointMake(-translation.x, -translation.y);

        newPos = [scene convertPoint:newPos toNode:_worldNode_firstLayer];

        [self centerViewOn:newPos];

    }
}

- (void)moveBuilding:(CGPoint)translation node:(SKSpriteNode *)node {
    if ([[node name] isEqualToString:buildingNodeType]) {

        CGPoint position = [node position];
        CGFloat z = _buildingLayer_secondLayer.layerSize.height - node.position.y;

        [node setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        [node setZPosition:(z)];

    }
}


- (void)centerViewOn:(CGPoint)centerOn {
    _worldNode_firstLayer.position = [self pointToCenterViewOn:centerOn :_bgLayer];
//    _worldNode_firstLayer.position = cent
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