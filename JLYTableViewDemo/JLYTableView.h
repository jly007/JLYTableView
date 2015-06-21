//
//  JLYTableView.h
//  MyAccountBook
//
//  Created by LingyuJi on 15/6/18.
//  Copyright (c) 2015年 LingyuJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLYTableViewCell;

@protocol JLYTableViewDelegate <NSObject>

@optional

// return height of row
- (CGFloat)tableViewCell:(JLYTableViewCell *)tableViewCell heightForRow:(NSInteger)row;

// return bgcolor of each cell
- (UIColor *)tableViewCell:(JLYTableViewCell *)tableViewCell colorOfColumn:(NSInteger)column inRow:(NSInteger)row;

// return text color of each cell
- (UIColor *)tableViewCell:(JLYTableViewCell *)tableViewCell contentColorOfColumn:(NSInteger)column inRow:(NSInteger)row;

//return border color
- (UIColor *)tableViewCellBorderColor:(JLYTableViewCell *)tableViewCell;

//return border width
- (CGFloat)tableViewCellBorderWidth:(JLYTableViewCell *)tableViewCell;

// return font of text
- (UIFont *)tableViewCell:(JLYTableViewCell *)tableViewCell fontOfColumn:(NSInteger)column;

//return border color
- (UIColor *)tableHeaderViewBorderColor:(JLYTableViewCell *)headerView;

//return border width
- (CGFloat)tableHeaderViewBorderWidth:(JLYTableViewCell *)headerView;

// return bgcolor of headerView cell
- (UIColor *)tableHeaderView:(JLYTableViewCell *)headerView colorOfColumn:(NSInteger)column;

// return text color of headerView cell
- (UIColor *)tableHeaderView:(JLYTableViewCell *)headerView contentColorOfColumn:(NSInteger)column;

// return font of headerView text
- (UIFont *)tableHeaderView:(JLYTableViewCell *)headerView fontOfColumn:(NSInteger)column;

// return alignment of headerView text
- (NSTextAlignment)tableHeaderViewAlignment:(JLYTableViewCell *)headerView;


@end

@interface JLYTableView : UIView

@property (nonatomic, weak) id <JLYTableViewDelegate> delegate;

- (id)initWithFrame:(CGRect)rect
               widths:(NSArray *)widths
            plistFile:(NSString *)fileName
              actions:(NSArray *)actions
     headerViewTitles:(NSArray *)titles
     headerViewHeight:(CGFloat)height
             delegate:(id)delegate;

@end



