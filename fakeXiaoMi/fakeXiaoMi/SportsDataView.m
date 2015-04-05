//
//  SportsDataView.m
//  fakeXiaoMi
//
//  Created by Kakaxi on 15/4/5.
//  Copyright (c) 2015年 kkgo. All rights reserved.
//

#import "SportsDataView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation SportsDataView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dateLabel];
        [self addSubview:self.stepLabel];
        [self addSubview:self.distanceLabel];
    }
    return self;
}

- (LeftMidRightLabelView *)dateLabel {
    if (!_dateLabel) {
        LeftMidRightLabelView *tempView  = [[LeftMidRightLabelView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _dateLabel = tempView;
        _dateLabel.alignment = NSTextAlignmentCenter;
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textLeft.font = [UIFont boldSystemFontOfSize:17];
        _dateLabel.textLeft.text = @"今日步数";
        
    }
    return _dateLabel;
}


- (LeftMidRightLabelView *)stepLabel {
    if (!_stepLabel) {
        LeftMidRightLabelView *tempView  = [[LeftMidRightLabelView alloc] initWithFrame:CGRectMake(0, 32 -6, kScreenWidth, 41)];
        _stepLabel = tempView;
        _stepLabel.alignment = NSTextAlignmentCenter;
        _stepLabel.backgroundColor = [UIColor clearColor];
        _stepLabel.textMid.textColor = [UIColor colorWithRed:0/255.0 green:142/255.0 blue:247/255.0  alpha:1];
        _stepLabel.textMid.font = [UIFont boldSystemFontOfSize:34];
        _stepLabel.textMid.text = @"1608";
        _stepLabel.textRight.font = [UIFont boldSystemFontOfSize:17];
        _stepLabel.textRight.text = @"步";

    }
    return _stepLabel;
}


- (LeftMidRightLabelView *)distanceLabel {
    if (!_distanceLabel) {
        LeftMidRightLabelView *tempView  = [[LeftMidRightLabelView alloc] initWithFrame:CGRectMake(0, 72, kScreenWidth, 29)];
        _distanceLabel = tempView;
        _distanceLabel.alignment = NSTextAlignmentCenter;
        _distanceLabel.backgroundColor = [UIColor clearColor];
        _distanceLabel.iconLeft.frame = CGRectMake(0, 0, 18, 18);
        _distanceLabel.iconLeft.image = [UIImage imageNamed:@"形状-17"];
        _distanceLabel.textMid.textColor = [UIColor colorWithRed:0/255.0 green:142/255.0 blue:247/255.0  alpha:1];
        _distanceLabel.textMid.font = [UIFont boldSystemFontOfSize:24];
        _distanceLabel.textMid.text = @" 1.1";
        _distanceLabel.textRight.font = [UIFont boldSystemFontOfSize:17];
        _distanceLabel.textRight.text = @"公里";
        
    }
    return _distanceLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
