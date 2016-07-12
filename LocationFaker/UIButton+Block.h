//
//  UIButton+Block.h
//  LocationFaker
//
//  Created by YamatoKira on 2016/7/12.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (Block)

- (void)touchUpInSideWithBlock:(void (^)())block;

@end
