//
//  RulerView.h
//  TYFitFore
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 tangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RulerConfig;
@protocol RulerViewDelegate <NSObject>

// RulerConfig.isDecimal 是 10倍的 整数
- (void)rulerSelectValue:(NSInteger)value tag:(NSInteger)tag;

@end

@interface RulerView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       config:(RulerConfig *)config;

@property (nonatomic, strong) RulerConfig *rulerConfig;     /**< 属性设置  */
@property (nonatomic, weak) id<RulerViewDelegate> delegate; /**< 代理  */

@end

NS_ASSUME_NONNULL_END
