//
//  Barracks.m
//  AOEPort
//
//  Created by Dan Malone on 14/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Barracks.h"

@implementation Barracks

- (id)initWithTexture:(SKTexture *)texture
{
    if(self = [super initWithTexture:texture]){
        texture.filteringMode = SKTextureFilteringNearest;
        
        if (self = [super initWithTexture:texture]) {
            self.name = @"Building";
            NSMutableDictionary *data =  [[NSMutableDictionary alloc] init];
            [data setValue:@"Barracks" forKey:@"Type"];
            
            self.userData = data;
            self.buildType = @"Barracks";

        }
    }
    return self;
}
@end
