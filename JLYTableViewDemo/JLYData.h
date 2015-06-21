//
//  JLYData.h
//  MyAccountBook
//
//  Created by LingyuJi on 15/6/19.
//  Copyright (c) 2015年 LingyuJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLYData : NSObject

@property (nonatomic, copy)   NSString *date;
@property (nonatomic, copy)   NSString *rate;
@property (nonatomic, assign) NSInteger totalAssets;
@property (nonatomic, assign) NSInteger profitAndLoss;

+ (NSArray *)dataWithDictArray:(NSArray *)dicts;

@end
