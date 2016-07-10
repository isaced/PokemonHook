//
//  POControlView.h
//  HookDemo
//
//  Created by isaced on 16/7/10.
//  Copyright © 2016年 isaced. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, POControlViewDirection) {
    POControlViewDirectionUp,
    POControlViewDirectionDown,
    POControlViewDirectionLeft,
    POControlViewDirectionRight,
};

typedef void(^POControlViewCallback)(POControlViewDirection direction);

@interface POControlView : UIView

@property (nonatomic, copy) POControlViewCallback controlCallback;

@end
