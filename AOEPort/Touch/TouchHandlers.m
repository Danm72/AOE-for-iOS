//
// Created by Dan Malone on 18/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TouchHandlers.h"
#import "Builder.h"
#import "MyScene.h"
#import "Wall.h"
#import <AudioToolbox/AudioToolbox.h>



@interface TouchHandlers ()

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


- (instancetype)initWithScene:(MyScene *)scene {
    self = [super init];
    if (self) {
        _selectedNodes = [NSMutableArray array];
        _scene = scene;

        
    }
    
    return self;
}

- (void)registerTouchEvents {
    [self didMoveToView];
}

- (void)didMoveToView {
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
    [[_scene view] addGestureRecognizer:pinchGestureRecognizer];
    
    //    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
    //    [[scene view] addGestureRecognizer:rotationGestureRecognizer];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
    longPressGestureRecognizer.minimumPressDuration = 0.25;
    [[_scene view] addGestureRecognizer:longPressGestureRecognizer];
    [longPressGestureRecognizer setDelegate:self];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [tapGestureRecognizer requireGestureRecognizerToFail:longPressGestureRecognizer];
    [[_scene view] addGestureRecognizer:tapGestureRecognizer];
    
    UIScreenEdgePanGestureRecognizer *leftEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftEdgeGesture:)];
    leftEdgePanGestureRecognizer.edges = UIRectEdgeLeft;
    
    //    leftEdgePanGestureRecognizer.delegate = self;
    [[_scene view] addGestureRecognizer:leftEdgePanGestureRecognizer];
    
    UIScreenEdgePanGestureRecognizer *rightEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightEdgeGesture:)];
    rightEdgePanGestureRecognizer.edges = UIRectEdgeRight;
    
    [[_scene view] addGestureRecognizer:rightEdgePanGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[_scene view] addGestureRecognizer:panGestureRecognizer];
    [panGestureRecognizer requireGestureRecognizerToFail:rightEdgePanGestureRecognizer];
    [panGestureRecognizer requireGestureRecognizerToFail:leftEdgePanGestureRecognizer];
    
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    // Get the current view we are touching
    //    UIView *view = [_scene.view hitTest:[gesture locationInView:gesture.view] withEvent:nil];
    
    if (UIGestureRecognizerStateBegan == gesture.state ||
        UIGestureRecognizerStateChanged == gesture.state) {
        
        NSLog(@"FIRED");
        
    } else {// cancel, fail, or ended
        
        [_scene.delegate1 leftSwipe];
        
    }
}

- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer {
    static CGFloat lastScale = 0;
    //    static CGFloat previousScale = 0;
    CGPoint anchorPoint = [recognizer locationInView:recognizer.view];
    anchorPoint = [_scene convertPointFromView:anchorPoint];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {

    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        /*        CGFloat scaleDifference = recognizer.scale - lastScale;
         CGFloat heightDifference = _scene.size.height * scaleDifference;
         CGFloat widthDifference = _scene.size.width * scaleDifference;*/
//        CGPoint anchorPointInMySkNode = [_scene convertPoint:anchorPoint fromNode:_scene.worldNode];
//        [_scene.worldNode setScale:(_scene.xScale * recognizer.scale)];
//        CGPoint mySkNodeAnchorPointInScene = [_scene convertPoint:anchorPointInMySkNode fromNode:_scene.worldNode];
//        CGPoint translationOfAnchorInScene = CGPointSubtract(anchorPoint, mySkNodeAnchorPointInScene);
//
//        _scene.worldNode.position = CGPointAdd(_scene.worldNode.position, translationOfAnchorInScene);
//
//        recognizer.scale = 1.0;
//
//        
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
            
            recognizer.scale = 1.0;
            
        

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
        
        [_scene.delegate1 rightSwipe];
    }
}

- (void)handleRotationFrom:(UIRotationGestureRecognizer *)recognizer {
    //    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    //    recognizer.rotation = 0;
}

- (void)beginSelectionBox:(CGPoint)touchLocation {
    //    if (!_selectedBuilding) {
    if (self.pointOne.x == 0) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        self.pointOne = touchLocation;
        self.isSelecting = true;
        
        CGSize size = CGSizeMake((0), (0));
        
        self.selectionBox = [[DrawSelectionBox alloc] initWithPointAndSize:touchLocation :size];
        [_scene.unitLayer addChild:self.selectionBox];
    }
    //    }
}

