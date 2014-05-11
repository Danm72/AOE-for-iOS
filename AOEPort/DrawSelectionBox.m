//
// Created by Dan Malone on 25/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "DrawSelectionBox.h"
#import "Constants.h"

@interface DrawSelectionBox ()
@end

@implementation DrawSelectionBox {

}


- (id)initWithPointAndSize:(CGPoint)point :(CGSize)s {
    self = [super init];
    if (self) {
        _origin = point;
        CGPathRef bodyPath = CGPathCreateWithRect(CGRectMake(point.x, point.y, 0, 0), nil);
        self.fillColor = [SKColor colorWithRed:1.0 green:0 blue:0
                                          alpha:0.1];
//3
        self.path = bodyPath;
        self.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0
                                            alpha:0.5];
        self.lineWidth = 1.0;

        self.zPosition = 3200;

        self.glowWidth = 0.5;

        CGPathRelease(bodyPath);
    }

    return self;
}


- (void)expandSelectionBox:(CGPoint)translation {

    CGRect box = CGPathGetBoundingBox(self.path);
    box.size = CGSizeMake(box.size.width += translation.x*2, box.size.height += translation.y*2);


    CGPathRef bodyPath = CGPathCreateWithRect(box, nil);

    self.path = bodyPath;

}

@end