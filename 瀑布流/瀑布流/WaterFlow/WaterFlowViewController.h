//
//  WaterFlowViewController.h
//  瀑布流
//
//  Created by apple on 13-10-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowView.h"
#import "WaterFlowCellView.h"

@interface WaterFlowViewController : UIViewController <WaterFlowViewDataSource, WaterFlowViewDelegate>

// 要让waterFlowView == self.view
@property (strong, nonatomic) WaterFlowView *waterFlowView;

@end
