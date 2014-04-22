//
// Created by Dan Malone on 22/04/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Tree.h"


@implementation Tree {

}
- (id)initWithTexture:(SKTexture *)texture {
    if (self = [super initWithTexture:texture]) {
        texture.filteringMode = SKTextureFilteringNearest;

        if (self = [super initWithTexture:texture]) {
            self.name = @"Tree";
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setValue:@"Tree" forKey:@"Type"];

            self.userData = data;
//            [self setupPhysicsBody];

        }
    }
    return self;
}
@end