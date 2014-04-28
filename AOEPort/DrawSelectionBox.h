//
// Created by Dan Malone on 25/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawSelectionBox : SKShapeNode

- (id)initWithPointAndSize:(CGPoint)point :(CGSize)s;

- (void)expandSelectionBox:(CGPoint)translation;

@end