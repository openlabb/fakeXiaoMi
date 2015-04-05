//
//  CircleHeadView.m
//  fakeXiaoMi
//
//  Created by WangJian on 15/4/3.
//  Copyright (c) 2015年 kkgo. All rights reserved.
//

#import "CircleHeadView.h"

#define kmaxH 260
#define kminH 100

@implementation CircleHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1];
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*0.5-175/2, 20 , 175, 175)];
        _backImageView.image = [UIImage imageNamed:@"circle"];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.backImageView];
        [self addSubview:self.sportsDataView];
        self.clipsToBounds = YES;
        
        [self.stepManager addObserver:self forKeyPath:@"stepsToday" options:(NSKeyValueObservingOptionNew) context:Nil];

    }
    return self;
}

- (StepDataView *)sportsDataView{
    if (_sportsDataView == nil) {
        StepDataView *sV = [[StepDataView alloc] initWithFrame:CGRectMake(0, 60,  [UIScreen mainScreen].bounds.size.height, 90)];
        _sportsDataView = sV;
    }
    return _sportsDataView;
}

- (StepManager *)stepManager{
    return [StepManager sharedInstance];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:Nil];
    //    self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0 ,0, 0);
    //    self.scrollView.scrollIndicatorInsets =  self.scrollView.contentInset;
    
    self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0 ,0, 0);
    self.scrollView.scrollIndicatorInsets =  self.scrollView.contentInset;
    self.scrollView.contentOffset = CGPointMake(0, -self.frame.size.height);
    self.scrollView.decelerationRate = 0.6;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([keyPath isEqualToString:@"stepsToday"]) {
            self.sportsDataView.stepLabel.textMid.text = [NSString stringWithFormat:@"%ld",[change[@"new"] longValue]];
            self.sportsDataView.distanceLabel.textMid.text = [NSString stringWithFormat:@"%.2f",[change[@"new"] longValue] *0.3/1000];

        }else{
            CGPoint newOffset = [change[@"new"] CGPointValue];
            [self updateWithScrollOffset:newOffset];
        }

    });

}

-(void)updateWithScrollOffset:(CGPoint)newOffset
{
    
    float destinaOffset = -130;
    float startChangeOffset = -self.scrollView.contentInset.top;
    
    float nY = 0;
    
    if(newOffset.y < startChangeOffset){
        nY = startChangeOffset;
        //最大
    }else{
        if (newOffset.y>destinaOffset) {
            //最小
            nY = destinaOffset;
        }else{
            //可以动态变
            nY = newOffset.y;
        }
    }
    
    newOffset = CGPointMake(newOffset.x, nY);
    float d = destinaOffset-startChangeOffset;
    float alpha = 1 - (newOffset.y-startChangeOffset)/d;
    self.frame = CGRectMake(0,  -nY
                            + startChangeOffset, self.frame.size.width, self.frame.size.height);
    
    CGFloat angle = [self angleOfChange:(nY - startChangeOffset)];
    
    self.backImageView.frame = CGRectMake(self.backImageView.frame.origin.x , 20 + (nY-startChangeOffset) , self.backImageView.frame.size.width,  175 );
    
    self.sportsDataView.frame = CGRectMake(self.sportsDataView.frame.origin.x , 60 + (nY-startChangeOffset)*0.8 , self.sportsDataView.frame.size.width,  90 );

    
    if (1*angle <= M_PI/2 ) {
        CATransform3D  myTransform = CATransform3DMakeRotation(1*angle, 1, 0, 0);
        self.backImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        self.backImageView.layer.transform    = myTransform;
        self.backImageView.alpha = alpha;
//        self.sportsDataView.dateLabel.alpha = alpha;
        self.sportsDataView.distanceLabel.alpha = alpha;
    }else{
        self.backImageView.alpha = 1;
        
    }
    
}

- (CGFloat)angleOfChange:(CGFloat)deltaH{
    CGFloat angle = acos(1- deltaH/175);
    return angle;
}


- (void)setState:(CircleHeadViewStatus)aState{
    switch (aState) {
        case CircleHeadViewStatusMinHeight:
            break;
        case CircleHeadViewStatusPulling:
            break;
        case CircleHeadViewStatusMaxHeight:
            break;
        default:
            break;
    }
    _viewStatus = aState;
}




@end
