//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "USBaseAction.h"

@class NSDictionary, NSString;

@interface USConditionalAction : USBaseAction
{
    NSDictionary *_conditionParameters;
    NSString *_thenTrigger;
    NSString *_elseTrigger;
}

@property(readonly, nonatomic) NSString *elseTrigger; // @synthesize elseTrigger=_elseTrigger;
@property(readonly, nonatomic) NSString *thenTrigger; // @synthesize thenTrigger=_thenTrigger;
@property(readonly, nonatomic) NSDictionary *conditionParameters; // @synthesize conditionParameters=_conditionParameters;
- (void).cxx_destruct;
- (id)initWithParameters:(id)arg1 map:(id)arg2 handler:(CDUnknownBlockType)arg3;

@end

