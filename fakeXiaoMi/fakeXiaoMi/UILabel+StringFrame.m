//
//  UILabel+StringFrame.m
//  LabelHeight
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//
//  Modified BY WangJian 2015-04-05
//  添加对ios6的支持和deprecated警告的关闭
#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)

- (CGSize)boundingRectWithSize:(CGSize)size
{
    CGSize retSize = CGSizeZero;
    if ([self.text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attribute = @{NSFontAttributeName: self.font};
       retSize =  [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
        

    }else{
#pragma clang diagnostic push
        
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        retSize =  [self.text sizeWithFont:self.font constrainedToSize:size];

#pragma clang diagnostic pop

    }
    
    CGFloat height = ceilf(retSize.height);
    CGFloat width  = ceilf(retSize.width);

    return CGSizeMake(width, height);
}



@end
