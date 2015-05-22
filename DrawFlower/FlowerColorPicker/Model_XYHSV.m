//
//  Model_XYHSV.m
//  DrawFlower
//
//  Created by bliss_ddo on 15/4/10.
//  Copyright (c) 2015年 多米音乐. All rights reserved.
//

#import "Model_XYHSV.h"

@implementation Model_XYHSV
@synthesize x,y,h,s,v;
@synthesize shouldDrawRadius;
-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(Model_XYHSV*)ModelWithX:(float)px Y:(float)py H:(float)ph S:(float)ps V:(float)pv
{
    Model_XYHSV * oneModel = [[Model_XYHSV alloc]init];
    oneModel.x = px;
    oneModel.y = py;
    oneModel.h = ph;
    oneModel.s = ps;
    oneModel.v = pv;
    return oneModel;
}
@end
