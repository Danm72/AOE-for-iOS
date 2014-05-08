//
// Created by Dan Malone on 18/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TouchHandlers.h"
#import "Builder.h"
#import "Building.h"

int signum(CGFloat n) {
    return (n < 0) ? -1 : (n > 0) ? +1 : 0;
}


@interface TouchHandlers ()

@property(nonatomic, strong) SKNode *worldNode;
@property(nonatomic, strong) TileMapLayer *bgLayer;
@property(nonatomic, strong) TileMapLayer *buildingLayer;
@property(nonatomic, strong) SKNode *unitLayer;
@property(nonatomic) BOOL unitNode;
@property(nonatomic) BOOL buildingNode;
@property(nonatomic) CGPoint pointTwo;
@property(nonatomic) CGPoint pointOne;
@property(nonatomic, strong) SKScene *scene;
@property(nonatomic) BOOL isSelecting;
@property(nonatomic) CGPoint previousLocation;
@end

@implementation TouchHandlers

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
        self.scene = scene1;
        _selectedNodes = [NSMutableArray array];
    }

    return self;
}

- (void)registerTouchEvents {
    [self didMoveToView];
}

- (void)passPointers:(SKNode *)worldNode :(TileMapLayer *)bgLayer :(TileMapLayer *)buildingLayer :(SKNode *)unitLayer {
    _worldNode = worldNode;
    _bgLayer = bgLayer;
    _buildingLayer = buildingLayer;
    _unitLayer = unitLayer;
}

- (void)didMoveToView {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self.scene view] addGestureRecognizer:panGestureRecognizer];

    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
    [[self.scene view] addGestureRecognizer:pinchGestureRecognizer];

//    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
//    [[scene view] addGestureRecognizer:rotationGestureRecognizer];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
    longPressGestureRecognizer.minimumPressDuration = 0.25;
    [[self.scene view] addGestureRecognizer:longPressGestureRecognizer];
    [longPressGestureRecognizer setDelegate:self];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [[self.scene view] addGestureRecognizer:tapGestureRecognizer];

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
        CGFloat heightDifference = self.scene.size.height * scaleDifference;
        CGFloat widthDifference = self.scene.size.width * scaleDifference;
        CGSize potentialSize = CGSizeMake(self.scene.size.width + widthDifference, self.scene.size.height + heightDifference);

        if (potentialSize.width > 0 && potentialSize.height > 0) {

            if (potentialSize.width > 3200) {
                potentialSize.width = 3200;
            } else {
                potentialSize.width = potentialSize.width;
            }

            if (potentialSize.height > 3200) {
                potentialSize.height = 3200;
            } else {
                potentialSize.height = potentialSize.height;
            }
            lastScale = recognizer.scale;
            self.scene.size = potentialSize;

        }
//        if ((potentialSize.width < 3200 && potentialSize.height < 3200) && ()) {
//            self.scene.size = potentialSize;
//            lastScale = recognizer.scale;
//
//            NSLog(@"Scale : %f, Size x: %f, Size x: %f", recognizer.scale, self.scene.size.width, self.scene.size.height);
//        }
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
    //recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    //recognizer.rotation = 0;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [_selectedNodes removeAllObjects];

        CGPoint touchLocation = [recognizer locationInView:(self.scene.view)];

        touchLocation = [self.scene convertPointFromView:touchLocation];
