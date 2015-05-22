//
//  Model_XYHSV.h
//  DrawFlower
//
//  Created by bliss_ddo on 15/4/10.
//  Copyright (c) 2015年 多米音乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_XYHSV : NSObject
+(Model_XYHSV*)ModelWithX:(float)px Y:(float)py H:(float)ph S:(float)ps V:(float)pv;

@property (nonatomic,assign)float x,y,h,s,v,shouldDrawRadius;

@end
