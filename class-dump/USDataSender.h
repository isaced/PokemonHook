//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSURLConnectionDataDelegate.h"
#import "USDataSenderInterface.h"

@class NSMutableDictionary, NSOperationQueue, NSString;

@interface USDataSender : NSObject <NSURLConnectionDataDelegate, USDataSenderInterface>
{
    NSOperationQueue *_sendQueue;
    NSMutableDictionary *_connections;
    unsigned long long _taskIdentifier;
}

@property unsigned long long taskIdentifier; // @synthesize taskIdentifier=_taskIdentifier;
@property(retain, nonatomic) NSMutableDictionary *connections; // @synthesize connections=_connections;
@property(readonly, nonatomic) NSOperationQueue *sendQueue; // @synthesize sendQueue=_sendQueue;
- (void).cxx_destruct;
- (_Bool)verifySignatureWithInfo:(id)arg1;
- (void)endBackgroundTask;
- (void)endBackgroundTaskIfIdle;
- (_Bool)hasIncompleteConnections;
- (void)onApplicationWillEnterForeground:(id)arg1;
- (void)startBackgroundTask;
- (void)onApplicationDidEnterBackground:(id)arg1;
- (void)installObservers;
- (void)connectionDidFinishLoading:(id)arg1;
- (void)connection:(id)arg1 didReceiveData:(id)arg2;
- (void)connection:(id)arg1 didFailWithError:(id)arg2;
- (void)connection:(id)arg1 didReceiveResponse:(id)arg2;
- (id)connection:(id)arg1 willSendRequest:(id)arg2 redirectResponse:(id)arg3;
- (void)sendData:(id)arg1 toURL:(id)arg2 completionHandler:(CDUnknownBlockType)arg3 queue:(id)arg4;
- (void)dealloc;
- (id)initWithSendQueue:(id)arg1;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
