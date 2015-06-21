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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title = @"My AccountBook";
    self.view.backgroundColor = [UIColor whiteColor];
    
    float width = self.view.frame.size.width / 4;
    NSArray *widths = @[@(width), @(width), @(width), @(width)];
    CGPoint startPoint = CGPointMake(0, 0);
    
    JLYTableView *jlyTableView = [[JLYTableView alloc] initWithFrame:self.view.bounds];
    [jlyTableView startWithWidths:widths
                       startPoint:startPoint
                        plistFile:@"datas"];
    
    NSArray *actions = @[sNoAction, @"printTotalAssets:", sNoAction, sNoAction];
    [jlyTableView setActions:actions WithTarget:self];
    
    NSArray *titles = @[@"Date", @"TotalAssets", @"Profit&Loss", @"Rate"];
    [jlyTableView setHeaderViewWithTitle:titles height:24];
    
    [self.view addSubview:jlyTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)printDate:(UIButton *)sender
{
    NSLog(@"%@",sender.currentTitle);
}

- (void)printTotalAssets:(UIButton *)sender
{
    NSLog(@"%@",sender.currentTitle);
}


@end
