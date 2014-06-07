//
// Created by Dan Malone on 23/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Unit.h"
#import "Constants.h"
#import "TouchUtilities.h"

@implementation Unit {
    
    
}
-(void) setupPhysics:(SKTexture*)texture{
    self.physicsBody =
    [SKPhysicsBody bodyWithRectangleOfSize:texture.size];
//    self.physicsBody =
//    [SKPhysicsBody bodyWithTexture:texture size:texture.size];
    
    self.physicsBody.dynamic =YES;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.allowsRotation= NO;
    self.physicsBody.friction = 1;
    self.physicsBody.categoryBitMask = CNPhysicsCategoryUnit;
    self.physicsBody.contactTestBitMask = CNPhysicsCategoryResource | CNPhysicsCategoryBuilding | CNPhysicsCategoryUnit;
    self.physicsBody.collisionBitMask = CNPhysicsCategoryBuilding | CNPhysicsCategoryResource | CNPhysicsCategoryUnit;
}

-(void) addSelectedCircle{
    SKShapeNode *wheel = [[SKShapeNode alloc]init];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path addArcWithCenter:CGPointMake(0, -self.frame.size.height/2) radius:10 startAngle:0.0 endAngle:(M_PI*2.0) clockwise:YES];
    
    wheel.path = path.CGPath;
    
    wheel.strokeColor = [SKColor greenColor];
//    wheel.position = CGPointMake(self.position.x, self.position.y);
    wheel.zPosition = self.position.y - self.zPosition;
//    NSLog(@"ADDING CIRCLE");
    [self addChild:wheel];
}
- (void)move:(CGPoint)newPos:(NSInteger) completionAction {

    int direction = [self setDirection:newPos];

    //    [self animateWalk :direction];
    [self animateAction:direction:move_action];
    int speed = [TouchUtilities getSpeed:self.position :newPos];
    
        SKAction *moveTo = [SKAction moveTo:newPos duration:speed];

    
    //2
//    CGPoint newPosition = CGPointMake(self.position.x + velocity.x ,
//                              self.position.y + velocity.y );
//    self.position = newPosition;

    
//        [moveTo setTimingMode:SKActionTimingEaseOut];
        
        @try {
            [self runAction:moveTo completion:^{
                {
                    NSLog(@"SECOND %f, %f",self.position.x, self.position.y);

//                    if([self hasActions]){
//                        [self removeAllActions];
//                    }
                    if(completionAction == idle_action){
//                        [self animateAction:direction :idle_action];
                        [self animateIdle];
//                        NSLog(@"Idle");
                    self.position = self.position;
                    }
                    else if(completionAction == base_action){
//                        [self animateAction:direction :base_action];
                        [self animateBuild];

                        return;
                    }
                }
                
            }];
        }@catch (NSException *exception) {
            NSLog(@"exception: %@", exception);
        }
    //}
}

- (void)move:(CGPoint)newPos {
    
    [self move:newPos:idle_action];
}

- (int)setDirection:(CGPoint)newPos {
    int direction = -1;
    
    CGPoint offset = CGPointMake(newPos.x - self.position.x, newPos.y - self.position.y);
    CGFloat length = sqrtf(offset.x * offset.x + offset.y * offset.y);
    CGPoint dir = CGPointMake(offset.x / length, offset.y / length);

    if (dir.y > .25)
        direction = NORTH;
    if (dir.y < -.25)
        direction = SOUTH;
    if (dir.x > .75)
        direction = EAST;
    if (dir.x < -.75)
        direction = WEST;
    if (direction == NORTH && dir.x > .25)
        direction = NORTH_EAST;
    if (direction == NORTH && dir.x < -.25)
        direction = NORTH_WEST;
    if (direction == SOUTH && dir.x > .25)
        direction = SOUTH_EAST;
    if (direction == SOUTH && dir.x < -.25)
        direction = SOUTH_WEST;

    return direction;
}

- (void)moveToward:(CGPoint)targetPosition {
    CGPoint targetVector = CGPointNormalize(CGPointSubtract(targetPosition,
                                                            self.position));
    targetVector = CGPointMultiplyScalar(targetVector, 300);
    self.physicsBody.velocity = CGVectorMake(targetVector.x,
                                             targetVector.y);
}

- (void)evaluateMovementDirection:(NSInteger)direction {
    
    switch (direction) {
            
        case SOUTH: {
            direction_graphic_start = 0;
            direction_graphic_end = 14;
            break;
            
        }
        case SOUTH_WEST: {
            direction_graphic_start = 15;
            direction_graphic_end = 29;
            break;
            
        }
        case WEST: {
            direction_graphic_start = 30;
            direction_graphic_end = 44;
            break;
        }
            
        case NORTH_WEST: {
            direction_graphic_start = 45;
            direction_graphic_end = 59;
            break;
        }
        case NORTH: {
            direction_graphic_start = 60;
            direction_graphic_end = 75;
            break;
        }
        case NORTH_EAST: {
            flipGraphic = true;
            direction_graphic_start = 45;
            direction_graphic_end = 59;
            break;
        }
            
        case EAST: {
            flipGraphic = true;
            direction_graphic_start = 30;
            direction_graphic_end = 44;
            break;
        }
            
        case SOUTH_EAST: {
            flipGraphic = true;
            direction_graphic_start = 15;
            direction_graphic_end = 29;
            break;
        }
            
        default:
            break;
    }
}
@end