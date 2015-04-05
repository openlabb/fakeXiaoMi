//
//  ScrollViewController.m
//  fakeXiaoMi
//
//  Created by WangJian on 15/4/3.
//  Copyright (c) 2015年 kkgo. All rights reserved.
//

#import "ScrollViewController.h"

@implementation ScrollViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    UIScrollView * sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    sv.delegate = self;
    sv.backgroundColor = [UIColor orangeColor];
    sv.contentInset = UIEdgeInsetsMake(460, 0, 0, 0);

    sv.contentSize = CGSizeMake(320, 1000);
    sv.contentOffset = CGPointMake(0, -460);
    sv.bounces = NO;
    [self.view addSubview:sv];
    
    //    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    //    label.text = @"label in scrollView";
    //    [sv addSubview:label];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, -460, 320, 460)];
    view.backgroundColor = [UIColor grayColor];
    [sv addSubview:view];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    label1.text = @"hello world!000";
    label1.backgroundColor = [UIColor blueColor];

    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, 320, 30)];
    label2.text = @"hello world!260";
    
    
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, 320, 30)];
    label3.text = @"hello world!280";

    UILabel * label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 430, 320, 30)];
    label4.text = @"hello world!430";
    label4.backgroundColor = [UIColor blueColor];

    
    UILabel * label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 460, 374, 30)];
    label5.text = @"hello world!460";
    label5.backgroundColor = [UIColor whiteColor];

    


    [view addSubview:label4];
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:label3];
    [view addSubview:label5];

    sv.scrollIndicatorInsets =  sv.contentInset;


    NSLog(@"sv.contentSize = {%f,%f}",sv.contentSize.width,sv.contentSize.height);
    NSLog(@"scrollView.contentInset.top = %f",sv.contentInset.top);
    NSLog(@"scrollView.contentInset.bottom = %f",sv.contentInset.bottom);


    

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
    NSLog(@"contentOffset.y = %f",scrollView.contentOffset.y);
    NSLog(@"scrollView.contentInset.y = %f",scrollView.contentInset.top);
    NSLog(@"scrollView.contentInset.bottom = %f",scrollView.contentInset.bottom);
//    if (scrollView.contentOffset.y <= -260) {
//        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 260);
//    }

//    scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);

//    if(scrollView.contentOffset.y <= -35)
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
//    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    NSLog(@"scllView.contentSize = {%f,%f}",scrollView.contentSize.width,scrollView.contentSize.height);
    //scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}


@end
