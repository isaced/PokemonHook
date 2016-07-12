//
//  POControlView.m
//  HookDemo
//
//  Created by isaced on 16/7/10.
//  Copyright © 2016年 isaced. All rights reserved.
//

#import "POControlView.h"

@implementation POControlView

- (instancetype)init{
    if (self=[super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.frame = CGRectMake(0, 80, 100, 100);
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.200];
    
    UIButton *up = [[UIButton alloc] initWithFrame:CGRectMake(25, 0, 50, 50)];
    [up setTitle:@"↑" forState:UIControlStateNormal];
    up.titleLabel.font = [UIFont systemFontOfSize:20.0];
    up.tag = 101;
    [up addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:up];
    
    
    UIButton *down = [[UIButton alloc] initWithFrame:CGRectMake(25, 50, 50, 50)];
    [down setTitle:@"↓" forState:UIControlStateNormal];
    down.titleLabel.font = [UIFont systemFontOfSize:20.0];
    down.tag = 102;
    [down addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:down];
    
    
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, 50, 50)];
    [left setTitle:@"←" forState:UIControlStateNormal];
    left.titleLabel.font = [UIFont systemFontOfSize:20.0];
    left.tag = 103;
    [left addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:left];
    
    
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(50, 25, 50, 50)];
    [right setTitle:@"→" forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont systemFontOfSize:20.0];
    right.tag = 104;
    [right addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:right];
    
    self.alpha = 0;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
    doubleTap.numberOfTapsRequired = 3;

    [self addGestureRecognizer:doubleTap];
}

- (void)doubleTap{
    self.alpha = 1 - self.alpha;
}

- (void)buttonAction:(UIButton *)sender{
    [sender.layer addAnimation:[self scaleAnimation] forKey:@"scale"];
    
    if (self.controlCallback) {
        POControlViewDirection direction;
        switch (sender.tag) {
            case 101:
                direction = POControlViewDirectionUp;
                break;
            case 102:
                direction = POControlViewDirectionDown;
                break;
            case 103:
                direction = POControlViewDirectionLeft;
                break;
            case 104:
                direction = POControlViewDirectionRight;
                break;
                
            default:
                break;
        }
        
        self.controlCallback(direction);
    }
}

- (CAAnimation *)scaleAnimation{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.toValue = @1.5;
    return scale;
}

@end
