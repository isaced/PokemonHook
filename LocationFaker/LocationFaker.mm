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

@interface CLLocation(Swizzle)

@end

@implementation CLLocation(Swizzle)

static float x = -1;
static float y = -1;

static float controlOffsetX = 0;
static float controlOffsetY = 0;

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
    
    // init
    [self controlView];
}

- (CLLocationCoordinate2D) coordinate_ {
    
    CLLocationCoordinate2D pos = [self coordinate_];
    
    // 算与联合广场的坐标偏移量
    if (x == -1 && y == -1) {
        x = pos.latitude - -36.851638;
        y = pos.longitude - (174.765068);
        
        [[NSUserDefaults standardUserDefaults] setValue:@(x) forKey:@"_fake_x"];
        [[NSUserDefaults standardUserDefaults] setValue:@(y) forKey:@"_fake_y"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return CLLocationCoordinate2DMake(pos.latitude-x + (controlOffsetX), pos.longitude-y + (controlOffsetY));
}

+ (POControlView *)controlView{
    if (!controlV) {
        controlV = [[POControlView alloc] init];
        controlV.controlCallback =  ^(POControlViewDirection direction){
            switch (direction) {
                case POControlViewDirectionUp:
                    x+=self.controlOffset;
                    break;
                case POControlViewDirectionDown:
                    x-=self.controlOffset;
                    break;
                case POControlViewDirectionLeft:
                    y-=self.controlOffset;
                    break;
                case POControlViewDirectionRight:
                    y+=self.controlOffset;
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

+(float) randFloatBetween:(float)low to:(float)high
{
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}

@end

