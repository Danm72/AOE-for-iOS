//
// Created by Dan Malone on 23/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TouchUtilities : NSObject
+ (BOOL)accuracyOfTouchX:(CGPoint)oldPoint :(CGPoint)newPoint;

+ (int)getSpeed:(CGPoint)oldPoint :(CGPoint)newPoint;

+ (BOOL)accuracyOfTouchY:(CGPoint)oldPoint :(CGPoint)newPoint;
@end