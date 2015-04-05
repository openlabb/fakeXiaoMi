//
//  LeftMidRightLabelView.h
//  fakeXiaoMi
//
//  Created by WangJian on 15/4/5.
//  Copyright (c) 2015年 kkgo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMidRightLabelView : UIView

@property (assign, nonatomic) NSTextAlignment alignment;

@property (strong, nonatomic) UIImageView *iconLeft;

@property (strong, nonatomic) UILabel *textLeft;

@property (strong, nonatomic) UILabel *textMid;

@property (strong, nonatomic) UILabel *textRight;

@end
