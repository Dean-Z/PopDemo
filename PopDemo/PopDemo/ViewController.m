//
//  ViewController.m
//  PopDemo
//
//  Created by Jason on 2020/4/7.
//  Copyright © 2020 Jason. All rights reserved.
//

#import "ViewController.h"
#import "POP+MCAnimate.h"

static NSUInteger const kNumberOfCircles  = 18;
static CGFloat const kCircleRadius     = 50;
static CGFloat const kCircleSize       = 16;

@interface ViewController ()

@property (nonatomic, strong) NSArray *circles;

@end

@implementation ViewController

- (void)handleTap:(id)sender {
    for (UIView *circle in self.circles) {
        circle.linear.backgroundColor = [UIColor colorWithRed:0 green:0.439 blue:0.416 alpha:1];
    }
    
    CGFloat angleIncrement = M_PI * 2 / kNumberOfCircles;
    CGPoint center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2);

    NSArray *circles = self.circles;
    [circles sequenceWithInterval:0.1 animations:^(UIView *circle, NSInteger index){
        CGPoint position = center;
        position.x += kCircleRadius * sin(angleIncrement * index);
        position.y -= kCircleRadius * cos(angleIncrement * index);

        circle.spring.center = position;
        circle.spring.alpha = 1;
        circle.spring.scaleXY = CGPointMake(1, 1);
        circle.backgroundColor = [UIColor colorWithRed:0.8 green:0.1 blue:0.3 alpha:1];;
    } completion:^(BOOL finished){
        [circles sequenceWithInterval:0 animations:^(UIView *circle, NSInteger index){
            CGPoint position = center;
            position.x += 2 * kCircleRadius * sin(angleIncrement * index);
            position.y -= 2 * kCircleRadius * cos(angleIncrement * index);

            circle.spring.center = position;
        } completion:^(BOOL finished){
            [circles sequenceWithInterval:0 animations:^(UIView *circle, NSInteger index){
                CGPoint position = center;
                position.x += 2 * kCircleRadius * sin(angleIncrement * (index-1));
                position.y -= 2 * kCircleRadius * cos(angleIncrement * (index-1));

                circle.spring.center = position;
            } completion:^(BOOL finished){
                [circles sequenceWithInterval:0 animations:^(UIView *circle, NSInteger index){
                    CGPoint position = center;
                    position.x += 2 * kCircleRadius * sin(angleIncrement * index);
                    position.y -= 2 * kCircleRadius * cos(angleIncrement * index);

                    circle.spring.center = position;
                } completion:^(BOOL finished){
                    [circles sequenceWithInterval:0.1 animations:^(UIView *circle, NSInteger index){
                        circle.spring.center = center;
                        circle.spring.alpha = 0;
                        circle.spring.scaleXY = CGPointMake(0.5, 0.5);
                    } completion:nil];
                }];
            }];
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2);

    NSMutableArray *circles = [NSMutableArray array];

    for (int i = 0; i < kNumberOfCircles; i++) {
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kCircleSize, kCircleSize)];
        circle.backgroundColor = [UIColor colorWithRed:0.945 green:0.439 blue:0.416 alpha:1];
        circle.layer.cornerRadius = kCircleSize / 2;
        circle.center = center;
        circle.alpha = 0;
        circle.springSpeed = 1;
        circle.duration = 3;
        circle.scaleXY = CGPointMake(0.5, 0.5);

        [self.view addSubview:circle];
        [circles addObject:circle];
    }

    self.circles = [circles copy];
}


- (void)injected {
}

@end
