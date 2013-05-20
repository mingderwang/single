//
//  MDCell.m
//  single
//
//  Created by Wang Ming-der on 5/20/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import "MDCell.h"

@implementation MDCell

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

- (void)layoutSubviews
{
    [super layoutSubviews]; 
//    self.imageView.frame = CGRectMake(0,0,320,320);
}
@end
