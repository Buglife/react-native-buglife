//
//  RNBuglife.h
//  RNBuglife
//
//  Copyright © 2017 Buglife, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTEventEmitter.h"
#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

@interface RNBuglife : RCTEventEmitter <RCTBridgeModule>

@end
