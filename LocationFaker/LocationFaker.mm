//
//  LocationFaker.mm
//  LocationFaker
//
//  Created by Xiaoxuan Tang on 16/7/8.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>
#import "POControlView.h"
#import "UIButton+Block.h"
#import "UIAlertView+Blocks.h"
#import <objc/message.h>

@interface CLLocation(Swizzle)

@end

@implementation CLLocation(Swizzle)

static float x = -1;
static float y = -1;

static float controlOffsetX = 0;
static float controlOffsetY = 0;

/**
 *  默认出生点
 */
static float defaultLatitude = -33.8589681;
static float defaultLongtitude = 151.2133306;

static POControlView *controlV;

+ (void) load {
    Method m1 = class_getInstanceMethod(self, @selector(coordinate));
    Method m2 = class_getInstanceMethod(self, @selector(coordinate_));
    
    method_exchangeImplementations(m1, m2);
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_x"]) {
        x = [[[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_x"] floatValue];
    };
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_y"]) {
        y = [[[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_y"] floatValue];
    };
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_defaultLatitude"]) {
        defaultLatitude = [[[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_defaultLatitude"] floatValue];
    }
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_defaultLongtitude"]) {
        defaultLongtitude = [[[NSUserDefaults standardUserDefaults] valueForKey:@"_fake_defaultLongtitude"] floatValue];
    }
    
    // init
    [self controlView];
    
    [self changeInitialLocationButton];
    
    [self addLoationDisplay];
}

- (CLLocationCoordinate2D) coordinate_ {
    
    CLLocationCoordinate2D pos = [self coordinate_];
    
    // 算与默认位置的偏移量
    if (x == -1 && y == -1) {
        
        x = pos.latitude - defaultLatitude;
        y = pos.longitude - defaultLongtitude;
        
        [[NSUserDefaults standardUserDefaults] setValue:@(x) forKey:@"_fake_x"];
        [[NSUserDefaults standardUserDefaults] setValue:@(y) forKey:@"_fake_y"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // 更新label
    dispatch_async(dispatch_get_main_queue(), ^{
        locationLable.text = [NSString stringWithFormat:@"纬度：%.6f\n经度：%.6f",pos.latitude- x - (controlOffsetX), pos.longitude - y - (controlOffsetY)];
    });
    
    return CLLocationCoordinate2DMake(pos.latitude- x - (controlOffsetX), pos.longitude - y - (controlOffsetY));
}

+ (POControlView *)controlView{
    if (!controlV) {
        controlV = [[POControlView alloc] init];
        controlV.controlCallback =  ^(POControlViewDirection direction){
            switch (direction) {
                case POControlViewDirectionUp:
                    controlOffsetX -= self.controlOffset;
                    break;
                case POControlViewDirectionDown:
                    controlOffsetX += self.controlOffset;
                    break;
                case POControlViewDirectionLeft:
                    controlOffsetY += self.controlOffset;
                    break;
                case POControlViewDirectionRight:
                    controlOffsetY -= self.controlOffset;
                    break;
                default:
                    break;
            }
        };
        
        // add to key window
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[UIApplication sharedApplication] keyWindow] addSubview:controlV];
        });
    }
    return controlV;
}

+ (float)controlOffset{
    return [self randFloatBetween:0.000150 to:0.000300];
}

+ (float) randFloatBetween:(float)low to:(float)high
{
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}

static UIButton *locationButton;
+ (void)changeInitialLocationButton {
    if (!locationButton) {
        locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [locationButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        locationButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 - 22, 20, 44, 44);
        
        [locationButton touchUpOutSideWithBlock:^{
            UIAlertView *alertView = [UIAlertView showWithTitle:@"666航空" message:@"准备飞去那里抓小精灵？" style:UIAlertViewStyleLoginAndPasswordInput cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    @try {
                        // 修改 x, y 以及userdefaults缓存
                        CGFloat latitude = [[[alertView textFieldAtIndex:0] text] floatValue];
                        
                        CGFloat longtitude = [[[alertView textFieldAtIndex:1] text] floatValue];
                        
                        
                        defaultLatitude = latitude;
                        defaultLongtitude = longtitude;
                        
                        [[NSUserDefaults standardUserDefaults] setValue:@(latitude) forKey:@"_fake_defaultLatitude"];
                        [[NSUserDefaults standardUserDefaults] setValue:@(longtitude) forKey:@"_fake_defaultLongtitude"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        // 由于更新了默认起始位置，所以需要标记x y为－1
                        x = -1;
                        y = -1;
                    } @catch (NSException *exception) {
                        NSLog(@"%@", exception);
                    }
                }
            }];
            
            [alertView textFieldAtIndex:0].placeholder = @"纬度(如：-32.164823)";
            [alertView textFieldAtIndex:1].placeholder = @"经度(如：164.321891)";
            [alertView textFieldAtIndex:1].secureTextEntry = NO;
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[UIApplication sharedApplication] keyWindow] addSubview:locationButton];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [locationButton removeFromSuperview];
            });
        });
    }
}

static UILabel *locationLable;
+ (void)addLoationDisplay {
    if (!locationLable) {
        locationLable = [[UILabel alloc] init];
        
        locationLable.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 40, 100, 40);
        
        locationLable.layer.cornerRadius = 5.f;
        
        locationLable.clipsToBounds = YES;
        
        locationLable.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.4];
        
        locationLable.textColor = [UIColor darkTextColor];
        
        locationLable.textAlignment = NSTextAlignmentCenter;
        
        locationLable.font = [UIFont systemFontOfSize:10.f];
        
        locationLable.numberOfLines = 0;
        
        locationLable.adjustsFontSizeToFitWidth = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow addSubview:locationLable];
        });
    }
}

@end

