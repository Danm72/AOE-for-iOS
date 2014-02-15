//
//  Wall.m
//  AOEPort
//
//  Created by Dan Malone on 14/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Wall.h"

@implementation Wall
- (id)initWithTexture:(SKTexture *)texture
{
    if(self = [super initWithTexture:texture]){
        texture.filteringMode = SKTextureFilteringNearest;
    
        if (self = [super initWithTexture:texture]) {
            self.name = @"Building";
           NSMutableDictionary *data =  [[NSMutableDictionary alloc] init];
            [data setValue:@"Wall" forKey:@"Type"];
            
            self.userData = data;
            super.buildType = @"Wall";

//            CGFloat minDiam = MIN(self.size.width, self.size.height);
//            minDiam = MAX(minDiam-8, 8);
//            self.physicsBody =
//            [SKPhysicsBody bodyWithCircleOfRadius:minDiam/2.0];
//           //self.physicsBody.categoryBitMask = PCBugCategory;
//            self.physicsBody.collisionBitMask = 0;
        }
    }
    return self;
}


//- (id)init{
//    
//    if( self = [super init]){
//        self.name = @"Building";
//        NSMutableDictionary *data =  [[NSMutableDictionary alloc] init];
//        [data setValue:@"Wall" forKey:@"Type"];
//        
//        self.userData = data;
//        
//    }
//    
//    return self;
//}
@end
