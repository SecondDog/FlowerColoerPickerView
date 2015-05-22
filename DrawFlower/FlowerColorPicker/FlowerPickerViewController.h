//
//  FlowerPickerViewController.h
//  DrawFlower
//
//  Created by bliss_ddo on 15/4/11.
//  Copyright (c) 2015年 多米音乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowerView.h"
@class FlowerPickerViewController;

@protocol FlowerPickerControllerDelegate <NSObject>

@optional
-(void)FlowerPickerController:(FlowerPickerViewController*)controller_pc DidSelectColor:(UIColor*)selectedColor;
-(void)FlowerPickerViewControllerDidOKButtonPressed:(FlowerPickerViewController*)controller_pc withSelectedColor:(UIColor*)selectedColor;
-(void)FlowerPickerViewControllerDidCancelButtonPressed:(FlowerPickerViewController*)controller_pc;

@end


@interface FlowerPickerViewController : UIViewController<FlowerColorPickerDelegate>

@property (nonatomic,assign)id<FlowerPickerControllerDelegate>delegate;

@end
