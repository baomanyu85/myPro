//
//  MGJData.m
//  瀑布流
//
//  Created by apple on 13-10-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MGJData.h"

@implementation MGJData

- (NSString *)description
{
    return [NSString stringWithFormat:@"<MGJData: %p, img: %@, w: %f, h: %f, price: %@>", self, self.img, self.w, self.h, self.price];
}

@end