- (SKAction*)createBuilding:(Building *)building {
    if([_selectedNodes count] >0 && building.built == NO && building.placed){
        Builder *unit = [_selectedNodes objectAtIndex:0];
        return [unit createBuilding:building];
    }
    return nil;
}

- (void)handleLongPressFrom:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchLocation = [recognizer locationInView:(_scene.view)];
        
        touchLocation = [_scene convertPointFromView:touchLocation];
        touchLocation = [_scene convertPoint:touchLocation toNode:_scene.worldNode];
        
        
        if ([[_scene.buildingLayer nodeAtPoint:touchLocation] isKindOfClass:[Building class]]) {
            Building *building =(Building*) [_scene.buildingLayer nodeAtPoint:touchLocation];
            [_selectedBuilding removeAllChildren];
            _selectedBuilding = building;
            SKAction *seq = [self createBuilding:building];
            
            if(seq){
                NSLog(@"Begin createBuilding sequence");
                [_scene runAction:seq];
                NSLog(@"Begin createBuilding ran");
                
            }
            
        }else{
            [self beginSelectionBox:touchLocation];
            
        }
        
        
        
        if (recognizer.state == UIGestureRecognizerStateEnded) {
            
        }
    }
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
    @try {
        CGPoint touchLocation = [recognizer locationInView:(_scene.view)];
        
        touchLocation = [_scene convertPointFromView:touchLocation];
        touchLocation = [_scene convertPoint:touchLocation toNode:_scene.worldNode];
        
        NSLog(@"touch : %f %f" ,touchLocation.x, touchLocation.y);
        [self showTapAtLocation:(touchLocation)];
        //[_scene.pathfinder findPathFromStart:(CGPointMake(0, 0)) toTarget:CGPointMake(touchLocation.x, touchLocation.y)];
        
              CGPoint newPos = CGPointMake(touchLocation.x, touchLocation.y);
        
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            
        }
        
        if (recognizer.state == UIGestureRecognizerStateEnded) {
            [self selectNodeForTouch:touchLocation];
            
            [self moveAllUnitsToPos:newPos];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"PAN EXCEPTION: %@",exception.reason);
    }
}

- (void)moveAllUnitsToPos:(CGPoint)positionToMoveTo {
    if([ _selectedNodes count] > 0){
        for (Unit *node in _selectedNodes) {
            [((Unit *) node) move:positionToMoveTo];
        }
    }
}

BOOL isInRectangle(double centerX, double centerY, double radius,
                   double x, double y)
{
    return x >= centerX - radius && x <= centerX + radius &&
    y >= centerY - radius && y <= centerY + radius;
}

- (void)selectUnitsWithinBox:(CGPoint)translation {
    [self.selectionBox expandSelectionBox:translation];
    
    [_selectedNodes removeAllObjects];
    [self.scene.delegate1 unitUnselected];
    CGRect box = CGPathGetBoundingBox(self.selectionBox.path);
    
    [_scene.unitLayer enumerateChildNodesWithName:@"Unit" usingBlock:^(SKNode *node, BOOL *stop) {
        Unit *unit = (Unit *) node;
        [unit removeAllChildren]; //remove circle
        
        if (CGRectContainsPoint(box, unit.position)) {
            if (![_selectedNodes containsObject:unit]) {
                [unit addSelectedCircle];
                [_selectedNodes addObject:unit];
                
                [_scene.delegate1 unitClicked:unit];
            }
        }
    }];
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    @try {
        
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            [self.delegate panBegun];
            
            _previousLocation = [recognizer translationInView:_scene.worldNode.scene.view];
            
        } else if (recognizer.state == UIGestureRecognizerStateChanged) {
            CGPoint translation;
            
            translation = [recognizer translationInView:_scene.worldNode.scene.view];
            
            translation = CGPointMake(translation.x * 4,
                                      -translation.y * 4);
            
            if (self.isSelecting) {
                [self selectUnitsWithinBox:translation];
                
            } else {
                [self panForTranslation:translation];
            }
            
            [recognizer setTranslation:CGPointZero inView:recognizer.view];
        }
        
        else if (recognizer.state == UIGestureRecognizerStateEnded) {
            
            if (_selectedBuilding && !_isSelecting) {
                _selectedBuilding.placed = YES;
                
                [self removeBuildingActions:_selectedBuilding];
                
            }
            
            [self resetSelectionBox];
            [self.delegate panEnded];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"PAN EXCEPTION: %@",exception.reason);
    }
    
}

