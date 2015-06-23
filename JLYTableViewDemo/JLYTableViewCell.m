//
//  JLYTableViewCell.m
//  MyAccountBook
//
//  Created by LingyuJi on 15/6/18.
//  Copyright (c) 2015年 LingyuJi. All rights reserved.
//

#import "JLYTableViewCell.h"

@interface JLYTableViewCell()
@property (nonatomic, assign) CGFloat margin;
@end

@implementation JLYTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)initializeWithRowIndex:(NSInteger)rowIndex
{
    /**
     *  Column count
     */
    NSInteger columnCount;
    
    if ([self.delegate respondsToSelector:@selector(tableViewCell:columnsInRow:)]) {
        columnCount = [self.delegate tableViewCell:self columnsInRow:rowIndex];
    }
    
    /**
     *  Height
     */
    CGFloat originX = 0.f;
    CGFloat originY = 0.f;
    CGFloat height;
    
    if ([self.delegate respondsToSelector:@selector(tableViewCell:heightForRow:)]) {
        height = [self.delegate tableViewCell:self heightForRow:rowIndex];
    }
    else
    {
        height = 20;
    }
    
    //
    for (NSInteger i = 0; i < columnCount; ++i)
    {
        /**
         *  Width
         */
        CGFloat width;
        
        if ([self.delegate respondsToSelector:@selector(tableViewCell:widthForColumn:)]) {
            width = [self.delegate tableViewCell:self widthForColumn:i];
        }
        
        /**
         *  Action
         */
        BOOL action = NO;
        
        if ([self.delegate respondsToSelector:@selector(tableViewCell:addActionForColumn:inRow:)]) {
            action = [self.delegate tableViewCell:self addActionForColumn:i inRow:rowIndex];
        }
        
        /**
         *  UIButton
         */
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
        
        
        /**
         *  bg color
         */
        if ([self.delegate respondsToSelector:@selector(tableViewCell:colorOfColumn:inRow:)]) {
            UIColor *bgColor = [self.delegate tableViewCell:self colorOfColumn:i inRow:rowIndex];

        }
        
        //[btn setBackgroundImage:backImage forState:UIControlStateNormal];
        //[btn setBackgroundImage:[backImage imageByApplyingAlpha:0.4] forState:UIControlStateHighlighted];
        
        
        /**
         *  Title Color
         */
        UIColor *titleColor = nil;
        
        if ([self.delegate respondsToSelector:@selector(tableViewCell:contentColorOfColumn:inRow:)]) {
            titleColor = [self.delegate tableViewCell:self contentColorOfColumn:i inRow:rowIndex];
        }
        
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitleColor:[titleColor colorWithAlphaComponent:0.4f] forState:UIControlStateHighlighted];
        
        
        /**
         *  Title
         */
        NSString *text = nil;
        
        if ([self.delegate respondsToSelector:@selector(tableViewCell:textForColumn:inRow:)]) {
            text = [self.delegate tableViewCell:self textForColumn:i inRow:rowIndex];
        }
        
        [btn setTitle:text forState:UIControlStateNormal];
        
        /**
         *  Font
         */
        UIFont *font = nil;

        if ([self.delegate respondsToSelector:@selector(tableViewCell:fontOfColumn:)]) {
            font = [self.delegate tableViewCell:self fontOfColumn:i];
        }
        
        [btn.titleLabel setFont:font];
        
        //NSLog(@"col:%ld, row:%ld, font:%@", (long)i, (long)rowIndex, [font fontName]);
        
        
        /**
         *  Mode
         */
        CGFloat textWidth = [btn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName : font}
                                                           context:nil].size.width;
        if (self.mode == JLYTableViewCellModeLeft)
        {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, self.margin, 0, width - self.margin - textWidth);
        }
        else if (self.mode == JLYTableViewCellModeRight)
        {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, width - self.margin - textWidth, 0, self.margin);
        }
        
        /**
         *  Border Width
         */
        CGFloat bordeWidth;
        
        if ([self.delegate respondsToSelector:@selector(tableViewCellBorderWidth:)]) {
            bordeWidth = [self.delegate tableViewCellBorderWidth:self];
        }
        
        [btn.layer setBorderWidth:bordeWidth];
        
        /**
         *  Border Color
         */
        UIColor *borderColor = nil;
        
        if ([self.delegate respondsToSelector:@selector(tableViewCellBorderColor:)]) {
            borderColor = [self.delegate tableViewCellBorderColor:self];
        }
        
        [btn.layer setBorderColor:borderColor.CGColor];

        /**
         *  Tag
         */
        btn.tag = 10000 + rowIndex * 100 + i;
        
        [self addSubview:btn];
        
        /**
         *  AddEvent
         */
        if (action)
        {
            [btn addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            btn.userInteractionEnabled = NO;
        }
        originX += width;
    }
}

