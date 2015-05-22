//
//  FlowerView.h
//  DrawFlower
//
//  Created by bliss_ddo on 15/4/10.
//  Copyright (c) 2015年 多米音乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlowerColorPickerDelegate <NSObject>

-(void)FlowerColorPickerDidSelectColor:(UIColor*)selectedColor;
-(void)FlowerColorPickerDidOKButtonPressed;
-(void)FlowerColorPickerDidCancelButtonPressed;

@end


@interface FlowerView : UIView

@property (nonatomic,strong)NSMutableArray * colorCircleList;
@property (nonatomic,assign)id<FlowerColorPickerDelegate>delegate;
@end
