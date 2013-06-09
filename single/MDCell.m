//
//  MDCell.m
//  single
//
//  Created by Wang Ming-der on 5/20/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import "MDCell.h"
#import "UIImageView+AFNetworking.h"
#import "Example.h"

@implementation MDCell {
@private
    __strong Example *_cell;
}

@synthesize cell = _cell;

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

- (void) setCell:(Example *)cell2 {
    _cell = cell2;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:_cell.item]
                   placeholderImage:[UIImage imageNamed:@"profile-image-placeholder.png"]];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews]; 
//    self.imageView.frame = CGRectMake(0,0,320,320);
}
@end