//        touchLocation = [scene convertPoint:touchLocation toNode:buildingLayer];
        touchLocation = [self.scene convertPoint:touchLocation toNode:_worldNode];

        [self selectNodeForTouch:touchLocation];
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {

    }
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {

    CGPoint touchLocation = [recognizer locationInView:(self.scene.view)];

    touchLocation = [self.scene convertPointFromView:touchLocation];
    touchLocation = [self.scene convertPoint:touchLocation toNode:_worldNode];

    CGPoint newPos = CGPointMake(touchLocation.x, touchLocation.y);


/*    if (pointOne.x == 0) {
        pointOne = newPos;
    } else if (pointTwo.x == 0) {
        pointTwo = newPos;

        CGSize size = CGSizeMake((pointOne.x - pointTwo.x), (pointOne.y - pointTwo.y));

        selectionBox = [DrawSelectionBox attachDebugRectWithSize:size :worldNode :newPos];

        [worldNode addChild:selectionBox];
        pointOne.x = 0;
        pointTwo.x = 0;
    }*/

    if (recognizer.state == UIGestureRecognizerStateBegan) {
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {

        for (SKSpriteNode *node in _selectedNodes) {
            self.unitNode = [[node name] isEqualToString:unitNodeType];
            if (self.unitNode) {
                [((Unit *) node) move:newPos];
            }
//            [_selectedNodes removeObject:node];
        }
    }

}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
//    NSDate *start = [NSDate date];
    // do stuff...

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _previousLocation = [recognizer translationInView:_worldNode.scene.view];

    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:_worldNode.scene.view];
        //CGPoint velocity = [recognizer velocityInView:scene.view];
        //translation = CGPointMake(translation.x, -translation.y);

        translation = [recognizer translationInView:_worldNode.scene.view];

        /*       CGFloat p1;
               CGFloat p2;

               if (signum(_previousLocation.x) > 0 && signum(translation.x) > 0) {
                   p1 = _previousLocation.x + translation.x;
               }else if (signum(_previousLocation.x) < 0 && signum(translation.x) < 0) {
                   p1 = _previousLocation.x - translation.x;
               }else if (signum(_previousLocation.x) > 0 && signum(translation.x) < 0) {
                   p1 = _previousLocation.x + translation.x;
               }

               if (signum(_previousLocation.y) > 0 && signum(translation.y) > 0) {
                   p2 = _previousLocation.y + translation.y;
               }else if (signum(_previousLocation.y) < 0 && signum(translation.y) < 0) {
                   p2 = _previousLocation.y - translation.y;
               }else if (signum(_previousLocation.y) > 0 && signum(translation.y) < 0) {
                   p2 = _previousLocation.y + translation.y;
               }*/


        translation = CGPointMake(translation.x * 4,
                -translation.y * 4);

        //  translation = CGPointMake(p1, p2);
        if (self.isSelecting) {
            [self.selectionBox expandSelectionBox:translation];

        } else {
            [self panForTranslation:translation];
        }

        [recognizer setTranslation:CGPointZero inView:recognizer.view];

    }

    else if (recognizer.state == UIGestureRecognizerStateEnded) {


        if ([_selectedNodes count] != 0) {

            for (SKSpriteNode *node in _selectedNodes) {
                [self removeBuildingActions:node];
            }
        }
        [self resetSelectionBox];
    }
}


- (void)resetSelectionBox {
    _pointOne.x = 0;
    _pointTwo.x = 0;
    _isSelecting = false;
    [_selectionBox removeFromParent];
//    [_selectedNodes removeAllObjects];

}

- (void)removeBuildingActions:(SKSpriteNode *)node {
    self.buildingNode = [[node name] isEqualToString:buildingNodeType];
    if (self.buildingNode) {
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


    if ([[_buildingLayer nodeAtPoint:touchLocation] isKindOfClass:[Building class]]) {
        touchedNode = (Building *) [_buildingLayer nodeAtPoint:touchLocation];
    } else if ([[_unitLayer nodeAtPoint:touchLocation] isKindOfClass:[Unit class]]) {
        touchedNode = (Unit *) [_unitLayer nodeAtPoint:touchLocation];
    }

    //2
    if (![_selectedNodes isEqual:touchedNode]) {

        if (touchedNode != nil) {
            [_selectedNodes addObject:touchedNode];

            //3
            self.buildingNode = [[touchedNode name] isEqualToString:buildingNodeType];
            self.unitNode = [[touchedNode name] isEqualToString:unitNodeType];

            if (self.buildingNode) {
                SKAction *sequence = [Building selectedBuildingAction];
                for (SKSpriteNode *node in _selectedNodes) {

                    [node runAction:[SKAction repeatActionForever:sequence]];
                }
            } else if (self.unitNode) {

            }
        } else {
            if (self.pointOne.x == 0) {
                self.pointOne = touchLocation;
                self.isSelecting = true;

                CGSize size = CGSizeMake((0), (0));

//                self.selectionBox = [DrawSelectionBox addSelectionBox:size :touchLocation];

                self.selectionBox = [[DrawSelectionBox alloc] initWithPointAndSize:touchLocation :size];
                [_worldNode addChild:self.selectionBox];
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

        newPos = [self.scene convertPoint:newPos toNode:_worldNode];

        [self centerViewOn:newPos];

    }
}

- (void)moveBuilding:(CGPoint)translation node:(SKSpriteNode *)node {
    if ([[node name] isEqualToString:buildingNodeType]) {

        CGPoint position = [node position];

        [node setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        CGFloat previousz = node.zPosition;

        CGFloat z = _buildingLayer.layerSize.height - node.position.y;

        [node setZPosition:(z)];

    }
}


- (void)centerViewOn:(CGPoint)centerOn {
    _worldNode.position = [self pointToCenterViewOn:centerOn :_bgLayer];
//    worldNode.position = cent
}

- (CGPoint)pointToCenterViewOn:(CGPoint)centerOn :(TileMapLayer *)layer {
    CGSize size = self.scene.size;

    CGFloat x = Clamp(centerOn.x, size.width / 2,
            layer.layerSize.width - size.width / 2);

    CGFloat y = Clamp(centerOn.y, size.height / 2,
            layer.layerSize.height - size.height / 2);

    return CGPointMake(-x, -y);
}

@end