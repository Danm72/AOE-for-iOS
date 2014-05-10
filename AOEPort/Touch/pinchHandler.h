//
// Created by Dan Malone on 10/05/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchHandlers.h"

@class MyScene;


@interface PinchHandler : NSObject
+ (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer:(MyScene *) scene;

@property (strong, nonatomic) MyScene *scene;
@end