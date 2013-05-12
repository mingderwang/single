//
//  MyRightViewController.h
//  single
//
//  Created by Wang Ming-der on 5/12/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import "IASKAppSettingsViewController.h"

@interface MyRightViewController : IASKAppSettingsViewController <IASKSettingsDelegate>
- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender;
@end
