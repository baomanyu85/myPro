//
//  SATableViewCell.m
//  SianWeibo
//
//  Created by yusian on 14-4-14.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Cell视图类

#import "SATableViewCell.h"
#import "UIImage+SA.h"
@interface SATableViewCell ()
{
    UIImageView *_normalImage;
    UIImageView *_selectedImage;
    UIImageView *_cellImageView;
}
@end
@implementation SATableViewCell

#pragma mark - 1、初始化
- (void) layoutSubviews
{
    [super layoutSubviews];
    // iOS7默认Cell宽度为320充满整个屏幕，而iOS6Cell宽度为300，为保持一致，重写该方法统一风格
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect fram = self.frame;
        fram.size.width = 300;                                  // Cell宽度设置成300
        fram.origin.x = 10;                                     // x右移10象素使Cell居中
        self.frame = fram;
    }
}

#pragma mark - 2、自定义Cell样式
#pragma mark 2.1、设置Cell基本样式
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _normalImage = [[UIImageView alloc] init];
        _selectedImage = [[UIImageView alloc] init];
        self.backgroundView = _normalImage;                     // 设置Cell普通状态下背景
        self.selectedBackgroundView = _selectedImage;           // 设置Cell选择状态下背景
        self.textLabel.backgroundColor = [UIColor clearColor];  // Label设置透明色
        self.backgroundColor = [UIColor clearColor];            // Cell设置透明色
    }
    return self;
}

#pragma mark 2.2、设置Cell背景图片
- (void)setGroupCellStyleWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rows = [tableView numberOfRowsInSection:indexPath.section];
    self.textLabel.textAlignment = NSTextAlignmentLeft;         // 文字居左
    self.textLabel.textColor = [UIColor blackColor];            // 文本颜色为黑色
    self.textLabel.font = [UIFont systemFontOfSize:15];         // 字体大小固定
    
    // 设置Cell背景样式，美化视觉效果，由于圆角的设计使得处于不同位置的Cell背景图片不尽相同
    if (rows == 1) {                           // 只有一行情况
        _normalImage.image = [UIImage resizeImage:@"common_card_background.png"];
        _selectedImage.image = [UIImage resizeImage:@"common_card_background_highlighted.png"];
    } else if (indexPath.row == 0) {           // 首行
        _normalImage.image = [UIImage resizeImage:@"common_card_top_background.png"];
        _selectedImage.image = [UIImage resizeImage:@"common_card_top_background_highlighted.png"];
    } else if (indexPath.row == rows - 1) {    // 末行
        _normalImage.image = [UIImage resizeImage:@"common_card_bottom_background.png"];
        _selectedImage.image = [UIImage resizeImage:@"common_card_bottom_background_highlighted.png"];
    } else {                                   // 中间行
        _normalImage.image = [UIImage resizeImage:@"common_card_middle_background.png"];
        _selectedImage.image = [UIImage resizeImage:@"common_card_middle_background_highlighted.png"];
    }
}

#pragma mark - 2.3、自定义Cell附属样式
-(void)setCellType:(CellType)cellType
{
    
    switch (cellType) {
            
            // 无附属样式
        case kCellTypeNone:
            self.accessoryView = nil;
            break;
            
            // Cell右侧添加箭头图标样式
        case kCellTypeArrow:
            if (_cellImageView == nil){
                _cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
            }
            self.accessoryView = _cellImageView;
            break;
            
            // Cell右侧添加标签样式
        case kCellTypeLabel:
            if (_accessoryLabel == nil){
                _accessoryLabel = [[UILabel alloc] init];
                _accessoryLabel.text = @"展开";
                _accessoryLabel.bounds = CGRectMake(0, 0, 70, 44);
                _accessoryLabel.backgroundColor = [UIColor clearColor];
                _accessoryLabel.textColor = [UIColor grayColor];
                _accessoryLabel.textAlignment = NSTextAlignmentCenter;
                _accessoryLabel.font = [UIFont systemFontOfSize:12];
            }
            self.accessoryView = _accessoryLabel;
            break;
            
            // Cell右侧添加开关样式
        case kCellTypeSwitch:
            if (_accessorySwitch == nil) {
                _accessorySwitch = [[UISwitch alloc] init];
            }
            self.accessoryView = _accessorySwitch;
            break;
            
            // 整个Cell为红色按钮样式
        case kCellRedButton:
        {
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            self.textLabel.textColor = [UIColor whiteColor];
            _normalImage.image = [UIImage resizeImage:@"common_button_big_red.png"];
            _selectedImage.image = [UIImage resizeImage:@"common_button_big_red_highlighted.png"];
            self.accessoryView = nil;
        }
            break;
        default:
            self.accessoryView = nil;
            break;
    };
    
}
@end
