//
//  FlowerPickerViewController.m
//  DrawFlower
//
//  Created by bliss_ddo on 15/4/11.
//  Copyright (c) 2015年 多米音乐. All rights reserved.
//

#import "FlowerPickerViewController.h"

@interface FlowerPickerViewController ()
{
    UIButton * backContainerButton ;
}
@end

@implementation FlowerPickerViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showFlowerColorPickerWithDelegate:self];
}
-(void)hiddenFlowerPickerView
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}
-(void)showFlowerColorPickerWithDelegate:(id<FlowerColorPickerDelegate>)dlg
{
    CGFloat wid= [[UIScreen mainScreen]bounds].size.width;
    
    FlowerView* fview = [[FlowerView alloc]initWithFrame:CGRectMake(wid*0.15/2, 50, wid*0.85, wid*0.85/0.618)];
    fview.delegate = dlg;
    fview.tag = 8888;
    
    backContainerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backContainerButton.frame = [[UIScreen mainScreen] bounds];
    backContainerButton.backgroundColor = [UIColor whiteColor];
    [backContainerButton addTarget:self action:@selector(hiddenFlowerPickerView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backContainerButton];
    [self.view addSubview:fview];
}

-(void)FlowerColorPickerDidSelectColor:(UIColor *)selectedColor
{
    backContainerButton.backgroundColor = selectedColor;
    if ([delegate respondsToSelector:@selector(FlowerPickerController:DidSelectColor:)]) {
        [delegate FlowerPickerController:self DidSelectColor:selectedColor];
    }
}
-(void)FlowerColorPickerDidCancelButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        if ([delegate respondsToSelector:@selector(FlowerPickerViewControllerDidCancelButtonPressed:)]) {
            [delegate FlowerPickerViewControllerDidCancelButtonPressed:self];
        }
    }];
}
-(void)FlowerColorPickerDidOKButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
        if ([delegate respondsToSelector:@selector(FlowerPickerViewControllerDidOKButtonPressed: withSelectedColor:)]) {
            [delegate FlowerPickerViewControllerDidOKButtonPressed:self withSelectedColor:backContainerButton.backgroundColor];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
