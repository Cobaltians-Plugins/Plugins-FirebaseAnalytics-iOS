//
//  FirebaseAnalyticsPlugin.h
//  showtime
//
//  Created by Sébastien Vitard - Pro on 29/08/2017.
//  Copyright © 2017 Kristal. All rights reserved.
//

#import <Cobalt/CobaltAbstractPlugin.h>

/**
 * A plugin which allow Native & UIWebViews contained in CobaltViewController to log events with parameters to Firebase Anaytics.
 *
 * 1. Installation
 *  - Follow the steps at https://firebase.google.com/docs/ios/setup until the end of the 'Add the SDK' section
 *  - If you want more analytics, follow the instructions at https://firebase.google.com/support/guides/analytics-adsupport
 *  - Import the Firebase Analytics plugin into your project
 *  - In the `application:didFinishLaunchingWithOptions:` `AppDelegate`'s method, call `[FirebaseAnalyticsPlugin configure]`
 * 2. Enable Debug
 *  - In Xcode, select 'Product' > 'Scheme' > 'Edit scheme...'
 *  - Select 'Run' from the left menu.
 *  - Select the 'Arguments' tab.
 *  - In the 'Arguments Passed On Launch' section, add '-FIRAnalyticsDebugEnabled'.
 */
@interface FirebaseAnalyticsPlugin : CobaltAbstractPlugin

/**
 * Configures a default Firebase app. The default app is named "__FIRAPP_DEFAULT". 
 * This method is thread safe.
 * @warning This method should be called after the app is launched and before using Firebase services.
 * Raises an exception if any configuration step fails.
 * @see description copied from [FIRApp configure]
 */
+ (void)configure;

/**
 * Logs an event with no parameters to firebase Analytics.
 * @param event the event to log.
 * @see logEvent:withParams: method
 */
+ (void)logEvent:(nonnull NSString *)event;

/**
 * Logs an event with parameters to firebase Analytics.
 * @param event the event to log.
 * @param params the parameters to pass alongside the event.
 */
+ (void)logEvent:(nonnull NSString *)event
      withParams:(nullable NSDictionary *)params;
    
@end
