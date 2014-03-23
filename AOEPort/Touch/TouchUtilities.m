//
// Created by Dan Malone on 23/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "TouchUtilities.h"


@implementation TouchUtilities {

}

+ (BOOL)accuracyOfTouchX:(CGPoint)oldPoint :(CGPoint)newPoint {
    CGFloat differenceX;

    // if(newPoint.x > oldPoint.x){
    if (newPoint.y > oldPoint.y)
        differenceX = newPoint.y - oldPoint.y;
    else
        differenceX = oldPoint.y - newPoint.y;

    // differenceX = oldPoint.X - newPoint.X;

    if (differenceX >= 0 && differenceX < 200) {
        return true;
    } else if (differenceX <= 0 && differenceX >= -200) {
        return true;
    }
    // }

    return false;
}

+ (int)getSpeed:(CGPoint)oldPoint :(CGPoint)newPoint {

    CGFloat xDist = (oldPoint.x - newPoint.x);
    CGFloat yDist = (oldPoint.y - newPoint.y);
    int distance = (int) sqrt((xDist * xDist) + (yDist * yDist));

    //avoid overly fast movement
    if (distance < 200)
        distance = distance / 10;
    else
        distance = distance / 100;

    return distance;
}

+ (BOOL)accuracyOfTouchY:(CGPoint)oldPoint :(CGPoint)newPoint {
    CGFloat differenceY;

    // if(newPoint.x > oldPoint.x){
    if (newPoint.y > oldPoint.y)
        differenceY = newPoint.y - oldPoint.y;
    else
        differenceY = oldPoint.y - newPoint.y;

    // differenceY = oldPoint.y - newPoint.y;

    if (differenceY >= 0 && differenceY < 200) {
        return true;
    } else if (differenceY <= 0 && differenceY >= -200) {
        return true;
    }
    // }

    return false;
}
@end