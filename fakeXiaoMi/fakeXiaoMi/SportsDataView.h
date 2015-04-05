//
//  SportsDataView.h
//  fakeXiaoMi
//
//  Created by Kakaxi on 15/4/5.
//  Copyright (c) 2015年 kkgo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMidRightLabelView.h"
@interface SportsDataView : UIView
@property (strong, nonatomic) LeftMidRightLabelView* dateLabel;
@property (strong, nonatomic) LeftMidRightLabelView* stepLabel;
@property (strong, nonatomic) LeftMidRightLabelView* distanceLabel;

@end
