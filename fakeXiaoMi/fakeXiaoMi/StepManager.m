//
//  SportSDK.m
//  fakeXiaoMi
//
//  Created by WangJian on 15/4/5.
//  Copyright (c) 2015年 kkgo. All rights reserved.
//

#import "StepManager.h"
#import <UIKit/UIKit.h>
@interface StepManager(){
    NSOperationQueue *_stepsQueue;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) CMStepCounter *stepCounter;

@property (assign) NSInteger stepsToday;
@property (assign) NSInteger stephsAtBeginOfLiveCounting;
@property (assign) NSInteger isLiveCounting;

@end

@implementation StepManager
static StepManager *shareInstance  = nil;
+(StepManager *)sharedInstance{
    static StepManager *shareInstance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareInstance == nil) {
            shareInstance = [[StepManager alloc] init];            
        }
    });
    return shareInstance;
}

- (instancetype)init {
    if ((self = [super init])) {
        _stepCounter = [[CMStepCounter alloc] init];
        self.stepsToday = -1;
        
        NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
        [noteCenter addObserver:self selector:@selector(timeChangedSignificantly:) name:UIApplicationSignificantTimeChangeNotification object:nil];
        [noteCenter addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [noteCenter addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        _stepsQueue = [[NSOperationQueue alloc] init];
        _stepsQueue.maxConcurrentOperationCount = 1;
        
        [self _updateStepsTodayFromHistoryLive:YES];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)_updateStepsTodayFromHistoryLive:(BOOL)startLiveCounting
{
    if (![CMStepCounter isStepCountingAvailable]) {
        NSLog(@"本机不支持计步功能");
        self.stepsToday = -1;
        return;
    }
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:now];
    
    NSDate *beginOfDay = [calendar dateFromComponents:components];
    
    [_stepCounter queryStepCountStartingFrom:beginOfDay
                                          to:now
                                     toQueue:_stepsQueue withHandler:^(NSInteger numberOfSteps, NSError *error) {
                                         if (error) {
                                             NSLog(@"%@", [error localizedDescription]);
                                             self.stepsToday = -1;
                                         } else {
                                             self.stepsToday = numberOfSteps;
                                             if (startLiveCounting) {
                                                 [self _startLiveCounting];
                                             }
                                         }
                                     }];
}

- (void)_startLiveCounting {
    if (_isLiveCounting) {
        return;
    }
    
    _isLiveCounting = YES;
    _stephsAtBeginOfLiveCounting = self.stepsToday;
    [_stepCounter startStepCountingUpdatesToQueue:_stepsQueue
                                         updateOn:1
                                      withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
                                          self.stepsToday = _stephsAtBeginOfLiveCounting + numberOfSteps;
                                          NSLog(@"self....%ld",(long)self.stepsToday);
                                      }];
    NSLog(@"开始实时计步");
}

- (void)_stopLiveCounting
{
    if (!_isLiveCounting) {
        return;
    }
    
    [_stepCounter stopStepCountingUpdates];
    _isLiveCounting = NO;
    NSLog(@"停止实时计步");
}

- (void)timeChangedSignificantly:(NSNotification *)notification {
    [self _stopLiveCounting];
    [self _updateStepsTodayFromHistoryLive:YES];
}

- (void)willEnterForeground:(NSNotification *)notification {
    [self _updateStepsTodayFromHistoryLive:YES];
}

- (void)didEnterBackground:(NSNotification *)notification {
    [self _stopLiveCounting];
}
#pragma clang diagnostic pop

@end
