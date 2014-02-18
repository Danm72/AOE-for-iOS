//
//  Church.m
//  AOEPort
//
//  Created by Dan Malone on 15/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Church.h"

@implementation Church
- (id)initWithTexture:(SKTexture *)texture
{
    if(self = [super initWithTexture:texture]){
        texture.filteringMode = SKTextureFilteringNearest;
        
        if (self = [super initWithTexture:texture]) {
            self.name = @"Building";
            NSMutableDictionary *data =  [[NSMutableDictionary alloc] init];
            [data setValue:@"Church" forKey:@"Type"];
            self.userData = data;
            _buildType = @"Church";

        }
    }
    return self;
}
@end
