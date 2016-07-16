//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UpsightStorableObject.h"

#import "NSCoding.h"

@class USEventParameters;

@interface USEvent : UpsightStorableObject <NSCoding>
{
    USEventParameters *_parameters;
}

@property(readonly, nonatomic) USEventParameters *parameters; // @synthesize parameters=_parameters;
- (void).cxx_destruct;
- (id)initWithCoder:(id)arg1;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithType:(id)arg1 parameters:(id)arg2;
- (id)initWithType:(id)arg1 version:(id)arg2 ID:(id)arg3;
- (id)init;

@end

