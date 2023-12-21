//
//  RulerCollectionViewCell.m
//  TYFitFore
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 tangpeng. All rights reserved.
//

#import "RulerCollectionViewCell.h"
#import "RulerConfig.h"
#import "RulerDefs_Private.h"
#import "RulerView.h"

#define kNumberTop (self.rulerConfig.numberDirection == numberTop)
#define kNumberBottom (self.rulerConfig.numberDirection == numberBottom)
#define kNumberLeft (self.rulerConfig.numberDirection == numberLeft)
#define kNumberRight (self.rulerConfig.numberDirection == numberRight)
#define kHorizontalCell (kNumberTop || kNumberBottom)

@interface RulerCollectionViewCell ()

@property (nonatomic, strong) UIImageView *ruleImageView;
@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) CATextLayer *selectTextLayer;

@end

@implementation RulerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.ruleImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    NSInteger value = [self.rulerConfig valueOf:self.index];
    NSString *text = self.rulerConfig.valueTextBuilder(self.rulerConfig, self.index, value);

    CGFloat shortScaleStart = self.rulerConfig.shortScale.start;
    CGFloat shortScaleLength = self.rulerConfig.shortScale.length;

    if (text != nil) {
        // 字体 (采用当前最大值的位数显示字体)
        CGSize size = [[self maxString] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH_RULER, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.rulerConfig.numberFont} context:nil].size;

        if (kHorizontalCell) {
            // 水平方向
            CGFloat startY = 0;
            if (kNumberTop) {
                // 数字在上面，刻度尺在下方
                startY = shortScaleStart - self.rulerConfig.distanceFromScaleToNumber - size.height;
            } else if (kNumberBottom) {
                // 数字在下面，刻度尺在上方
                startY = shortScaleStart + shortScaleLength + self.rulerConfig.distanceFromScaleToNumber;
            }
            self.textLayer.frame = CGRectMake((CGRectGetWidth(self.contentView.frame) - size.width) / 2.0, startY, size.width, size.height);
        } else {
            // 垂直方向
            CGFloat startX = 0;
            if (kNumberLeft) {
                // 数字在左边，刻度尺在右边
                startX = shortScaleStart - self.rulerConfig.distanceFromScaleToNumber - size.width;
            } else if (kNumberRight) {
                // 数字在右边，刻度尺在左边
                startX = shortScaleStart + shortScaleLength + self.rulerConfig.distanceFromScaleToNumber;
            }
            self.textLayer.frame = CGRectMake(startX, (CGRectGetHeight(self.contentView.frame) - size.height) / 2.0, size.width, size.height);
        }

        self.textLayer.string = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : self.rulerConfig.numberFont, NSForegroundColorAttributeName : self.rulerConfig.numberColor}];
        self.textLayer.actions = @{@"contents" : [NSNull null]};
        if (!self.textLayer.superlayer) {
            [self.contentView.layer addSublayer:self.textLayer];
        }
    } else {
        self.textLayer.string = nil;
    }

    self.selectTextLayer.string = nil;
    [self.selectTextLayer removeFromSuperlayer];

    // 刻度尺
    RulerScaleConfig *scaleConfig = self.rulerConfig.scaleBuilder(self.rulerConfig, self.index, value);
    if (scaleConfig != nil) {
        CGFloat length = scaleConfig.length;
        CGFloat start = scaleConfig.start;
        self.ruleImageView.frame = kHorizontalCell ? CGRectMake(0, start, self.rulerConfig.scaleWidth, length) : CGRectMake(start, 0, length, self.rulerConfig.scaleWidth);
        self.ruleImageView.layer.cornerRadius = self.rulerConfig.scaleWidth / 2.0;
        self.ruleImageView.backgroundColor = self.rulerConfig.scaleColor;
        [self.ruleImageView setHidden:NO];
    } else {
        [self.ruleImageView setHidden:YES];
    }
}

