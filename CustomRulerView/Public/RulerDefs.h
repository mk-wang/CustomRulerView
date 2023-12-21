//
//  RulerDefs.h
//  FaceYoga
//
//  Created by MK on 2023/12/21.
//

#ifndef RulerDefs_h
#define RulerDefs_h
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RulerNumberDirection) {
    numberTop = 0, // 水平方向：数字在上，刻度尺在下
    numberBottom,  // 水平方向：数字在下，刻度尺在上
    numberLeft,    // 垂直方向：数字在左，刻度尺在右
    numberRight    // 垂直方向：数字在右，刻度尺在左
};

#endif /* RulerDefs_h */
