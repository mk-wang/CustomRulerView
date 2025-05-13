//
//  RulerConfig.m
//  FaceYoga
//
//  Created by MK on 2023/12/21.
//

#import "RulerConfig.h"
#import "RulerDefs_Private.h"

@implementation RulerScaleConfig

+ (instancetype)scaleWithLength:(CGFloat)length start:(CGFloat)start
{
    return [[self alloc] initWithLength:length start:start color:nil];
}

+ (instancetype)scaleWithLength:(CGFloat)length start:(CGFloat)start color:(UIColor *_Nullable)color {
    return  [[self alloc] initWithLength:length start:start color:color];
}

- (instancetype)initWithLength:(CGFloat)length start:(CGFloat)start
{
    return [self initWithLength:length start:start color:nil];
}

- (instancetype)initWithLength:(CGFloat)length
                         start:(CGFloat)start
                         color:(UIColor *_Nullable)color {
    self = [super init];
    if (self) {
        _length = length;
        _start = start;
        _color = color;
    }
    return self;
}

@end

@implementation RulerConfig

+ (void)initDefalutValue:(RulerConfig *)config
{
    // 刻度宽度
    config.scaleWidth = 2;
    // 刻度起始位置
    config.shortScale = [RulerScaleConfig scaleWithLength:17.5 start:25];
    config.longScale = [RulerScaleConfig scaleWithLength:25 start:25];
    // 刻度颜色
    config.scaleColor = UIColorFromHex(0xdae0ed);
    // 刻度之间的距离
    config.distanceBetweenScale = 8;
    // 刻度距离数字的距离
    config.distanceFromScaleToNumber = 35;
    // 指示视图属性设置
    config.pointSize = CGSizeMake(4, 40);
    config.pointColor = UIColorFromHex(0x20c6ba);
    config.pointStart = 20;
    // 文字属性
    config.numberFont = [UIFont systemFontOfSize:11];
    config.numberColor = UIColorFromHex(0x617272);
    config.numberDirection = numberBottom;
    config.min = 0;
    config.offset = 1;
    config.numberFlip = NO;
    config.continuous = YES;

    [config setValueTextBuilder:^NSString *(RulerConfig *config, NSInteger index, NSInteger value) {
        if (config.isDecimal) {
            value /= 10;
        }
        return (index % 10 == 0) ? [NSString stringWithFormat:@"%ld", value] : nil;
    }];

    [config setScaleBuilder:^RulerScaleConfig *(RulerConfig *config, NSInteger index, NSInteger value) {
        return (index % 5 == 0) ? [config longScale] : [config shortScale];
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.class initDefalutValue:self];
    }
    return self;
}

- (NSInteger)valueOf:(NSInteger)index
{
    if (self.isDecimal) {
        float value = self.min + index / (float)10.0;

        if (self.reverse) {
            value = self.max - value + self.min;
        }
        return (NSInteger)roundf(value * 10);
    } else {
        NSInteger value = self.min + index;
        if (self.reverse) {
            value = self.max - value + self.min;
        }
        return value;
    }
}

@end