#pragma mark - 选中当前cell
- (void)makeCellSelect
{
    self.selectTextLayer = nil;
    NSString *text = @"";

    NSInteger value = [self.rulerConfig valueOf:self.index];

    if (self.rulerConfig.isDecimal) {
        text = [NSString stringWithFormat:@"%0.1f", (float)value / 10.f];
    } else {
        text = [NSString stringWithFormat:@"%ld", (long)value];
    }

    CGSize size = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH_RULER, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Semibold" size:18]} context:nil].size;

    CGFloat shortScaleStart = self.rulerConfig.shortScale.start;
    CGFloat shortScaleLength = self.rulerConfig.shortScale.length;

    if (kHorizontalCell) {
        // 水平方向
        CGFloat startY = 0;
        if (kNumberTop) {
            // 数字在上方，刻度尺在下方
            startY = shortScaleStart - self.rulerConfig.distanceFromScaleToNumber - size.height - 12;
        } else if (kNumberBottom) {
            // 数字在下方，刻度尺在上方
            startY = shortScaleStart + shortScaleLength + self.rulerConfig.distanceFromScaleToNumber + 12;
        }
        self.selectTextLayer.frame = CGRectMake((CGRectGetWidth(self.contentView.frame) - size.width) / 2.0, startY, size.width, size.height);
    } else {
        // 垂直方向
        CGFloat startX = 0;
        if (kNumberLeft) {
            // 数字在左边，刻度尺在右边
            startX = shortScaleStart - self.rulerConfig.distanceFromScaleToNumber - size.width - 12;
        } else if (kNumberRight) {
            // 数字在右边，刻度尺在左边
            startX = shortScaleStart + shortScaleLength + self.rulerConfig.distanceFromScaleToNumber + 12;
        }
        self.selectTextLayer.frame = CGRectMake(startX, (CGRectGetHeight(self.contentView.frame) - size.height) / 2.0, size.width, size.height);
    }

    self.selectTextLayer.string = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Semibold" size:18], NSForegroundColorAttributeName : UIColorFromHex(0x20C6BA)}];
    self.selectTextLayer.actions = @{@"contents" : [NSNull null]};
    [self.contentView.layer addSublayer:self.selectTextLayer];
    self.textLayer.string = nil;
}

#pragma mark - 隐藏当前cell的文字
- (void)makeCellHiddenText
{
    self.textLayer.string = nil;
}

#pragma mark - getter
- (UIImageView *)ruleImageView
{
    if (!_ruleImageView) {
        _ruleImageView = [[UIImageView alloc] init];
    }
    return _ruleImageView;
}

- (CATextLayer *)textLayer
{
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
        _textLayer.alignmentMode = @"center";
        if (self.rulerConfig.numberFlip) {
            _textLayer.affineTransform = CGAffineTransformMakeScale(-1, 1);
        }
    }
    return _textLayer;
}

- (CATextLayer *)selectTextLayer
{
    if (!_selectTextLayer) {
        _selectTextLayer = [CATextLayer layer];
        _selectTextLayer.contentsScale = [UIScreen mainScreen].scale;

        if (self.rulerConfig.numberFlip) {
            _selectTextLayer.affineTransform = CGAffineTransformMakeScale(-1, 1);
        }
    }
    return _selectTextLayer;
}

#pragma mark - other
/** 根据最大值，求出当前位数的最大值 */
- (NSString *)maxString
{
    NSInteger num = self.rulerConfig.max;
    NSMutableString *maxNumberString = [NSMutableString string];

    while (num > 0) {
        [maxNumberString appendFormat:@"9"];
        num = num / 10;
    }

    return maxNumberString;
}

- (NSString *)notRounding:(float)value afterPoint:(int)position
{
    float roundedFloat = roundf(value * 10) / 10;
    NSString *text = [NSString stringWithFormat:@"%0.1f", roundedFloat];
    NSLog(@"round value: %@", text);
    return text;

    //    //    price:需要处理的数字，
    //    //    position：保留小数点第几位
    //    //    NSRoundDown代表的就是 只舍不入
    //    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
    //                                                                                                      scale:position
    //                                                                                           raiseOnExactness:NO
    //                                                                                            raiseOnOverflow:NO
    //                                                                                           raiseOnUnderflow:NO
    //                                                                                        raiseOnDivideByZero:NO];
    //    NSDecimalNumber *ouncesDecimal;
    //    NSDecimalNumber *roundedOunces;
    //
    //    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:value];
    //    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    //    return [NSString stringWithFormat:@"%@", roundedOunces];
}

@end
