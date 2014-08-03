//
//  SAAccountTool.h
//  SianWeibo
//
//  Created by yusian on 14-4-15.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAAccount.h"

@interface SAAccountTool : NSObject

@property (nonatomic, readonly) SAAccount *account;

+ (SAAccountTool *)sharedAccountTool;

- (void)saveAccount:(SAAccount *)account;

@end
