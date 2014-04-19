//
//  MenuItemTableViewCell.m
//  AOEPort
//
//  Created by Dan Malone on 07/03/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "MenuItemTableViewCell.h"

@implementation MenuItemTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
