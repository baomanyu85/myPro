//
//  WaterFlowCellView.h
//  瀑布流
//
//  Created by apple on 13-10-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFlowCellView : UIView
{
    UITableViewCell *_cell;
}

// 可重用标示符，以便可以在缓冲池中找到可重用单元格
@property (strong, nonatomic) NSString *reuseIdentifier;

// 图像视图
@property (strong, nonatomic) UIImageView *imageView;
// 文字标签
@property (strong, nonatomic) UILabel *textLabel;
// 选中标记
@property (assign, nonatomic) BOOL selected;

// 使用可重用标示符，实例化单元格
- (id)initWithResueIdentifier:(NSString *)reuseIdentifier;

@end
