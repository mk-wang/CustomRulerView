//
//  RulerConfig.h
//  FaceYoga
//
//  Created by MK on 2023/12/21.
//

#import "RulerDefs.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RulerConfig;
@class RulerScaleConfig;

typedef NSString *_Nullable (^RulerConfigValueTextBuilder)(RulerConfig *, NSInteger, NSInteger);
typedef RulerScaleConfig *_Nullable (^RulerConfigScaleLengthBuilder)(RulerConfig *, NSInteger, NSInteger);

@interface RulerScaleConfig : NSObject

@property (nonatomic, assign) CGFloat length; /**< 刻度长度  */
@property (nonatomic, assign) CGFloat start;  /**< 刻度起始位置  */
@property (nonatomic, nonnull, strong) UIColor *color;

+ (instancetype)scaleWithLength:(CGFloat)length start:(CGFloat)start;
+ (instancetype)scaleWithLength:(CGFloat)length start:(CGFloat)start color:(UIColor *_Nullable)color;

- (instancetype)initWithLength:(CGFloat)length start:(CGFloat)start;
- (instancetype)initWithLength:(CGFloat)length start:(CGFloat)start color:(UIColor *_Nullable)color;

@end

@interface RulerConfig : NSObject

@property (nonatomic, assign) BOOL continuous;                              // 停止滚动才通知
@property (nonatomic, strong) RulerConfigScaleLengthBuilder scaleBuilder;   /**< 刻度长度，默认实现 index % 5 == 0 ? longScale :  shortScale */
@property (nonatomic, strong) RulerConfigValueTextBuilder valueTextBuilder; /**< 是否显示文字，模式实现 index % 10 == 0  */

// 视图属性
@property (nonatomic, strong) RulerScaleConfig *shortScale; /**< 短刻度 */
@property (nonatomic, strong) RulerScaleConfig *longScale;  /**< 长刻度  */

@property (nonatomic, assign) CGFloat scaleWidth;  /**< 刻度尺宽度  */
@property (nonatomic, strong) UIColor *scaleColor; /**< 刻度颜色  */

@property (nonatomic, assign) CGFloat distanceBetweenScale;         /**< 刻度之间的距离  */
@property (nonatomic, assign) RulerNumberDirection numberDirection; /**< 数字方向  */
@property (nonatomic, assign) CGFloat distanceFromScaleToNumber;    /**< 刻度和数字之间的距离  */
// 指示器
@property (nonatomic, assign) CGSize pointSize;    /**< 指示视图宽高  */
@property (nonatomic, strong) UIColor *pointColor; /**< 指示视图颜色  */
@property (nonatomic, assign) CGFloat pointStart;  /**< 指示器视图起始位置  */
// 数字属性
@property (nonatomic, strong) UIFont *numberFont;   /**< 数字字体  */
@property (nonatomic, strong) UIColor *numberColor; /**< 数字颜色  */
// 刻度相关
@property (nonatomic, assign) NSInteger max;        /**< 最大值  */
@property (nonatomic, assign) NSInteger min;        /**< 最小值  */
@property (nonatomic, assign) double defaultNumber; /**< 默认值  */
@property (nonatomic, assign) NSInteger offset;     /**< 每次偏移的刻度尺单位  */
// 选项
@property (nonatomic, assign) BOOL isDecimal;       /**< 保留一位小数类型  */
@property (nonatomic, assign) BOOL selectionEnable; /**< 是否允许选中  */
@property (nonatomic, assign) BOOL useGradient;     /**< 是否使用渐变色  */
@property (nonatomic, assign) BOOL reverse;         /**< 刻度尺反向  */
@property (nonatomic, assign) BOOL infiniteLoop;    /**< 刻度尺循环  */

//
@property (nonatomic, assign) BOOL numberFlip; /**< 数字水平翻转  */

@end

NS_ASSUME_NONNULL_END
