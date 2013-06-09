//
//  MDCell.h
//  single
//
//  Created by Wang Ming-der on 5/20/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Example;

@interface MDCell : UITableViewCell {
    Example *cell;
}
@property (nonatomic, strong) Example *cell;

@end
