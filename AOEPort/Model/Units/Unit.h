//
// Created by Dan Malone on 23/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>

int direction_graphic_start;
int direction_graphic_end;
BOOL flipGraphic;

@interface Unit : SKSpriteNode  <SKPhysicsContactDelegate>
#define idle_action 0
#define base_action 1
#define move_action 2
@property (readwrite) NSString *movementSpeed;
@property (strong, nonatomic) NSMutableArray *textures;


+ (NSArray *)getAllPointsFromPoint:(CGPoint)fPoint toPoint:(CGPoint)tPoint;

- (void)animateWalk:(NSInteger)direction;
- (void)animateAction:(NSInteger)direction:(NSInteger) actionType;
- (void)animate:(NSInteger)direction :(NSString *)atlasName :(NSString *)animationName;

- (void)move:(CGPoint)newPos;
- (void)move:(CGPoint)newPos:(NSInteger) completionAction;

- (void)evaluateMovementDirection:(NSInteger)direction;
-(void) setupPhysics:(SKTexture*)texture;
-(void) addSelectedCircle;
- (int)setDirection:(CGPoint)newPos;
-(void) animateIdle;
-(void) animateBuild;

@end