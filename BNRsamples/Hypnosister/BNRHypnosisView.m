//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Admin on 12/17/13.
//  Copyright (c) 2013 slayer. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView
@synthesize circleColor;

- (void)setCircleColor:(UIColor *)clr {
    circleColor = clr;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor lightGrayColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    CGContextSetLineWidth(ctx, 10);
    [[self circleColor] setStroke];
    //CGContextSetRGBStrokeColor(ctx, 0.6, 0.6, 0.6, 1.0);
    
    //CGContextAddArc(ctx, center.x, center.y, maxRaduis, 0.0, M_PI * 2.0, YES);
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20.0) {
        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI * 2, YES);
        CGContextSetRGBStrokeColor(ctx, (rand() % 1000) * 0.001, (rand() % 1000) * 0.001, (rand() % 1000) * 0.001, (rand() % 1000) * 0.001);
        //NSLog(@"%f, %d, %d", (rand() % 1000) * 0.001, rand(), rand());
        CGContextStrokePath(ctx);
    }
    
    
    CGContextStrokePath(ctx);
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"device started shaking");
    [self setCircleColor:[UIColor redColor]];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"End shaking");
    //[self setCircleColor:[UIColor lightGrayColor]];
}


@end
