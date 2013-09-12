//
//  ViewController.m
//  AnimationPerformance
//
//  Created by Crazy Milk Software on 9/10/13.
//  Copyright (c) 2013 Crazy Milk Software. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyAwesomeView.h"

#define BOX_SIZE    100

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *boxes;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
	// Do any additional setup after loading the view, typically from a nib.

    self.boxes = [NSMutableArray array];
    [self doAddBox];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTapped:)];
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerTap:)];
    tap2.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tap2];
}

- (void)doAddBox
{
    [self addBox];
    [self arrangeBoxes];
    [self animateBoxes];
    [self updateCount];
}

- (void)doRemoveBox
{
    UIView *box = [self.boxes lastObject];
    [box removeFromSuperview];
    [self.boxes removeLastObject];
    
    [self updateCount];
}

- (void)updateCount
{
    self.countLabel.text = [@([self.boxes count]) stringValue];
}

- (void)addBox
{
    UIView *box = [self makeBoxWithFrame:CGRectMake(0, 0, BOX_SIZE, BOX_SIZE)];
    
    [self.view addSubview:box];
    [self.boxes addObject:box];
}

- (void)arrangeBoxes
{
    CGFloat height = CGRectGetHeight(self.view.bounds) - BOX_SIZE;
    NSUInteger index = 0;
    NSUInteger boxCount = [self.boxes count];
    for (UIView *box in self.boxes)
    {
        box.center = CGPointMake(box.center.x, (index + 1) * height / (boxCount + 1) + (BOX_SIZE / 2));
        index++;
    }
}
- (UIView *)makeBoxWithFrame:(CGRect)frame
{
    MyAwesomeView *box = [[MyAwesomeView alloc] initWithFrame:frame];
    box.backgroundColor = [UIColor clearColor];
    box.color = [UIColor colorWithRed:arc4random_uniform(256)/255.f green:arc4random_uniform(256)/255.f blue:arc4random_uniform(256)/255.f alpha:1];
    box.layer.shadowOpacity = 0.5;
    box.layer.shadowOffset = CGSizeMake(0, 3);
   
    if (frame.size.height > 20 && frame.size.width > 20)
    {
        UIView *subBox = [self makeBoxWithFrame:CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20)];
        [box addSubview:subBox];
    }
    return box;
}

- (void)animateBoxes
{
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         
        for (UIView *box in self.boxes)
        {
            box.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(box.bounds) / 2, box.center.y);
            box.transform = CGAffineTransformMakeRotation(M_PI_4);
        }
                         
    } completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture Recognizers

- (void)screenTapped:(UIGestureRecognizer *)recognizer
{
    [self doAddBox];
}

- (void)twoFingerTap:(UIGestureRecognizer *)recognizer
{
    [self doRemoveBox];
}

@end
