//
//  CircleHeadView.h
//  fakeXiaoMi
//
//  Created by WangJian on 15/4/3.
//  Copyright (c) 2015年 kkgo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepDataView.h"
#import "StepManager.h"
typedef enum{
    CircleHeadViewStatusMinHeight = 0,
    CircleHeadViewStatusPulling,
    CircleHeadViewStatusMaxHeight
} CircleHeadViewStatus;

@interface CircleHeadView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (strong, nonatomic) StepDataView *sportsDataView;
@property (assign, nonatomic) CircleHeadViewStatus viewStatus;
@property (strong, nonatomic) StepManager *stepManager;
@end
