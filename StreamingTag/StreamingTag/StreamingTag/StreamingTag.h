//
//  StreamingTag.h
//  StreamingTag
//
//  Created by MyMac on 15/10/24.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StreamingTag : UIView

/**
 *  整个View背景
 */
@property (nonatomic,strong) UIColor *StreamTagViewBg;

/**
 *  设置单一颜色
 */
@property (nonatomic,strong) UIColor *singleTagColor;

/**
 *  回调统计选中tag
 */
@property (nonatomic,copy) void (^didselectedItemBlock)(NSArray *arr);

/**
 *  能否点击
 */
@property (nonatomic,assign) BOOL canTouch;

/**
 *  标签文本赋值
 *
 *  @param arr 传入的标签文本数组
 */
- (void)setTagWithTagArr:(NSArray *)arr;

@end
