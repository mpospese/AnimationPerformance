//
//  MyAwesomeView.m
//  AnimationPerformance
//
//  Created by Crazy Milk Software on 9/10/13.
//  Copyright (c) 2013 Crazy Milk Software. All rights reserved.
//

#import "MyAwesomeView.h"

@interface MyAwesomeView()

@end

@implementation MyAwesomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5];
    [self.color set];
    CGContextAddPath(context, path.CGPath);
    CGContextFillPath(context);
}

@end
