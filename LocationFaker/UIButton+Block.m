//
//  UIButton+Block.m
//  LocationFaker
//
//  Created by YamatoKira on 2016/7/12.
//
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

@implementation UIButton (Block)

- (void)touchUpInSideWithBlock:(void (^)())block {
    [self addTarget:self action:@selector(touchUpInSideInvoke) forControlEvents:UIControlEventTouchUpInside];
    [self setTouchUpInSideBlock:block];
}

- (void)setTouchUpInSideBlock:(void (^)())block {
    objc_setAssociatedObject(self, @selector(touchUpInSideBlock), block, OBJC_ASSOCIATION_COPY);
}

- (void (^)())touchUpInSideBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)touchUpInSideInvoke {
    if ([self touchUpInSideBlock]) {
        [self touchUpInSideBlock]();
    }
}

- (void)touchUpOutSideWithBlock:(void (^)())block {
    [self addTarget:self action:@selector(touchUpOutSideInvoke) forControlEvents:UIControlEventTouchUpInside];
    [self setTouchUpOutSideBlock:block];
}

- (void)setTouchUpOutSideBlock:(void (^)())block {
    objc_setAssociatedObject(self, @selector(touchUpOutSideBlock), block, OBJC_ASSOCIATION_COPY);
}

- (void (^)())touchUpOutSideBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)touchUpOutSideInvoke {
    if ([self touchUpOutSideBlock]) {
        [self touchUpOutSideBlock]();
    }
}

@end
