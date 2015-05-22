//
//  FlowerView.m
//  DrawFlower
//
//  Created by bliss_ddo on 15/4/10.
//  Copyright (c) 2015年 多米音乐. All rights reserved.
//

#import "FlowerView.h"
#import "Model_XYHSV.h"
@interface FlowerView()
{
    NSInteger _currentCount;
    Model_XYHSV * currentSelectedModel;
    UIView * testView;
    CGFloat half;
    double factor ;
    CGPoint lastPoint;
    CGFloat shouldDrawRadius;

}

@property (nonatomic,assign)float brightnnness;
@property (nonatomic,assign)float controlAlpha;
@end
@implementation FlowerView
@synthesize colorCircleList;
@synthesize delegate;



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor grayColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 9.0f;
        CGFloat selfWidth = self.frame.size.width;
        CGFloat scaleFac = selfWidth/320;
        half = self.frame.size.width/2;
        factor = (self.frame.size.width*0.90)/375.0;
        lastPoint = CGPointZero;
        
        currentSelectedModel = nil;
        self.brightnnness=1;
        self.colorCircleList = [NSMutableArray arrayWithCapacity:0];
        _currentCount = 0;

        self.controlAlpha = 1;
        UISlider * slider_brighteness = [[UISlider alloc]initWithFrame:CGRectMake(selfWidth*0.2/2, selfWidth+20, selfWidth*0.8, 20)];
        slider_brighteness.maximumValue=1.0;
        slider_brighteness.minimumValue=0.0;
        slider_brighteness.value=1;
        [slider_brighteness addTarget:self action:@selector(brightnessSliderChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider_brighteness];
        
        UISlider * slider_alpha = [[UISlider alloc]initWithFrame:CGRectMake(selfWidth*0.2/2, selfWidth+50, selfWidth*0.8, 40)];
        slider_alpha.maximumValue=1.0;
        slider_alpha.minimumValue=0.0;
        slider_alpha.value=1;
        [slider_alpha addTarget:self action:@selector(alphaSliderChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider_alpha];
        
        CGFloat btnXstart =selfWidth*0.1;
        CGFloat btnWidth  =selfWidth*0.35;
        
        UIButton * btnOK = [UIButton buttonWithType:UIButtonTypeCustom];
        btnOK.frame = CGRectMake(btnXstart, selfWidth+120*scaleFac, selfWidth*0.35, 44);
        btnOK.layer.cornerRadius = 3.0f;
        btnOK.clipsToBounds = YES;
        btnOK.layer.borderWidth=1.0f;
        btnOK.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        [btnOK setTitle:@"OK" forState:UIControlStateNormal];
        [btnOK addTarget:self action:@selector(okButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnOK];
        
        UIButton * btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCancel.frame = CGRectMake(btnXstart+btnWidth+btnXstart, selfWidth+120*scaleFac, selfWidth*0.35, 44);
        btnCancel.layer.cornerRadius = 3.0f;
        btnCancel.clipsToBounds = YES;
        btnCancel.layer.borderWidth=1.0f;
        btnCancel.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCancel];
        
    }
    return self;
}
-(void)okButtonPressed{
    
    NSLog(@"OK");
    if ([delegate respondsToSelector:@selector(FlowerColorPickerDidOKButtonPressed)]) {
        [delegate FlowerColorPickerDidOKButtonPressed];
    }
}
-(void)cancelButtonPressed{
    if ([delegate respondsToSelector:@selector(FlowerColorPickerDidCancelButtonPressed)]) {
        [delegate FlowerColorPickerDidCancelButtonPressed];
    }
    NSLog(@"cancel");
}
-(void)brightnessSliderChanged:(UISlider*)sender
{

    currentSelectedModel = [self findNearestByPositon:lastPoint];
    if (currentSelectedModel!=nil) {
        currentSelectedModel.v = sender.value;
    }
    self.brightnnness = sender.value;
    [self colorSelectedEvent];
    [self setNeedsDisplay];

}
-(void)alphaSliderChanged:(UISlider*)sender
{
    currentSelectedModel = [self findNearestByPositon:lastPoint];
    self.controlAlpha = sender.value;
    [self colorSelectedEvent];
    [self setNeedsDisplay];
}
void HSVtoRGB( float *r, float *g, float *b, float h, float s, float v )
{
    int i;
    float f, p, q, t;
    if( s == 0 ) {
        *r = *g = *b = v;
        return;
    }
    h /= 60;
    i = floor( h );
    f = h - i;
    p = v * ( 1 - s );
    q = v * ( 1 - s * f );
    t = v * ( 1 - s * ( 1 - f ) );
    switch( i ) {
        case 0:
            *r = v;
            *g = t;
            *b = p;
            break;
        case 1:
            *r = q;
            *g = v;
            *b = p;
            break;
        case 2:
            *r = p;
            *g = v;
            *b = t;
            break;
        case 3:
            *r = p;
            *g = q;
            *b = v;
            break;
        case 4:
            *r = t;
            *g = p;
            *b = v;
            break;
        default:
            *r = v;
            *g = p;
            *b = q;
            break;
    }
}

