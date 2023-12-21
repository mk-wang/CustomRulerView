//
//  RulerDefs_Private.h
//  FaceYoga
//
//  Created by MK on 2023/12/21.
//

#ifndef RulerDefs_Private_h
#define RulerDefs_Private_h

#import <Foundation/Foundation.h>

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16)) / 255.0 green:(((s & 0xFF00) >> 8)) / 255.0 blue:((s & 0xFF)) / 255.0 alpha:1.0]
#define SCREEN_WIDTH_RULER ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT_RULER ([[UIScreen mainScreen] bounds].size.height)

@interface RulerConfig ()

// isDecimal 的话是 x10
- (NSInteger)valueOf:(NSInteger)index;

@end

#endif /* RulerDefs_Private_h */
