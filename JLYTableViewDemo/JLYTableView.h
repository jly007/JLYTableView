//
//  JLYTableView.h
//  MyAccountBook
//
//  Created by LingyuJi on 15/6/18.
//  Copyright (c) 2015年 LingyuJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLYTableView : UIView

- (void)startWithWidths:(NSArray *)widths startPoint:(CGPoint)point plistFile:(NSString *)plist;

- (void)setActions:(NSArray *)actions WithTarget:(id)target;

- (void)setHeaderViewWithTitle:(NSArray *)titles height:(CGFloat)height;

@end



