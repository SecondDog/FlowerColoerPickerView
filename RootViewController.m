//
//  RootViewController.m
//  DrawFlower
//
//  Created by bliss_ddo on 15/4/9.
//  Copyright (c) 2015年 多米音乐. All rights reserved.
//

#import "RootViewController.h"



@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)showHHH:(id)sender {
    FlowerPickerViewController * picker = [[FlowerPickerViewController alloc]init];
    picker.delegate = (id)self;
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:picker animated:YES completion:^{
        ;
    }];
}
-(void)FlowerPickerController:(FlowerPickerViewController*)controller_pc DidSelectColor:(UIColor*)selectedColor
{
    NSLog(@"color changed");
}
-(void)FlowerPickerViewControllerDidOKButtonPressed:(FlowerPickerViewController*)controller_pc withSelectedColor:(UIColor *)selectedColor
{
    NSLog(@"OK");
    NSString * title = [NSString stringWithFormat:@"SelectedColor:%@",selectedColor];
    UIAlertView * alt = [[UIAlertView alloc]init];
    alt.title = title;
    [alt addButtonWithTitle:@"OK"];
    [alt show];
    
    [self.view setBackgroundColor:selectedColor];
}
-(void)FlowerPickerViewControllerDidCancelButtonPressed:(FlowerPickerViewController*)controller_pc
{
    NSLog(@"Cancel");
}

@end
