//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSDateFormatter, NSNumber, NSString;

@interface USParametersProvider : NSObject
{
    NSString *_bundleID;
    NSString *_bundleVersion;
    NSString *_token;
    NSString *_deviceID;
    NSString *_OSVersion;
    NSString *_deviceType;
    NSDateFormatter *_timezoneDateFormatter;
}

+ (id)sharedProvider;
- (void).cxx_destruct;
@property(readonly, nonatomic) NSString *UXMSchemaHash;
@property(readonly, nonatomic) NSString *UXMBundleHash;
@property(readonly, nonatomic) NSString *UXMBundleID;
- (id)performBlockSyncOnMainThread:(CDUnknownBlockType)arg1;
@property(readonly, nonatomic) NSString *SID;
@property(readonly, nonatomic) NSNumber *requestTimestamp;
@property(readonly, nonatomic) NSNumber *locationHeight;
@property(readonly, nonatomic) NSString *locationLongitude;
@property(readonly, nonatomic) NSString *locationLatitude;
- (id)currentLocation;
@property(readonly, nonatomic) NSString *locationTimezone;
@property(readonly, nonatomic) NSDateFormatter *timezoneDateFormatter; // @synthesize timezoneDateFormatter=_timezoneDateFormatter;
@property(readonly, nonatomic, getter=isOptOut) NSNumber *optOut;
- (_Bool)isInterfaceAvailableWithName:(id)arg1;
- (_Bool)isLANAvailable;
- (_Bool)isLocalWiFiAvailable;
@property(readonly, nonatomic) unsigned long long networkReachabilityStatus;
@property(readonly, nonatomic) NSString *networkReachabilityStatusString;
@property(readonly, nonatomic) NSString *localeIdentifier;
@property(readonly, nonatomic) NSString *idfaString;
@property(readonly, nonatomic) NSString *idfvString;
@property(readonly, nonatomic) NSString *SDKPluginVersion;
@property(readonly, nonatomic) NSString *SDKBuild;
@property(readonly, nonatomic) NSString *SDKVersion;
@property(readonly, nonatomic) NSString *manufacturer;
@property(readonly, nonatomic) NSString *deviceType; // @synthesize deviceType=_deviceType;
@property(readonly, nonatomic) NSNumber *screenScale;
@property(readonly, nonatomic) NSNumber *screenWidth;
@property(readonly, nonatomic) NSNumber *screenHeight;
@property(readonly, nonatomic) NSString *OSVersion; // @synthesize OSVersion=_OSVersion;
@property(readonly, nonatomic) NSString *OSName;
@property(readonly, nonatomic, getter=isAdvertisingTrackingLimited) NSNumber *advertisingTrackingLimited;
@property(readonly, nonatomic, getter=isJailbroken) NSNumber *jailbroken;
@property(readonly, nonatomic) NSString *deviceID; // @synthesize deviceID=_deviceID;
@property(readonly, nonatomic) NSString *carrierString;
@property(readonly, nonatomic) NSString *token; // @synthesize token=_token;
@property(readonly, nonatomic) NSString *bundleVersion; // @synthesize bundleVersion=_bundleVersion;
@property(readonly, nonatomic) NSString *bundleID; // @synthesize bundleID=_bundleID;
- (id)copyWithZone:(struct _NSZone *)arg1;

@end