- (void)showTapAtLocation:(CGPoint)point {
    // 1
    UIBezierPath *path =
    [UIBezierPath bezierPathWithOvalInRect:
     CGRectMake(-3.0f, -3.0f, 6.0f, 6.0f)]; // 2
    SKShapeNode *shapeNode = [SKShapeNode node];
    shapeNode.path = path.CGPath;
    shapeNode.position = point;
    shapeNode.strokeColor = SKColorWithRGBA(255, 255, 255, 196); shapeNode.lineWidth = 1;
    shapeNode.antialiased = NO;
    [_scene.worldNode addChild:shapeNode];
    // 3
    const NSTimeInterval Duration = 0.6;
    SKAction *scaleAction = [SKAction scaleTo:6.0f duration:Duration];
    scaleAction.timingMode = SKActionTimingEaseOut;
    [shapeNode runAction:
     [SKAction sequence:@[scaleAction,
                          [SKAction removeFromParent]]]];
    // 4
    SKAction *fadeAction =
    [SKAction fadeOutWithDuration:Duration];
    fadeAction.timingMode = SKActionTimingEaseOut;
    [shapeNode runAction:fadeAction]; }

- (void)resetSelectionBox {
    self.isSelecting = false;
    _pointOne.x = 0;
    _pointTwo.x = 0;
    _isSelecting = false;
    [_selectionBox removeFromParent];
}

- (void)removeBuildingActions:(SKSpriteNode *)node {
    self.buildingNode = [[node name] isEqualToString:buildingNodeType];
    if (self.buildingNode) {
        SKAction *returnToRegularRotation = [SKAction rotateToAngle:0.0f duration:0.1];
        SKAction *returnToRegularColour = [SKAction colorizeWithColorBlendFactor:0.0 duration:0.0];
        
        SKAction *returnToNormalSequence = [SKAction sequence:@[
                                                                returnToRegularColour, returnToRegularRotation]];
        
        if([node hasActions])
            [node removeAllActions];
        
        [node runAction:returnToNormalSequence];
        
        //        [_selectedBuilding removeAllObjects];
    }
}


- (void)removeSelectedUnits {
    if([_selectedNodes count] >0){
        for (Unit *unit in _selectedNodes) {
            [unit removeAllChildren];
        }
        [_selectedNodes removeAllObjects];
    }
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    @try {
        
        Unit *unit = nil;
        [_selectedBuilding removeAllChildren];
        _selectedBuilding = nil;
        
        if ([[_scene.buildingLayer nodeAtPoint:touchLocation] isKindOfClass:[Building class]]) {
            _selectedBuilding = (Building *) [_scene.buildingLayer nodeAtPoint:touchLocation];
            [_selectedBuilding addSelectedCircle];
            
            [self removeSelectedUnits];
            
        } else if ([[_scene.unitLayer nodeAtPoint:touchLocation] isKindOfClass:[Unit class]]) {
            unit = (Unit *) [_scene.unitLayer nodeAtPoint:touchLocation];
        }
        
        if (unit) {
            [self removeSelectedUnits];
            
            [self.scene.delegate1 unitUnselected];
            [unit addSelectedCircle];
            [_scene.delegate1 unitClicked:unit];
            [_selectedNodes addObject:unit];
            
        } else if (_selectedBuilding) {
            
            [_scene.delegate1 buildingClicked:_selectedBuilding];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"TOUCH EXCEPTION: %@",exception.reason);
    }
}


CGPoint mult(const CGPoint v, const CGFloat s) {
    return CGPointMake(v.x * s, v.y * s);
}

- (void)panForTranslation:(CGPoint)translation {
    
    if (_selectedBuilding) {
        if (_selectedBuilding.placed == NO)
            [self moveBuilding:translation node:_selectedBuilding];
        else {
            CGPoint newPos = CGPointMake(-translation.x, -translation.y);
            
            newPos = [_scene convertPoint:newPos toNode:_scene.worldNode];
            
            [self centerViewOn:newPos];
        }
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
        
        CGFloat z = 3200 - node.position.y;
        
        [node setZPosition:(z)];
        
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