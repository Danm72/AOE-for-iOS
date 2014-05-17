//
//  Wall.m
//  AOEPort
//
//  Created by Dan Malone on 14/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Wall.h"
#import "Constants.h"
#import "DrawSelectionBox.h"


@implementation Wall
- (id)initWithTexture:(SKTexture *)texture {
    if (self = [super initWithTexture:texture]) {
        texture.filteringMode = SKTextureFilteringNearest;

        if (self = [super initWithTexture:texture]) {
            self.name = @"Building";
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setValue:@"Wall" forKey:@"Type"];

            self.userData = data;
            self.buildType = @"Wall";
            [self setupPhysicsBody];
            self.placed = NO;
            self.stone = 20;
            self.wood = 10;
        }
    }
    return self;
}

@end
