//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "USEvent.h"

@class NSNumber;

@interface USPushReceivedEvent : USEvent
{
}

+ (id)eventWithParameters:(id)arg1 messageID:(id)arg2 campaignID:(id)arg3;
@property(readonly, nonatomic) NSNumber *campaignID;
@property(readonly, nonatomic) NSNumber *messageID;
- (id)initWithParameters:(id)arg1 messageID:(id)arg2 campaignID:(id)arg3;
- (id)initWithType:(id)arg1 parameters:(id)arg2;

@end

