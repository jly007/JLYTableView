//
//  JLYTableViewCell.h
//  MyAccountBook
//
//  Created by LingyuJi on 15/6/18.
//  Copyright (c) 2015年 LingyuJi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JLYTableViewCellMode)
{
    JLYTableViewCellModeCenter,
    JLYTableViewCellModeLeft,
    JLYTableViewCellModeRight,
};

@class JLYTableViewCell;

@protocol JLYTableViewCellDelegate <NSObject>

// return column number
- (NSInteger)tableViewCell:(JLYTableViewCell *)tableViewCell columnsInRow:(NSInteger)index;

// return width of column
- (CGFloat)tableViewCell:(JLYTableViewCell *)tableViewCell widthForColumn:(NSInteger)column;

// return text for each cell
- (NSString *)tableViewCell:(JLYTableViewCell *)tableViewCell textForColumn:(NSInteger)column inRow:(NSInteger)row;

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

// return  NSString *actions[row][col] == sNoAction
- (BOOL)tableViewCell:(JLYTableViewCell *)tableViewCell addActionForColumn:(NSInteger)column inRow:(NSInteger)row;

// tap a cell
- (void)tableViewCell:(JLYTableViewCell *)tableViewCell didSelectColumn:(NSInteger)column inRow:(NSInteger)row;

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



@interface JLYTableViewCell : UITableViewCell

@property (nonatomic, weak) id <JLYTableViewCellDelegate> delegate;
@property (nonatomic, assign ,readonly) JLYTableViewCellMode mode;

- (void)setMode:(JLYTableViewCellMode)mode withMargin:(CGFloat)margin;
- (void)initializeWithRowIndex:(NSInteger)rowIndex;
- (void)initializeWithTitles:(NSArray *)titles;

@end
