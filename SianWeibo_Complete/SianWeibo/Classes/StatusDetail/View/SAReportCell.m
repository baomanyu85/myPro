//
//  SAReportCell.m
//  SianWeibo
//
//  Created by yusian on 14-4-26.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAReportCell.h"
#import "UIImage+SA.h"

@interface SAReportCell()
{
    UIImageView     *_normalImageView;
    UIImageView     *_selectedImageView;
}
@end

@implementation SAReportCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        _normalImageView    = [[UIImageView alloc] init];
        _selectedImageView  = [[UIImageView alloc] init];
        self.backgroundView = _normalImageView;
        self.selectedBackgroundView = _selectedImageView;
        
    }
    return self;
}

- (void)setGroupCellStyleWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger cellRows = [tableView numberOfRowsInSection:indexPath.section];
    if (indexPath.row == cellRows - 1) {
        _normalImageView.image = [UIImage resizeImage:@"statusdetail_comment_background_bottom.png"];
        _selectedImageView.image = [UIImage resizeImage:@"statusdetail_comment_background_bottom_highlighted.png"];
        
    } else {
        _normalImageView.image = [UIImage resizeImage:@"statusdetail_comment_background_middle.png"];
        _selectedImageView.image = [UIImage resizeImage:@"statusdetail_comment_background_middle_highlighted.png"];
    }
}

-(void)setCellFrame:(SAReportCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
}

#pragma mark - 重写frame方法设置Cell宽度
-(void)setFrame:(CGRect)frame
{
    frame.origin.x += kCellMargins;
    frame.size.width -= (2 *kCellMargins);
    
    [super setFrame:frame];
}

@end
