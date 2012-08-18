//
//  ScanditSDK.h
//  PhoneGapTest
//
//  Copyright 2011 Mirasense AG. All rights reserved.
//

#import "Cordova/CDVPlugin.h"
#import "ScanditSDKBarcodePicker.h"
#import "ScanditSDKOverlayController.h"

@interface ScanditSDK : CDVPlugin <ScanditSDKOverlayControllerDelegate> {
    NSString *callbackId;
    BOOL wasStatusBarHidden;
}

@property (nonatomic, copy) NSString *callbackId;
@property (readwrite, assign) BOOL hasPendingOperation;

- (void)scan:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
