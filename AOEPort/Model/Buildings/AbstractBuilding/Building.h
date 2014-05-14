//
//  Building.h
//  Age of Empires Port
//
//  Created by Dan Malone on 08/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Building : SKSpriteNode <SKPhysicsContactDelegate>

@property (readwrite) NSString *buildType;
@property (nonatomic) Boolean placed;
-(void) addSelectedCircle;


+ (SKAction *)selectedBuildingAction;

- (void)setupPhysicsBody;
@end
