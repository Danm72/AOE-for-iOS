//
// Created by Dan Malone on 18/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TouchHandlers.h"
#import "Builder.h"
#import "Building.h"
#import "MyScene.h"


@interface TouchHandlers ()

//@property(nonatomic, strong) SKNode *worldNode;
//@property(nonatomic, strong) TileMapLayer *bgLayer;
//@property(nonatomic, strong) TileMapLayer *buildingLayer;
//@property(nonatomic, strong) SKNode *unitLayer;
@property(nonatomic) BOOL unitNode;
@property(nonatomic) BOOL buildingNode;
@property(nonatomic) CGPoint pointTwo;
@property(nonatomic) CGPoint pointOne;
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


- (instancetype)initWithScene:(MyScene *)scene1 {
    self = [super init];
    if (self) {
        _selectedNodes = [NSMutableArray array];
        _scene = scene1;
    }

    return self;
}

- (void)registerTouchEvents {
    [self didMoveToView];
}

/*- (void)passPointers:(SKNode *)worldNode :(TileMapLayer *)bgLayer :(TileMapLayer *)buildingLayer :(SKNode *)unitLayer {
    _worldNode = worldNode;
    _bgLayer = bgLayer;
    _buildingLayer = buildingLayer;
    _unitLayer = unitLayer;
}*/

- (void)didMoveToView {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[_scene view] addGestureRecognizer:panGestureRecognizer];

    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
    [[_scene view] addGestureRecognizer:pinchGestureRecognizer];

//    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
//    [[scene view] addGestureRecognizer:rotationGestureRecognizer];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
    longPressGestureRecognizer.minimumPressDuration = 0.15;
    [[_scene view] addGestureRecognizer:longPressGestureRecognizer];
    [longPressGestureRecognizer setDelegate:self];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [[_scene view] addGestureRecognizer:tapGestureRecognizer];

    UIScreenEdgePanGestureRecognizer *leftEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftEdgeGesture:)];
    leftEdgePanGestureRecognizer.edges = UIRectEdgeLeft;
//    leftEdgePanGestureRecognizer.delegate = self;
    [[_scene view] addGestureRecognizer:leftEdgePanGestureRecognizer];

    UIScreenEdgePanGestureRecognizer *rightEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightEdgeGesture:)];
    rightEdgePanGestureRecognizer.edges = UIRectEdgeRight;
    [[_scene view] addGestureRecognizer:rightEdgePanGestureRecognizer];

}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    // Get the current view we are touching
//    UIView *view = [_scene.view hitTest:[gesture locationInView:gesture.view] withEvent:nil];

    if (UIGestureRecognizerStateBegan == gesture.state ||
            UIGestureRecognizerStateChanged == gesture.state) {

        NSLog(@"FIRED");

    } else {// cancel, fail, or ended

        [_scene.delegate leftSwipe];

    }
}

- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer {
    static CGFloat lastScale = 0;
//    static CGFloat previousScale = 0;

    if (recognizer.state == UIGestureRecognizerStateBegan) {

    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
/*        CGFloat scaleDifference = recognizer.scale - lastScale;
        CGFloat heightDifference = _scene.size.height * scaleDifference;
        CGFloat widthDifference = _scene.size.width * scaleDifference;*/
        CGSize potentialSize = CGSizeMake(_scene.size.width * recognizer.scale, _scene.size.height * recognizer.scale);

        if (potentialSize.width > 0 && potentialSize.height > 0) {

            if (potentialSize.width > 3200) {
                potentialSize.width = 3200;
            } else {
                potentialSize.width = potentialSize.width;
            }

            if (potentialSize.width < 400) {
                potentialSize.width = 400;
            }

            if (potentialSize.height > 3200) {
                potentialSize.height = 3200;
            } else {
                potentialSize.height = potentialSize.height;
            }

            if (potentialSize.height < 400) {
                potentialSize.height = 400;
            }

//            lastScale = recognizer.scale;
            _scene.size = potentialSize;

        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
//        previousScale = recognizer.scale;
    }
}

/*- (void)handlePinchFrom:(UIPinchGestureRecognizer *) recognizer
{
    [_worldNode runAction:[SKAction scaleBy:recognizer.scale duration:0]];
    recognizer.scale = 1;
//    [_scene setCon]

    // While zooming/pinching, make sure hero is centered:
//    [self centerHero];
}*/

- (void)handleRightEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    // Get the current view we are touching

    if (UIGestureRecognizerStateBegan == gesture.state ||
            UIGestureRecognizerStateChanged == gesture.state) {
        NSLog(@"FIRED");

    } else {// cancel, fail, or ended

        [_scene.delegate rightSwipe];

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

        CGPoint touchLocation = [recognizer locationInView:(_scene.view)];

        touchLocation = [_scene convertPointFromView:touchLocation];
//        touchLocation = [scene convertPoint:touchLocation toNode:buildingLayer];
        touchLocation = [_scene convertPoint:touchLocation toNode:_scene.worldNode];

        [self selectNodeForTouch:touchLocation];
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {

    }
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {

    CGPoint touchLocation = [recognizer locationInView:(_scene.view)];

    touchLocation = [_scene convertPointFromView:touchLocation];
    touchLocation = [_scene convertPoint:touchLocation toNode:_scene.worldNode];

    CGPoint newPos = CGPointMake(touchLocation.x, touchLocation.y);

    if (recognizer.state == UIGestureRecognizerStateBegan) {
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {

        [self moveAllUnitsToPos:newPos];

/*        if (self.isSelecting) {
            [self.selectionBox expandSelectionBox:translation];

        }else if (self.pointOne.x == 0) {
            self.pointOne = touchLocation;
            self.isSelecting = true;

            CGSize size = CGSizeMake((0), (0));

            self.selectionBox = [[DrawSelectionBox alloc] initWithPointAndSize:touchLocation :size];
            [_worldNode addChild:self.selectionBox];
        }*/
    }

}

- (void)moveAllUnitsToPos:(CGPoint)positionToMoveTo {
    for (SKSpriteNode *node in _selectedNodes) {
        self.unitNode = [[node name] isEqualToString:unitNodeType];
        if (self.unitNode) {
            [((Unit *) node) move:positionToMoveTo];
        }
//            [_selectedNodes removeObject:node];
    }
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _previousLocation = [recognizer translationInView:_scene.worldNode.scene.view];

    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation;

        translation = [recognizer translationInView:_scene.worldNode.scene.view];

        translation = CGPointMake(translation.x * 4,
                -translation.y * 4);

        if (self.isSelecting) {
            [self.selectionBox expandSelectionBox:translation];


            [_scene.unitLayer enumerateChildNodesWithName:@"Unit" usingBlock:^(SKNode *node, BOOL *stop) {

                CGRect box = CGPathGetBoundingBox(self.selectionBox.path);

                if (CGRectContainsPoint(box, node.position)) {
                    if (![self.selectedNodes containsObject:node]) {
                        [self.selectedNodes addObject:node];
                    }
                }
            }];

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
    self.isSelecting = false;
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


    if ([[_scene.buildingLayer nodeAtPoint:touchLocation] isKindOfClass:[Building class]]) {
        touchedNode = (Building *) [_scene.buildingLayer nodeAtPoint:touchLocation];
        self.buildingNode = YES;
        self.unitNode = NO;
    } else if ([[_scene.unitLayer nodeAtPoint:touchLocation] isKindOfClass:[Unit class]]) {
        touchedNode = (Unit *) [_scene.unitLayer nodeAtPoint:touchLocation];
        self.buildingNode = NO;
        self.unitNode = YES;
    } else {
        if (self.pointOne.x == 0) {
            self.pointOne = touchLocation;
            self.isSelecting = true;

            CGSize size = CGSizeMake((0), (0));

            self.selectionBox = [[DrawSelectionBox alloc] initWithPointAndSize:touchLocation :size];
            [_scene.unitLayer addChild:self.selectionBox];
        }
    }

    if (touchedNode) {
        [_selectedNodes addObject:touchedNode];

        if (self.buildingNode) {

            Building *building = [_selectedNodes objectAtIndex:0];
            [_scene.delegate buildingClicked:building];
        } else if (self.unitNode) {
            Unit *unit = [_selectedNodes objectAtIndex:0];
            [_scene.delegate unitClicked:unit];
        }
    }


}


CGPoint mult(const CGPoint v, const CGFloat s) {
    return CGPointMake(v.x * s, v.y * s);
}

- (void)panForTranslation:(CGPoint)translation {

    if ([_selectedNodes count] > 0 && self.buildingNode) {

        //for (SKSpriteNode *node in _selectedNodes) {
        Building *building =[_selectedNodes objectAtIndex:0];
        if(building.placed == NO)
            [self moveBuilding:translation node:building];
        else{
            CGPoint newPos = CGPointMake(-translation.x, -translation.y);
            
            newPos = [_scene convertPoint:newPos toNode:_scene.worldNode];
            
            [self centerViewOn:newPos];
        }
        //}
    } else {
        CGPoint newPos = CGPointMake(-translation.x, -translation.y);

        newPos = [_scene convertPoint:newPos toNode:_scene.worldNode];

        [self centerViewOn:newPos];

    }
}

- (void)moveBuilding:(CGPoint)translation node:(Building *)node {
    if ([[node name] isEqualToString:buildingNodeType]) {

        CGPoint position = [node position];

        [node setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        CGFloat previousz = node.zPosition;

        CGFloat z = _scene.buildingLayer.layerSize.height - node.position.y;

        [node setZPosition:(z)];

        node.placed = YES;
    }
}


- (void)centerViewOn:(CGPoint)centerOn {
    _scene.worldNode.position = [self pointToCenterViewOn:centerOn :_scene.bgLayer];
//    worldNode.position = cent
}

- (CGPoint)pointToCenterViewOn:(CGPoint)centerOn :(TileMapLayer *)layer {
    CGSize size = _scene.size;
    CGFloat x = Clamp(centerOn.x, size.width / 2,
            3200 - size.width / 2);

    CGFloat y = Clamp(centerOn.y, size.height / 2,
            3200 - size.height / 2);

    return CGPointMake(-x, -y);
}

@end