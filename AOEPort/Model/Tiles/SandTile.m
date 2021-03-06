//
//  GrassTile.m
//  AOEPort
//
//  Created by Dan Malone on 14/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "SandTile.h"

@implementation SandTile
- (id)initWithTexture:(SKTexture *)texture
{
    self = [super init];

    if(self = [super initWithTexture:texture]){
        texture.filteringMode = SKTextureFilteringNearest;

        if (self = [super initWithTexture:texture]) {
            self.name = @"Sand";
            NSMutableDictionary *data =  [[NSMutableDictionary alloc] init];
            [data setValue:@"Sand" forKey:@"Type"];

            self.userData = data;
            //            CGFloat minDiam = MIN(self.size.width, self.size.height);
            //            minDiam = MAX(minDiam-8, 8);
            //            self.physicsBody =
            //            [SKPhysicsBody bodyWithCircleOfRadius:minDiam/2.0];
            //            //self.physicsBody.categoryBitMask = PCBugCategory;
            //            self.physicsBody.collisionBitMask = 0;
        }
    }
    return self;
}
@end
