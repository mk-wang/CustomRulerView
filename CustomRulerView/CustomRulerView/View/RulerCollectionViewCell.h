//
//  RulerCollectionViewCell.h
//  TYFitFore
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 tangpeng. All rights reserved.
//

#import "RulerDefs.h"
#import <UIKit/UIKit.h>

@class RulerConfig;

@interface RulerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) RulerConfig *rulerConfig;
@property (nonatomic, assign) NSInteger index; /**< cell下标  */

/** 选中当前cell */
- (void)makeCellSelect;
/** 隐藏当前cell的文字 */
- (void)makeCellHiddenText;

@end
