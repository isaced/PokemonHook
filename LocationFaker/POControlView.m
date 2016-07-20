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
    self.layer.anchorPoint = CGPointMake(0, 0);
    self.frame = CGRectMake(0, 80, 150, 150);
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 10.f;
    
    UIButton *up = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    up.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    [up setTitle:@"↑" forState:UIControlStateNormal];
    up.titleLabel.font = [UIFont systemFontOfSize:20.0];
    up.tag = 101;
    [up addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:up];
    
    
    UIButton *down = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    down.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    [down setTitle:@"↓" forState:UIControlStateNormal];
    down.titleLabel.font = [UIFont systemFontOfSize:20.0];
    down.tag = 102;
    [down addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:down];
    
    
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 50, 50)];
    left.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    [left setTitle:@"←" forState:UIControlStateNormal];
    left.titleLabel.font = [UIFont systemFontOfSize:20.0];
    left.tag = 103;
    [left addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:left];
    
    
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 50, 50)];
    right.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    [right setTitle:@"→" forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont systemFontOfSize:20.0];
    right.tag = 104;
    [right addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:right];
    
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    for (UIButton *b in [self subviews]) {
        b.hidden = YES;
    }
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
    doubleTap.numberOfTapsRequired = 10;
    [self addGestureRecognizer:doubleTap];
    
    
}

- (void)doubleTap{
    if (!CGAffineTransformIsIdentity(self.transform)) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
            self.transform = CGAffineTransformIdentity;
            for (UIButton *b in [self subviews]) {
                b.hidden = NO;
            }
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor clearColor];
            self.transform = CGAffineTransformMakeScale(0.5, 0.5);
            for (UIButton *b in [self subviews]) {
                b.hidden = YES;
            }
        }];
    }
}

- (void)buttonAction:(UIButton *)sender{
    [sender.titleLabel.layer addAnimation:[self scaleAnimation] forKey:@"scale"];
    
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
    scale.duration = 0.3;
    scale.removedOnCompletion = YES;
    return scale;
}

#pragma mark override touch
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    CGPoint pre = [[touches anyObject] previousLocationInView:self];
    
    CGPoint now = [[touches anyObject] locationInView:self];
    
    self.frame = CGRectApplyAffineTransform(self.frame, CGAffineTransformMakeTranslation(now.x - pre.x, now.y - pre.y));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (!CGRectContainsRect(self.superview.bounds, self.frame)) {
        CGFloat deltaX = 0;
        CGFloat deltaY = 0;
        
        if (self.frame.origin.x < 0) {
            deltaX = -self.frame.origin.x;
        }
        else if (CGRectGetMaxX(self.frame) > self.superview.bounds.size.width) {
            deltaX = -CGRectGetMaxX(self.frame) + self.superview.bounds.size.width;
        }
        
        if (self.frame.origin.y < 0) {
            deltaY = -self.frame.origin.y;
        }
        else if (CGRectGetMaxY(self.frame) > self.superview.bounds.size.height) {
            deltaY = -CGRectGetMaxY(self.frame) + self.superview.bounds.size.height;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectApplyAffineTransform(self.frame, CGAffineTransformMakeTranslation(deltaX, deltaY));
        }];
    }
}

@end
