//
//  JLYTableView.m
//  MyAccountBook
//
//  Created by LingyuJi on 15/6/18.
//  Copyright (c) 2015年 LingyuJi. All rights reserved.
//

#import "JLYTableView.h"
#import "JLYTableViewCell.h"
#import "JLYData.h"
#import "JLYTableViewGlobals.h"
#import "NSString+Number.h"

@interface JLYTableView () <UITableViewDataSource, UITableViewDelegate, JLYTableViewCellDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, strong) NSMutableArray *records;
@property (nonatomic, strong) NSMutableArray *actions;
@property (nonatomic, strong) NSMutableArray *widths;
@property (nonatomic, strong) id target;
@property (nonatomic, strong) JLYTableViewCell *headerView; // not weak!

@end

@implementation JLYTableView


- (void)startWithWidths:(NSArray *)widths startPoint:(CGPoint)point plistFile:(NSString *)plist
{
    NSArray *plistData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plist ofType:@"plist"]];
    NSArray *jlyData = [JLYData dataWithDictArray:plistData];
    
    for (JLYData *data in jlyData) {
        NSArray *record = @[data.date,
                            [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%ld",(long)data.totalAssets]],
                            [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%ld",(long)data.profitAndLoss]],
                            data.rate];
        [self addRecord:record];
    }
    
    
    self.widths = [widths mutableCopy];
    if (!_tableView) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView = tempTableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        
    }
    self.tableView.frame = CGRectOffset(self.tableView.frame, point.x, point.y);
}

- (void)setActions:(NSArray *)actions WithTarget:(id)target
{
    self.target = target;
    if (actions) {
        NSInteger count = [self.records count];
        for (NSInteger i = 0; i < count; i++) {
            [self.actions addObject:actions];
        }
    }
}

- (void)addRecord:(NSArray *)record
{
    if (!self.records) {
        self.records = [@[] mutableCopy];
        self.actions = [@[] mutableCopy];
    }
    [self.records addObject:record];
}

- (void)setHeaderViewWithTitle:(NSArray *)titles height:(CGFloat)height
{
    _headerView = [[JLYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HEADER"];
    _headerView.delegate = self;
    [_headerView setFrame:CGRectMake(0, 0, self.frame.size.width, height)];
    [_headerView initializeWithTitles:titles];
    //_headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = nil;
}

#pragma mark - TableView DataSouse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.records count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"JLYTableViewCell";
    
    JLYTableViewCell *cell = nil; //[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[JLYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        [cell setFrame:CGRectMake(0, 0, _tableView.frame.size.width, 44)];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell initializeWithRowIndex:indexPath.row];
        
    }

    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_headerView) {
        return [_headerView frame].size.height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_headerView) {
        return _headerView;
    }
    return nil;
}

#pragma mark - JLYTableViewCell Delegate

- (NSInteger)tableViewCell:(JLYTableViewCell *)tableViewCell columnsInRow:(NSInteger)index
{
    return [self.widths count];
}

- (CGFloat)tableViewCell:(JLYTableViewCell *)tableViewCell widthForColumn:(NSInteger)column
{
    return [self.widths[column] floatValue];
}

- (NSString *)tableViewCell:(JLYTableViewCell *)tableViewCell textForColumn:(NSInteger)column inRow:(NSInteger)row
{
    return self.records[row][column];
}

- (CGFloat)tableViewCell:(JLYTableViewCell *)tableViewCell heightForRow:(NSInteger)row
{
    return 20.0;
}

- (UIColor *)tableViewCell:(JLYTableViewCell *)tableViewCell colorOfColumn:(NSInteger)column inRow:(NSInteger)row
{
    return [UIColor whiteColor];
}

- (UIColor *)tableViewCell:(JLYTableViewCell *)tableViewCell contentColorOfColumn:(NSInteger)column inRow:(NSInteger)row
{
    UIColor *color = nil;
    
    if (column == 0) {
        color = [UIColor colorWithRed:75/255.f green:55/255.f blue:39/255.f alpha:1.0];
    }
    else if (column == 1) {
        color = [UIColor colorWithRed:75/255.f green:55/255.f blue:39/255.f alpha:1.0];
    }
    else if (column == 2) {
        if (row % 2 != 0) {
            color = [UIColor colorWithRed:255/255.f green:0.f blue:0.f alpha:1.0];
        }
        else
        {
            color = [UIColor colorWithRed:0.f green:255/255.f blue:0.f alpha:1.0];
        }
    }
    else if (column == 3) {
        if (row % 2 != 0) {
            color = [UIColor colorWithRed:255/255.f green:0.f blue:0.f alpha:1.0];
        }
        else
        {
            color = [UIColor colorWithRed:0.f green:255/255.f blue:0.f alpha:1.0];
        }
    }
    return color;
}

- (UIColor *)tableViewCellBorderColor:(JLYTableViewCell *)tableViewCell
{
    return [UIColor lightGrayColor];
}

- (CGFloat)tableViewCellBorderWidth:(JLYTableViewCell *)tableViewCell
{
    return 0.5;
}

- (UIFont *)tableViewCell:(JLYTableViewCell *)tableViewCell fontOfColumn:(NSInteger)column
{
    return [UIFont systemFontOfSize:12];
}

- (BOOL)tableViewCell:(JLYTableViewCell *)tableViewCell addActionForColumn:(NSInteger)column inRow:(NSInteger)row
{
    //NSLog(@"actions:%@", self.actions);
    
    if (0 == [self.actions count] || [self.actions[row][column] isEqualToString:sNoAction]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)tableViewCell:(JLYTableViewCell *)tableViewCell didSelectColumn:(NSInteger)column inRow:(NSInteger)row
{
    //NSLog(@"col:%ld, row:%ld", (long)column, (long)row);
    
    if (![self.actions[row][column] isEqualToString:sNoAction]) {
        SEL sel = NSSelectorFromString(self.actions[row][column]);
        
        NSInteger tag = 10000 + row * 100 + column;
        UIButton *btn = (UIButton *)[tableViewCell viewWithTag:tag];
        
        if ([self.target respondsToSelector:sel]) {
            
            [self.target performSelector:sel withObject:btn];
        }
    }
}

- (UIColor *)tableHeaderViewBorderColor:(JLYTableViewCell *)headerView
{
    return [UIColor lightGrayColor];
}

- (CGFloat)tableHeaderViewBorderWidth:(JLYTableViewCell *)headerView
{
    return 1.0;
}

- (UIColor *)tableHeaderView:(JLYTableViewCell *)headerView colorOfColumn:(NSInteger)column
{
    return [UIColor colorWithRed:239/255.0 green:244/255.0 blue:254/255.0 alpha:1.0];
}

- (UIColor *)tableHeaderView:(JLYTableViewCell *)headerView contentColorOfColumn:(NSInteger)column
{
    return [UIColor blackColor];
}

- (UIFont *)tableHeaderView:(JLYTableViewCell *)headerView fontOfColumn:(NSInteger)column
{
    return [UIFont boldSystemFontOfSize:14];
}

- (NSTextAlignment)tableHeaderViewAlignment:(JLYTableViewCell *)headerView
{
    return NSTextAlignmentCenter;
}

@end
