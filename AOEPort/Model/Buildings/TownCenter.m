//
//  TownCenter.m
//  AOEPort
//
//  Created by Dan Malone on 14/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TownCenter.h"

@implementation TownCenter

- (id)initWithTexture:(SKTexture *)texture
{
    if(self = [super initWithTexture:texture]){
        texture.filteringMode = SKTextureFilteringNearest;
        
        if (self = [super initWithTexture:texture]) {
            self.name = @"Building";
            NSMutableDictionary *data =  [[NSMutableDictionary alloc] init];
            [data setValue:@"TownCenter" forKey:@"Type"];
            
            self.userData = data;
            self.buildType = @"elitetowncenter";
            [self setupPhysicsBody];
            self.stone = 75;
            self.wood = 40;
        }
    }
    return self;
}


@end
