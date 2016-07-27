//
//  RNBuglife.m
//  RNBuglife
//
//  Copyright © 2016 Buglife, Inc. All rights reserved.
//

#import "RNBuglife.h"
#import <Buglife/Buglife.h>
#import "RCTConvert.h"

@implementation RCTConvert (InvocationOptions)
	RCT_ENUM_CONVERTER(LIFEInvocationOptions, (@{ @"invocationOptionsNone" : @(LIFEInvocationOptionsNone),
												@"invocationOptionsShake" : @(LIFEInvocationOptionsShake),
												@"invocationOptionsScreenshot" : @(LIFEInvocationOptionsScreenshot),
												@"invocationOptionsFloatingButton" : @(LIFEInvocationOptionsFloatingButton)}),
												LIFEInvocationOptionsNone, integerValue)
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
}

RCT_EXPORT_METHOD(startWithEmail:(NSString *)email)
{
    [[Buglife sharedBuglife] startWithEmail:email];
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

- (NSDictionary *)constantsToExport
{
    return @{ @"invocationOptionsNone" : @(LIFEInvocationOptionsNone),
                @"invocationOptionsShake" : @(LIFEInvocationOptionsShake),
                @"invocationOptionsScreenshot" : @(LIFEInvocationOptionsScreenshot),
                @"invocationOptionsFloatingButton" : @(LIFEInvocationOptionsFloatingButton) };
};


@end