- (void)initializeWithTitles:(NSArray *)titles
{
    /**
     *  Column count
     */
    NSInteger columnCount;
    columnCount = [titles count];
    
    /**
     *  Height
     */
    CGFloat originX = 0.f;
    CGFloat originY = 0.f;
    CGFloat height = self.frame.size.height;
    
    for (NSInteger i = 0; i < columnCount; ++i)
    {
        /**
         *  Width
         */
        CGFloat width;
        if ([self.delegate respondsToSelector:@selector(tableViewCell:widthForColumn:)]) {
            width = [self.delegate tableViewCell:self widthForColumn:i];
        }
        else
        {
            NSLog(@"warning!");
        }
        
        /**
         *  UILabel
         */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
        
        /**
         *  Title
         */
        label.text = [titles objectAtIndex:i];
        
        /**
         *  Title Color
         */
        UIColor *titleColor = nil;
        
        if ([self.delegate respondsToSelector:@selector(tableHeaderView:contentColorOfColumn:)]) {
            titleColor = [self.delegate tableHeaderView:self contentColorOfColumn:i];
        }
        
        [label setTextColor:titleColor];
        
        /**
         *  bg color
         */
        UIColor *bgColor = nil;
        if ([self.delegate respondsToSelector:@selector(tableHeaderView:colorOfColumn:)]) {
            bgColor = [self.delegate tableHeaderView:self colorOfColumn:i];
        }

        [label setBackgroundColor:bgColor];
        
        /**
         *  Font
         */
        UIFont *font = nil;
        
        if ([self.delegate respondsToSelector:@selector(tableHeaderView:fontOfColumn:)]) {
            font = [self.delegate tableHeaderView:self fontOfColumn:i];
        }

        label.font = font;
        
        /**
         *  Alignment
         */
        if ([self.delegate respondsToSelector:@selector(tableHeaderViewAlignment:)]) {
            label.textAlignment = [self.delegate tableHeaderViewAlignment:self];
        }

        /**
         *  Border Width
         */
        CGFloat bordeWidth;
        
        if ([self.delegate respondsToSelector:@selector(tableHeaderViewBorderWidth:)]) {
            bordeWidth = [self.delegate tableHeaderViewBorderWidth:self];
        }
        else
        {
            bordeWidth = 1.0;
        }

        [label.layer setBorderWidth:bordeWidth];
        
        /**
         *  Border Color
         */
        UIColor *borderColor = nil;
        
        if ([self.delegate respondsToSelector:@selector(tableHeaderViewBorderColor:)]) {
            borderColor = [self.delegate tableHeaderViewBorderColor:self];
        }
        
        [label.layer setBorderColor:borderColor.CGColor];
        
        [self addSubview:label];
        
        originX += width;
    }
    
}

- (void)setMode:(JLYTableViewCellMode)mode withMargin:(CGFloat)margin
{
    _mode = mode;
    _margin = margin;
}


- (UIColor *)colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)itemClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(tableViewCell:didSelectColumn:inRow:)]) {
        NSInteger row = (sender.tag - 10000) / 100;
        NSInteger col = (sender.tag - 10000) - row * 100;
        [self.delegate tableViewCell:self didSelectColumn:col inRow:row];
    }
}

@end
