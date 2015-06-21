//
//  JLYData.m
//  MyAccountBook
//
//  Created by LingyuJi on 15/6/19.
//  Copyright (c) 2015年 LingyuJi. All rights reserved.
//

#import "JLYData.h"

@implementation JLYData

+ (NSArray *)dataWithDictArray:(NSArray *)dicts
{
    NSMutableArray *temp = [@[] mutableCopy];
    for (NSDictionary *dict in dicts) {
        JLYData *data = [self dataWithDict:dict];
        [temp addObject:data];
    }
    return [temp copy];
}

+ (instancetype)dataWithDict:(NSDictionary *)dict
{
    JLYData *data = [[JLYData alloc] init];
    data.date = dict[@"Date"];
    data.rate = dict[@"Rate"];
    data.totalAssets = [dict[@"TotalAssets"] integerValue];
    data.profitAndLoss = [dict[@"ProfitAndLoss"] integerValue];
    return data;
}

@end
