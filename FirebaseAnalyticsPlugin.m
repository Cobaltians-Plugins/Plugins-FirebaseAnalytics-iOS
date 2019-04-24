//
//  FirebaseAnalyticsPlugin.m
//  showtime
//
//  Created by Sébastien Vitard - Pro on 29/08/2017.
//  Copyright © 2017 Kristal. All rights reserved.
//

#import "FirebaseAnalyticsPlugin.h"

#import <objc/runtime.h>

@import Firebase;

@implementation FirebaseAnalyticsPlugin

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark LIFECYCLE

////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)configure {
    [FIRApp configure];
}

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark COBALT

////////////////////////////////////////////////////////////////////////////////////////////////

- (void)onMessageFromWebView:(WebViewType)webView
          inCobaltController:(nonnull CobaltViewController *)viewController
                  withAction:(nonnull NSString *)action
                        data:(nullable NSDictionary *)data
          andCallbackChannel:(nullable NSString *)callbackChannel{
    
    if ([action isKindOfClass:[NSString class]]
        && [@"logEvent" isEqualToString:action]
        && data != nil
        && [data isKindOfClass:[NSDictionary class]]) {
        id event = data[@"event"];
        id params = data[@"params"];
        
        if (event != nil && [event isKindOfClass:[NSString class]]
            && (params == nil || [params isKindOfClass:[NSDictionary class]])) {
            [FirebaseAnalyticsPlugin logEvent:event
                                   withParams:params];
            return;
        }
    }
    
    NSLog(@"FirebaseAnalyticsPlugin - onMessage: %@\n\
          Possible issues: \n\
          \t- data object is empty or not an oject, \n\
          \t- data.event is empty or not a string, \n\
          \t- data.params is defined but not an object.", message);
}

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark METHODS

////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)logEvent:(nonnull NSString *)event {
    [FirebaseAnalyticsPlugin logEvent:event
                           withParams:nil];
}

+ (void)logEvent:(nonnull NSString *)event
      withParams:(nullable NSDictionary *)params {
    NSMutableDictionary *cleanedParams = params != nil ? [NSMutableDictionary dictionaryWithCapacity:params.count] : nil;
    if (params != nil) {
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]
                || [obj isKindOfClass:[NSNumber class]]) {
                [cleanedParams setObject:obj
                                  forKey:key];
            }
            else {
                NSLog(@"FirebaseAnalyticsPlugin - logEvent:withParams: param %@ with value %@ of type %@ not supported.\n\
                      Only values with a string or number type are allowed.", key, obj, [obj class]);
            }
        }];
    }
    
    [FIRAnalytics logEventWithName:event
                        parameters:cleanedParams];
}

@end
