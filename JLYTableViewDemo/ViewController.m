//
//  ViewController.m
//  JLYTableViewDemo
//
//  Created by LingyuJi on 15/6/21.
//  Copyright (c) 2015年 LingyuJi. All rights reserved.
//

#import "ViewController.h"
#import "JLYData.h"
#import "JLYTableView.h"
#import "JLYTableViewCell.h"
#import "JLYTableViewGlobals.h"

@interface ViewController () <JLYTableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"My AccountBook";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = self.view.frame.size.width / 4;
    NSArray *widths = @[@(width), @(width), @(width), @(width)];
    NSString *plistFileName = @"dataSouce";
    NSArray *actions = @[@"printDate:", @"printTotalAssets:", sNoAction, sNoAction];
    NSArray *headerViewTitles = @[@"Date", @"TotalAssets", @"Profit&Loss", @"Rate"];
    CGFloat headerViewHeight = 24.0;
    
    JLYTableView *jlyTableView = [[JLYTableView alloc] initWithFrame:self.view.bounds
                                                              widths:widths
                                                           plistFile:plistFileName
                                                             actions:actions
                                                    headerViewTitles:headerViewTitles
                                                    headerViewHeight:headerViewHeight
                                                            delegate:self];
    [self.view addSubview:jlyTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)printDate:(UIButton *)sender
{
    NSLog(@"%@",sender.currentTitle);
}

- (void)printTotalAssets:(UIButton *)sender
{
    NSLog(@"%@",sender.currentTitle);
}

#pragma mark - JLYTableView Delegate

- (CGFloat)tableViewCell:(JLYTableViewCell *)tableViewCell heightForRow:(NSInteger)row
{
    return 20.0;
}


@end
