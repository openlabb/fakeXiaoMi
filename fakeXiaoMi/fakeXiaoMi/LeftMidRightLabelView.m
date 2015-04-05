//
//  LeftMidRightLabelView.m
//  fakeXiaoMi
//
//  Created by WangJian on 15/4/5.
//  Copyright (c) 2015年 kkgo. All rights reserved.
//

#import "LeftMidRightLabelView.h"
#import "UILabel+StringFrame.h"
#define kPrefixLabelFrame CGRectMake(0, 0, 200, self.frame.size.height)

@implementation LeftMidRightLabelView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconLeft];
        [self addSubview:self.textLeft];
        [self addSubview:self.textMid];
        [self addSubview:self.textRight];
        [self.iconLeft addObserver:self forKeyPath:@"image" options:(NSKeyValueObservingOptionNew) context:Nil];
        [self.textLeft addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew) context:Nil];
        [self.textMid addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew) context:Nil];
        [self.textRight addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew) context:Nil];

    }
    return self;
}

- (UIImageView *)iconLeft {
    if (!_iconLeft) {
        _iconLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18,18)];
    }
    return _iconLeft;
}

- (UILabel *)textLeft {
    if (!_textLeft) {
        UILabel *tempView  = [[UILabel alloc] initWithFrame:kPrefixLabelFrame];
        _textLeft = tempView;
        _textLeft.backgroundColor = [UIColor clearColor];
        _textLeft.textColor =  [UIColor colorWithRed:94/255.0 green:94/255.0 blue:94/255.0  alpha:1];
        _textLeft.font = [UIFont boldSystemFontOfSize:15];
    }
    return _textLeft;
}

- (UILabel *)textMid {
    if (!_textMid) {
        UILabel *tempView  = [[UILabel alloc] initWithFrame:kPrefixLabelFrame];
        _textMid = tempView;
        _textMid.backgroundColor = [UIColor clearColor];
        _textMid.textColor =  [UIColor colorWithRed:94/255.0 green:94/255.0 blue:94/255.0  alpha:1];
        _textMid.font = [UIFont boldSystemFontOfSize:15];
    }
    return _textMid;
}

- (UILabel *)textRight {
    if (!_textRight) {
        UILabel *tempView  = [[UILabel alloc] initWithFrame:kPrefixLabelFrame];
        _textRight = tempView;
        _textRight.backgroundColor = [UIColor clearColor];
        _textRight.textColor =  [UIColor colorWithRed:94/255.0 green:94/255.0 blue:94/255.0  alpha:1];
        _textRight.font = [UIFont boldSystemFontOfSize:15];
    }
    return _textRight;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"text"]) {
        //调整行间距不管用 中文和数字底部仍然不在同一水平线
//        UILabel *label = (UILabel *)object;
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:change[@"new"]];
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:0];
//        
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [change[@"new"] length])];
//        label.attributedText = attributedString;

        if ([object isEqual:self.textLeft]) {

        }
    }else if ([keyPath isEqualToString:@"image"]) {
        
    }
    [self calculateLayout];
}


- (CGSize)getSize:(UILabel *)l{
     //[l boundingRectWithSize:l.frame.size];
    [l sizeToFit];
    return CGSizeMake(ceilf(l.frame.size.width), ceilf(l.frame.size.height));
}

- (void)calculateLayout{
    //最右必须完全显示的
    //最左也是
    //中间可以虐
    BOOL startWithIcon = NO;
    CGSize leftS = CGSizeZero;
    CGSize midS = CGSizeZero;
    CGSize rightS = CGSizeZero;
    float maxW = 0;
    float startX = 0;
    float startY = 0;

    
    if (self.iconLeft.image == nil) {
        leftS =  [self getSize:self.textLeft];
        startY =  self.frame.size.height - leftS.height;
        self.iconLeft.hidden = YES;
    }else{
        leftS = self.iconLeft.frame.size;
        startY =  self.frame.size.height - leftS.height - 5;
        self.iconLeft.hidden = NO;
        startWithIcon = YES;
    }
    maxW += leftS.width;

    midS = [self getSize:self.textMid];
    maxW += midS.width;

    rightS = [self getSize:self.textRight];;
    maxW += rightS.width;

    switch (self.alignment) {
        case NSTextAlignmentLeft:
            startX = 0;
            break;
        case NSTextAlignmentCenter:
            startX = (self.frame.size.width - maxW)/2;
            break;
        case NSTextAlignmentRight:
            startX = self.frame.size.width - maxW;
            break;
        default:
            break;
    }
    
    CGRect r = CGRectZero;
    if (startWithIcon == YES) {
        r = self.iconLeft.frame;
        r.origin.x = startX;
        r.origin.y =  startY ;
        self.iconLeft.frame = r;
    }else{
        r = self.textLeft.frame;
        r.origin.x = startX;
        r.origin.y =  startY ;
        r.size = leftS;
        self.textLeft.frame = r;
    }
    
    r.origin.x += r.size.width;
    r.origin.y = (self.frame.size.height - midS.height) ;
    r.size = midS;
    if(r.origin.y < 0){
        NSLog(@"xx %@",self.textMid);
    }

    self.textMid.frame = r;
    
    r.origin.x += r.size.width;
    r.origin.y =  (self.frame.size.height - rightS.height) ;
    if([self.textRight.text isEqualToString:@"步"]){
        //数字和中文底部没法放到一个水平线 ， 行间距为0也不好使 tricky
        r.origin.y -= 6;
    }
    
    if([self.textRight.text isEqualToString:@"公里"]){
        //数字和中文底部没法放到一个水平线 ， 行间距为0也不好使 tricky
        r.origin.y -= 2;
    }

    if(r.origin.y < 0){
                NSLog(@"xxx %@",self.textRight);
    }
    r.size = rightS;
    self.textRight.frame = r;
}


#pragma mark - Memory Management
- (void)dealloc {
    [self.textLeft removeObserver:self forKeyPath:@"text"];
    [self.textMid removeObserver:self forKeyPath:@"text"];
    [self.textRight removeObserver:self forKeyPath:@"text"];
    self.textLeft = nil;
    self.textMid = nil;
    self.textRight = nil;
    self.iconLeft.image = nil;
    self.iconLeft = nil;
}


@end
