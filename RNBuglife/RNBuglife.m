//
//  RNBuglife.m
//  RNBuglife
//
//  Copyright © 2017 Buglife, Inc. All rights reserved.
//

#import "RNBuglife.h"
#import <Buglife/Buglife.h>
#import "RCTConvert.h"
#import "RCTEventDispatcher.h"

static NSString * const kBuglifeAttachmentRequestEventName = @"BuglifeAttachmentRequest";

@implementation RCTConvert (InvocationOptions)
    RCT_ENUM_CONVERTER(LIFEInvocationOptions, (@{ @"invocationOptionsNone" : @(LIFEInvocationOptionsNone),
                                                @"invocationOptionsShake" : @(LIFEInvocationOptionsShake),
                                                @"invocationOptionsScreenshot" : @(LIFEInvocationOptionsScreenshot),
                                                @"invocationOptionsFloatingButton" : @(LIFEInvocationOptionsFloatingButton)}),
                                                LIFEInvocationOptionsNone, integerValue)
@end

@interface RNBuglife () <BuglifeDelegate>
@end

@implementation RNBuglife

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(setInvocationOptions:(LIFEInvocationOptions)invocationOptions)
{
    [[Buglife sharedBuglife] setInvocationOptions:invocationOptions];
}

RCT_EXPORT_METHOD(startWithAPIKey:(NSString *)apiKey)
{
    [[Buglife sharedBuglife] startWithAPIKey:apiKey];
    [Buglife sharedBuglife].delegate = self;
}

RCT_EXPORT_METHOD(startWithEmail:(NSString *)email)
{
    [[Buglife sharedBuglife] startWithEmail:email];
    [Buglife sharedBuglife].delegate = self;
}

RCT_EXPORT_METHOD(presentReporter)
{
    [[Buglife sharedBuglife] presentReporter];
}

RCT_EXPORT_METHOD(setUserIdentifier:(NSString *)identifier)
{
    [[Buglife sharedBuglife] setUserIdentifier:identifier];
}

RCT_EXPORT_METHOD(setUserEmail:(NSString *)email)
{
    [[Buglife sharedBuglife] setUserEmail:email];
}

RCT_EXPORT_METHOD(addAttachmentWithContents:(NSString *)base64Contents type:(NSString *)type filename:(NSString *)filename resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Contents options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [self _addAttachmentWithData:data type:type filename:filename resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(addAttachmentWithJSON:(id)jsonObject filename:(NSString *)filename resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:&error];

    if (!data) {
        reject(error.domain, error.localizedDescription, error);
        return;
    }

    [self _addAttachmentWithData:data type:LIFEAttachmentTypeIdentifierJSON filename:filename resolver:resolve rejecter:reject];
}

- (void)_addAttachmentWithData:(NSData *)data type:(NSString *)type filename:(NSString *)filename resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject
{
    NSError *error = nil;
    BOOL result = [[Buglife sharedBuglife] addAttachmentWithData:data type:type filename:filename error:&error];
    
    if (!result) {
        reject(error.domain, error.localizedDescription, error);
    } else {
        resolve(nil);
    }
}

- (NSDictionary *)constantsToExport
{
    return @{ @"invocationOptionsNone" : @(LIFEInvocationOptionsNone),
                @"invocationOptionsShake" : @(LIFEInvocationOptionsShake),
                @"invocationOptionsScreenshot" : @(LIFEInvocationOptionsScreenshot),
                @"invocationOptionsFloatingButton" : @(LIFEInvocationOptionsFloatingButton),
                @"attachmentTypeIdentifierText" : LIFEAttachmentTypeIdentifierText,
                @"attachmentTypeIdentifierJSON" : LIFEAttachmentTypeIdentifierJSON,
                @"attachmentTypeIdentifierSqlite" : LIFEAttachmentTypeIdentifierSqlite,
                @"attachmentTypeIdentifierImage" : LIFEAttachmentTypeIdentifierImage,
                @"BuglifeAttachmentRequest" : kBuglifeAttachmentRequestEventName};
};

- (void)buglife:(nonnull Buglife *)buglife handleAttachmentRequestWithCompletionHandler:(nonnull void (^)())completionHandler
{
    [_bridge.eventDispatcher sendAppEventWithName:kBuglifeAttachmentRequestEventName body:@{}];
    completionHandler();
}

@end