- (void)drawRect:(CGRect)rect {
    
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    int total_Num = 12;
    int one_quan_total = 0;
    float one_quan_radios = 0;
    float oneCirrleRadio = 0;
    
    float hsv[3] ={0};
    
    for (int i = 0; i < total_Num; i++) {
 
        switch (i) {
            case 0:
            {
                one_quan_total = 1;
                one_quan_radios = 0;
                oneCirrleRadio = 8*factor;
            }
                break;
            case 1:{
                one_quan_total = 12;
                one_quan_radios = 17.0*factor;
                oneCirrleRadio = 3.5*factor;
            }
                break;
            case 2:{
                one_quan_total = 20;
                one_quan_radios = 32.0*factor;
                oneCirrleRadio = 5.0*factor;
            }
                break;
            case 3:
            {
                one_quan_total = 24;
                one_quan_radios = 49.0*factor;
                oneCirrleRadio = 6.0*factor;
            }
                break;
            case 4:
            {
                one_quan_total = 24;
                one_quan_radios = 64.0*factor;
                oneCirrleRadio = 6.5*factor;
            }
                break;
            case 5:{
                one_quan_total = 24;
                one_quan_radios = 81.0*factor;
                oneCirrleRadio = 7.0*factor;
            }
                break;
            case 6:
            {
                one_quan_total = 24;
                one_quan_radios = 96.0*factor;
                oneCirrleRadio = 8.0*factor;
            }
                break;
            case 7:
            {
                one_quan_total = 24;
                one_quan_radios = 113.0*factor;
                oneCirrleRadio = 8.5*factor;
            }
                break;
            case 8:{
                one_quan_total = 24;
                one_quan_radios = 128.0*factor;
                oneCirrleRadio = 10.0*factor;
            }
                break;
            case 9:{
                one_quan_total = 24;
                one_quan_radios = 145.0*factor;
                oneCirrleRadio = 10.5*factor;
            }
                break;
            case 10:
            {
                one_quan_total = 24;
                one_quan_radios = 160.0*factor;
                oneCirrleRadio = 11.0*factor;
            }
                break;
            case 11:{
                one_quan_total = 24;
                one_quan_radios = 177.0*factor;
                oneCirrleRadio = 11.5*factor;
            }
                break;
            default:
                break;
        }
        
        for (int j = 0; j < one_quan_total; j++) {
            double angle = M_PI * 2 * j / one_quan_total + (M_PI / one_quan_total) * ((i + 1) % 2);
            float x = half + (float) (one_quan_radios * cos(angle));
            float y = half + (float) (one_quan_radios * sin(angle));
            
            
            hsv[0] = (float) (angle / M_PI * 180);
            hsv[1] = one_quan_radios / half;
            hsv[2] = self.brightnnness;
            float tr,tg,tb;
            HSVtoRGB(&tr, &tg, &tb, hsv[0], hsv[1], hsv[2]);
            float palpha =self.controlAlpha;
            
            if (_currentCount<=249) {
                if (_currentCount >= self.colorCircleList.count){
                    Model_XYHSV * oneModel = [Model_XYHSV ModelWithX:x Y:y H:hsv[0] S:hsv[1] V:hsv[2]];
                    oneModel.shouldDrawRadius = oneCirrleRadio;
                    [colorCircleList addObject:oneModel];
                }
                else{
                    Model_XYHSV * tmpModel = [self.colorCircleList objectAtIndex:_currentCount];
                    tmpModel.shouldDrawRadius = oneCirrleRadio;
                    tmpModel.x = x; tmpModel.y = y; tmpModel.h = hsv[0]; tmpModel.s = hsv[1]; tmpModel.v = hsv[2];
                }
                _currentCount++;

            }
            

            
            CGContextSetRGBStrokeColor(ctx,1,1,1,1.0);//画笔线的颜色
            
            CGColorRef colorRef = [UIColor colorWithRed:tr green:tg blue:tb alpha:palpha].CGColor;
            CGContextSetFillColorWithColor(ctx, colorRef);
            
            CGContextAddArc(ctx, x, y, oneCirrleRadio, 0, M_PI*2, 1);
            CGContextFillPath(ctx);
//            CGContextDrawPath(ctx, kCGPathStroke); //绘制路径
            

            
            
        }
    }
    if (currentSelectedModel != nil) {
        float tr,tg,tb;
        currentSelectedModel.v = self.brightnnness;
        HSVtoRGB(&tr, &tg, &tb, currentSelectedModel.h, currentSelectedModel.s, currentSelectedModel.v);
        float palpha =self.controlAlpha;
        float drawRadius = currentSelectedModel.shouldDrawRadius*1.5;
        if (drawRadius==0) {
            drawRadius = oneCirrleRadio;
        }
        CGContextAddArc(ctx, currentSelectedModel.x, currentSelectedModel.y, drawRadius, 0, M_PI*2, 1);

        
        CGColorRef fillColorRef = [UIColor colorWithRed:tr green:tg blue:tb alpha:palpha].CGColor;
        CGContextSetFillColorWithColor(ctx, fillColorRef);
        CGContextFillPath(ctx);

        CGColorRef strokeColor = [UIColor redColor].CGColor;
        CGContextSetStrokeColorWithColor(ctx, strokeColor);
        CGContextStrokePath(ctx);
        CGContextDrawPath(ctx, kCGPathStroke); //绘制路径

    }
    

}

