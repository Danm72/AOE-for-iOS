//
// Created by Dan Malone on 10/05/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "PinchHandler.h"
#import "MyScene.h"


@implementation PinchHandler {

}

- (id)init {
    self = [super init];
    if (self) {

    }

    return self;
}

+ (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer:(MyScene *) scene {
    static CGFloat lastScale = 0;
    static CGFloat previousScale = 0;

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (previousScale > 0)
            recognizer.scale = previousScale;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat scaleDifference = recognizer.scale - lastScale;
        CGFloat heightDifference = scene.size.height * scaleDifference;
        CGFloat widthDifference = scene.size.width * scaleDifference;
        CGSize potentialSize = CGSizeMake(scene.size.width + widthDifference, scene.size.height + heightDifference);

        if (potentialSize.width > 0 && potentialSize.height > 0) {

            if (potentialSize.width > 3200) {
                potentialSize.width = 3200;
            } else {
                potentialSize.width = potentialSize.width;
            }

            if (potentialSize.height > 3200) {
                potentialSize.height = 3200;
            } else {
                potentialSize.height = potentialSize.height;
            }
            lastScale = recognizer.scale;
            scene.size = potentialSize;

        }
//        if ((potentialSize.width < 3200 && potentialSize.height < 3200) && ()) {
//            self.scene.size = potentialSize;
//            lastScale = recognizer.scale;
//
//            NSLog(@"Scale : %f, Size x: %f, Size x: %f", recognizer.scale, self.scene.size.width, self.scene.size.height);
//        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        previousScale = recognizer.scale;
    }
}
@end