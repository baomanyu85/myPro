//
//  SABaseStatusCellFrame.m
//  SianWeibo
//
//  Created by yusian on 14-4-23.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SABaseStatusCellFrame.h"
#import "SAAvata.h"
#import "SAImageListView.h"

@implementation SABaseStatusCellFrame

-(void)setDataModel:(SAStatus *)dataModel
{
    [super setDataModel:dataModel];
    
    // 1、设置时间尺寸位置
    CGFloat timeX = self.screenNameRect.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.screenNameRect) + kInterval * 0.5;
    CGSize timeSize = [dataModel.createdAt sizeWithFont:kTimeFont];
    self.timeRect = (CGRect){{timeX, timeY}, timeSize};
    
    // 2、设置来源尺寸位置
    CGFloat sourceX = CGRectGetMaxX(self.timeRect) + kInterval;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [dataModel.source sizeWithFont:kSourceFont];
    self.sourceRect = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 3、设置正文尺寸位置；
    CGFloat textX = self.avataRect.origin.x;
    CGFloat textY = MAX (CGRectGetMaxY(self.avataRect), CGRectGetMaxY(self.timeRect));
    CGFloat textW = self.cellWidth - 2 * kInterval;
    CGSize textSize = [dataModel.text sizeWithFont:kTextFount constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    self.textRect = (CGRect){{textX, textY}, textSize};
    
    if (dataModel.picUrls.count) {                            // 第一种情况：带配图的微博
        
        // 4、设置配图尺寸位置
        CGFloat imageX = kInterval;
        CGFloat imageY = CGRectGetMaxY(super.textRect) + kInterval;
        CGSize imageSize = [SAImageListView sizeOfViewWithImageCount:dataModel.picUrls.count];
        _image = (CGRect){{imageX, imageY}, imageSize};
        
        // 有配图无转发体单元格高度
        self.cellHeight = CGRectGetMaxY(_image) + kInterval  + kCellMargins;
        
    } else if (dataModel.retweetedStatus) {                   // 第二种情况：转发的微博
        
        // 5、设置转发体尺寸位置
        CGFloat retweetX = kInterval;
        CGFloat retweetY = CGRectGetMaxY(self.textRect) + kInterval;
        CGFloat retweetW = self.cellWidth - 2 * kInterval;
        
        // 6、设置转发体昵称尺寸位置
        CGFloat reScreenNameX = kInterval;
        CGFloat reScreenNameY = kInterval;
        CGSize reScreenNameSize = [[NSString stringWithFormat:@"@%@", dataModel.retweetedStatus.user.screenName] sizeWithFont:kReScreenNameFont];
        _reScreenName = (CGRect){{reScreenNameX, reScreenNameY}, reScreenNameSize};
        
        // 7、设置转发体正文尺寸位置
        CGFloat reTextX = reScreenNameX;
        CGFloat reTextY = CGRectGetMaxY(_reScreenName) + kInterval;
        CGSize reTextSize = [dataModel.retweetedStatus.text sizeWithFont:kReTextFont constrainedToSize:CGSizeMake((retweetW - 2 * kInterval), MAXFLOAT)];
        _reText = (CGRect){{reTextX, reTextY}, reTextSize};
        
        // 8、设置转发体配图尺寸位置
        if (dataModel.retweetedStatus.picUrls.count) {        // 第二种情况：1、转发的微博带图
            CGFloat reImageX = reScreenNameX;
            CGFloat reImageY = CGRectGetMaxY(_reText) + kInterval;
            CGSize reImageSize = [SAImageListView sizeOfViewWithImageCount:dataModel.retweetedStatus.picUrls.count];
            _reImage = (CGRect){{reImageX, reImageY}, reImageSize};
            
            // 转发体有配图转发体尺寸
            CGFloat retweetH = CGRectGetMaxY(_reImage) + kInterval;
            _retweet = CGRectMake(retweetX, retweetY, retweetW, retweetH);
            
        } else {                                            // 第二种情况：2、转发的微博不带图
            
            // 转发体无配图转发体尺寸
            CGFloat retweetH = CGRectGetMaxY(_reText) + kInterval;
            _retweet = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        }
        
        // 有转发体的单元格高度
        self.cellHeight = CGRectGetMaxY(_retweet) + kInterval + kCellMargins;
        
    } else {                                                // 第三种情况：不带配图的普通微博
        
        // 9、设置单元格高度尺寸位置
        // 无配图，无转发体单元格高度
        self.cellHeight = CGRectGetMaxY(super.textRect) + kInterval + kCellMargins;
    }
    
}
@end
