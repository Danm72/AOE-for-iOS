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

+(NSArray*)getAllPointsFromPoint:(CGPoint)fPoint toPoint:(CGPoint)tPoint
{
    /*Simplyfied implementation of Bresenham's line algoritme */
    NSMutableArray *ret = [NSMutableArray array];
    float deltaX = fabsf(tPoint.x - fPoint.x);
    float deltaY = fabsf(tPoint.y - fPoint.y);
    float x = fPoint.x;
    float y = fPoint.y;
    float err = deltaX-deltaY;

    float sx = -0.5;
    float sy = -0.5;
    if(fPoint.x<tPoint.x)
        sx = 0.5;

    if(fPoint.y<tPoint.y)
        sy = 0.5;
    do {
        [ret addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        float e = 2*err;
        if(e > -deltaY)
        {
            err -=deltaY;
            x +=sx;
        }
        if(e < deltaX)
        {
            err +=deltaX;
            y+=sy;
        }
    } while (round(x)  != round(tPoint.x) && round(y) != round(tPoint.y));
    [ret addObject:[NSValue valueWithCGPoint:tPoint]];//add final point
    return ret;
}

+ (int)getSpeed:(CGPoint)oldPoint :(CGPoint)newPoint {

    CGFloat xDist = (oldPoint.x - newPoint.x);
    CGFloat yDist = (oldPoint.y - newPoint.y);
    int distance = (int) sqrt((xDist * xDist) + (yDist * yDist));

    //avoid overly fast movement
    if (distance < 100)
        distance = distance / 25;
    else if (distance < 200)
        distance = distance / 50;
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