-(double)sqDistX:(CGPoint)px Y:(CGPoint)py
{
    double dx = px.x - py.x;
    double dy = px.y - py.y;
    return dx * dx + dy * dy;
}
-(Model_XYHSV *)findNearestByPositon:(CGPoint )px {
    if (CGPointEqualToPoint(px, CGPointZero)) {
        return nil;
    }
    Model_XYHSV * near = nil;
    double minDist = 999999999.0;
    for (Model_XYHSV * oneModel in self.colorCircleList) {
        double dist = [self sqDistX:CGPointMake(oneModel.x, oneModel.y) Y:px];
        if (minDist>dist) {
            minDist = dist;
            near = oneModel;
        }
    }
    return near;
    
}
-(void)colorSelectedEvent
{
    if (currentSelectedModel!=nil) {
        float tr,tg,tb;
        HSVtoRGB(&tr, &tg, &tb, currentSelectedModel.h,currentSelectedModel.s,self.brightnnness);
        UIColor * rgbColor = [UIColor colorWithRed:tr green:tg blue:tb alpha:self.controlAlpha];
        if ([delegate respondsToSelector:@selector(FlowerColorPickerDidSelectColor:)]) {
            [delegate FlowerColorPickerDidSelectColor:rgbColor];
        }

    }


    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * oneTouch = [touches anyObject];
    CGPoint tPoint = [oneTouch locationInView:self];
    lastPoint = tPoint;
    currentSelectedModel = [self findNearestByPositon:tPoint];
    [self colorSelectedEvent];
    [self setNeedsDisplay];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * oneTouch = [touches anyObject];
    CGPoint tPoint = [oneTouch locationInView:self];
    lastPoint = tPoint;
    currentSelectedModel = [self findNearestByPositon:tPoint];
    [self colorSelectedEvent];
    [self setNeedsDisplay];
    
}

@end
