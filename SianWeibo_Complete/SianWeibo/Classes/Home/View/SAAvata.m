//
//  SAAvata.m
//  SianWeibo
//
//  Created by yusian on 14-4-19.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  用户头像处理类

#import "SAAvata.h"
#import "SAStatusTool.h"

@interface SAAvata ()
{
    UIImageView *_icon;
    UIImageView *_verified;
}
@end

@implementation SAAvata

#pragma mark - 1、初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1、设置头像
        _icon = [[UIImageView alloc] init];
        [self addSubview:_icon];
        
        // 2、设置认证图标
        _verified = [[UIImageView alloc] init];
        [self addSubview:_verified];
        
    }
    return self;
}

#pragma mark - 2、设置用户数据及头像尺寸
- (void)setUser:(SAUser *)user ofType:(SAAvataType)type
{
    [self setUser:user];
    [self setType:type];
}

#pragma mark 2.1、设置用户头像尺寸位置
-(void)setType:(SAAvataType)type
{
    _type = type;
    
    // 1、设置头像尺寸位置
    // 2、设置认证图标尺寸位置
    
    switch (type) {
        case kAvataTypeSmall:
            
            _icon.frame =  CGRectMake(0, 0, kAvataSmallW, kAvataSmallH);
            _verified.center = (CGPoint){_icon.frame.size.width, _icon.frame.size.height};
            _verified.bounds = CGRectMake(0, 0, kVerifiedW, kVerifiedH);
            break;
            
        case kAvataTypeBig:
            
            _icon.frame =  CGRectMake(0, 0, kAvataBigW, kAvataBigH);
            _verified.center = (CGPoint){_icon.frame.size.width, _icon.frame.size.height};
            _verified.bounds = CGRectMake(0, 0, kVerifiedW, kVerifiedH);
            break;
            
        default:
            
            _icon.frame =  CGRectMake(0, 0, kAvataDefaultW, kAvataDefaultH);
            _verified.center = (CGPoint){_icon.frame.size.width, _icon.frame.size.height};
            _verified.bounds = CGRectMake(0, 0, kVerifiedW, kVerifiedH);
            break;
    }
    
}

#pragma mark 2.2、设置用户数据
-(void)setUser:(SAUser *)user
{
    // 1、设置头像图标内容
    _user = user;
    
    [SAStatusTool statusToolInsteadView:_icon setImageWithURLString:user.profileImageUrl placeholderImage:[UIImage imageNamed:@"avatar_default.png"]];
    
    // 2、设置认证图标内容
    
    switch (user.verifiedType) {
        case kVerifiedTypeNone:
            
            _verified.hidden = YES;
            break;
            
        case kVerifiedTypePersonal:
            
            _verified.hidden = NO;
            _verified.image = [UIImage imageNamed:@"avatar_vip.png"];
            break;
            
        case kVerifiedTypeDaren:
            
            _verified.hidden = NO;
            _verified.image = [UIImage imageNamed:@"avatar_grassroot.png"];
            break;
            
        default:                //kVerifiedTypeOrgEnterprice、kVerifiedTypeOrgMedia、kVerifiedTypeOrgWebsite
            
            _verified.hidden = NO;
            _verified.image = [UIImage imageNamed:@"avatar_enterprise_vip.png"];
            break;
    }
    
}

#pragma mark - 3、对外提供获取对象数据的方法

#pragma mark 3.1、提供用户头像占位图
- (UIImage *)placeImageWithAvataType:(SAAvataType)avataType
{
    switch (avataType) {
        case kAvataTypeSmall:
            
            return [UIImage imageNamed:@"avatar_default_small.png"];
            break;
            
        case kAvataTypeBig:
            
            return [UIImage imageNamed:@"avatar_default_big.png"];
            break;
            
        default:
            
            return [UIImage imageNamed:@"avatar_default.png"];
            break;
    }
}

#pragma mark 3.2、提供不同类型头像的尺寸
+ (CGSize)sizeOfAvataType:(SAAvataType)avataType
{
    switch (avataType) {
        case kAvataTypeSmall:
            
            return CGSizeMake(kAvataSmallW + kVerifiedW * 0.5, kAvataSmallH + kVerifiedH * 0.5);
            break;
            
        case kAvataTypeDefault:
            
            return CGSizeMake(kAvataDefaultW + kVerifiedW * 0.5, kAvataDefaultH + kVerifiedH * 0.5);
            break;
            
        case kAvataTypeBig:
            
            return CGSizeMake(kAvataBigW + kVerifiedW * 0.5, kAvataBigH + kVerifiedH * 0.5);
            break;
    }
}

@end
