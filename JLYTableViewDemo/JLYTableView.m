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
@property (nonatomic, strong) JLYTableViewCell *headerView; // not weak!

@end

@implementation JLYTableView

- (id)initWithFrame:(CGRect)rect
               widths:(NSArray *)widths
            plistFile:(NSString *)fileName
              actions:(NSArray *)actions
     headerViewTitles:(NSArray *)titles
     headerViewHeight:(CGFloat)height
             delegate:(id)delegate
{
    self = [super initWithFrame:rect];
    
    if (self) {
        
        [self startWithWidths:widths plistFile:fileName];

        [self setActions:actions withDelegate:delegate];
        
        [self setHeaderViewWithTitle:titles height:height];
    }
    
    return self;
}
- (void)startWithWidths:(NSArray *)widths plistFile:(NSString *)plist
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
}

- (void)setActions:(NSArray *)actions withDelegate:(id)delegate
{
    if (actions) {
        NSInteger count = [self.records count];
        for (NSInteger i = 0; i < count; i++) {
            [self.actions addObject:actions];
        }
    }
    self.delegate = delegate;
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

- (CGFloat)tableViewCell:(JLYTableViewCell *)tableViewCell heightForRow:(NSInteger)row
{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:heightForRow:)]) {
        return [self.delegate tableViewCell:tableViewCell heightForRow:row];
    }
    else
    {
        return 20;
    }
}

- (UIColor *)tableViewCell:(JLYTableViewCell *)tableViewCell colorOfColumn:(NSInteger)column inRow:(NSInteger)row
{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:colorOfColumn:inRow:)]) {
        return [self.delegate tableViewCell:tableViewCell colorOfColumn:column inRow:row];
    }
    else
    {
        return [UIColor whiteColor];
    }
}

- (UIColor *)tableViewCell:(JLYTableViewCell *)tableViewCell contentColorOfColumn:(NSInteger)column inRow:(NSInteger)row
{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:contentColorOfColumn:inRow:)]) {
        return [self.delegate tableViewCell:tableViewCell contentColorOfColumn:column inRow:row];
    }
    else
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
}

- (UIColor *)tableViewCellBorderColor:(JLYTableViewCell *)tableViewCell
{
    if ([self.delegate respondsToSelector:@selector(tableViewCellBorderColor:)]) {
        return [self.delegate tableViewCellBorderColor:tableViewCell];
    }
    else
    {
        return [UIColor lightGrayColor];
    }
}

- (CGFloat)tableViewCellBorderWidth:(JLYTableViewCell *)tableViewCell
{
    if ([self.delegate respondsToSelector:@selector(tableViewCellBorderWidth:)]) {
        return [self.delegate tableViewCellBorderWidth:tableViewCell];
    }
    else
    {
        return 0.5;
    }
}

- (UIFont *)tableViewCell:(JLYTableViewCell *)tableViewCell fontOfColumn:(NSInteger)column
{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:fontOfColumn:)]) {
        return [self.delegate tableViewCell:tableViewCell fontOfColumn:column];
    }
    else
    {
        return [UIFont systemFontOfSize:12];
    }
}

- (void)tableViewCell:(JLYTableViewCell *)tableViewCell didSelectColumn:(NSInteger)column inRow:(NSInteger)row
{
    NSLog(@"col:%ld, row:%ld", (long)column, (long)row);
    
    if (![self.actions[row][column] isEqualToString:sNoAction]) {
        SEL sel = NSSelectorFromString(self.actions[row][column]);
        
        NSInteger tag = 10000 + row * 100 + column;
        UIButton *btn = (UIButton *)[tableViewCell viewWithTag:tag];
        
        if ([self.delegate respondsToSelector:sel]) {
            
            [self.delegate performSelector:sel withObject:btn];
        }
        
        //UIColor *borderColor = [UIColor redColor];
        //[btn.layer setBorderColor:borderColor.CGColor];
        //[btn.layer setBorderWidth:2.0];
    }

    

}

- (UIColor *)tableHeaderViewBorderColor:(JLYTableViewCell *)headerView
{
    if ([self.delegate respondsToSelector:@selector(tableHeaderViewBorderColor:)]) {
        return [self.delegate tableHeaderViewBorderColor:headerView];
    }
    else
    {
        return [UIColor lightGrayColor];
    }
}

- (CGFloat)tableHeaderViewBorderWidth:(JLYTableViewCell *)headerView
{
    if ([self.delegate respondsToSelector:@selector(tableHeaderViewBorderWidth:)]) {
        return [self.delegate tableHeaderViewBorderWidth:headerView];
    }
    else
    {
        return 1.0;
    }
}

- (UIColor *)tableHeaderView:(JLYTableViewCell *)headerView colorOfColumn:(NSInteger)column
{
    if ([self.delegate respondsToSelector:@selector(tableHeaderView:colorOfColumn:)]) {
        return [self.delegate tableHeaderView:headerView colorOfColumn:column];
    }
    else
    {
        return [UIColor colorWithRed:239/255.0 green:244/255.0 blue:254/255.0 alpha:1.0];
    }
}

- (UIColor *)tableHeaderView:(JLYTableViewCell *)headerView contentColorOfColumn:(NSInteger)column
{
    if ([self.delegate respondsToSelector:@selector(tableHeaderView:contentColorOfColumn:)]) {
        return [self.delegate tableHeaderView:headerView contentColorOfColumn:column];
    }
    else
    {
        return [UIColor blackColor];
    }
}

- (UIFont *)tableHeaderView:(JLYTableViewCell *)headerView fontOfColumn:(NSInteger)column
{
    if ([self.delegate respondsToSelector:@selector(tableHeaderView:fontOfColumn:)]) {
        return [self.delegate tableHeaderView:headerView fontOfColumn:column];
    }
    else
    {
        return [UIFont boldSystemFontOfSize:14];
    }
}

- (NSTextAlignment)tableHeaderViewAlignment:(JLYTableViewCell *)headerView
{
    if ([self.delegate respondsToSelector:@selector(tableHeaderViewAlignment:)]) {
        return [self.delegate tableHeaderViewAlignment:headerView];
    }
    else
    {
        return NSTextAlignmentCenter;
    }
}

@end
