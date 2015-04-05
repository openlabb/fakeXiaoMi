//
//  SportSDK.h
//  fakeXiaoMi
//
//  Created by WangJian on 15/4/5.
//  Copyright (c) 2015年 kkgo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface StepManager : NSObject
@property (readonly) NSInteger stepsToday;

+(StepManager *)sharedInstance;
@end
