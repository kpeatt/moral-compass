//
//  ScanditSDK.mm
//
//  Copyright 2011 Mirasense AG. All rights reserved.
//

#import "ScanditSDK.h"


@implementation ScanditSDK

@synthesize callbackId;
@synthesize hasPendingOperation;


- (void)scan:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    
    if (self.hasPendingOperation) {
        return;
    }
    self.hasPendingOperation = YES;
    
    
    NSUInteger argc = [arguments count];
    if (argc < 2) {
        NSLog(@"The scan call received too few arguments and has to return without starting.");
        return;
    }
    self.callbackId = [arguments pop];
    
    NSString *appKey = [arguments objectAtIndex:0];
    
    // Hide the status bar to get a bigger area of the video feed. We have to set this before we add
    // GUI elements to the overview, such that the views are aware of the fact that there is no
    // status bar visible.
    if ([[UIApplication sharedApplication] isStatusBarHidden]) {
        wasStatusBarHidden = YES;
    } else {
        wasStatusBarHidden = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    }
    
    ScanditSDKBarcodePicker *scanditSDKBarcodePicker = [[ScanditSDKBarcodePicker alloc] initWithAppKey:appKey];
    
    // Set the options.
    NSObject *scanning1D = [options objectForKey:@"1DScanning"];
    if (scanning1D && [scanning1D isKindOfClass:[NSNumber class]]) {
        [scanditSDKBarcodePicker set1DScanningEnabled:[((NSNumber *)scanning1D) boolValue]];
    }
    NSObject *scanning2D = [options objectForKey:@"2DScanning"];
    if (scanning2D && [scanning2D isKindOfClass:[NSNumber class]]) {
        [scanditSDKBarcodePicker set2DScanningEnabled:[((NSNumber *)scanning2D) boolValue]];
    }
    NSObject *scanningHotspot = [options objectForKey:@"scanningHotspot"];
    if (scanningHotspot && [scanningHotspot isKindOfClass:[NSString class]]) {
        NSArray *split = [((NSString *) scanningHotspot) componentsSeparatedByString:@"/"];
        if ([split count] == 2) {
            float x = [[split objectAtIndex:0] floatValue];
            float y = [[split objectAtIndex:1] floatValue];
            [scanditSDKBarcodePicker setScanningHotSpotToX:x andY:y];
        }
    }
    
    NSObject *beep = [options objectForKey:@"beep"];
    if (beep && [beep isKindOfClass:[NSNumber class]]) {
        [scanditSDKBarcodePicker.overlayController setBeepEnabled:[((NSNumber *)beep) boolValue]];
    }
    NSObject *vibrate = [options objectForKey:@"vibrate"];
    if (vibrate && [vibrate isKindOfClass:[NSNumber class]]) {
        [scanditSDKBarcodePicker.overlayController setVibrateEnabled:[((NSNumber *)vibrate) boolValue]];
    }
    NSObject *luckyShot = [options objectForKey:@"showMostLikelyBarcodeUIElement"];
    if (luckyShot && [luckyShot isKindOfClass:[NSNumber class]]) {
        [scanditSDKBarcodePicker.overlayController showMostLikelyBarcodeUIElement:[((NSNumber *)luckyShot) boolValue]];
    }
    
    NSObject *uiFont = [options objectForKey:@"uiFont"];
    if (uiFont && [uiFont isKindOfClass:[NSString class]]) {
        [scanditSDKBarcodePicker.overlayController setUIFont:((NSString *) uiFont)];
    }
    NSObject *t1 = [options objectForKey:@"textForMostLikelyBarcodeUIElement"];
    if (t1 && [t1 isKindOfClass:[NSString class]]) {
        [scanditSDKBarcodePicker.overlayController setTextForMostLikelyBarcodeUIElement:((NSString *) t1)];
    }
    NSObject *t2 = [options objectForKey:@"textForInitialScanScreenState"];
    if (t2 && [t2 isKindOfClass:[NSString class]]) {
        [scanditSDKBarcodePicker.overlayController setTextForInitialScanScreenState:((NSString *) t2)];
    }
    NSObject *t3 = [options objectForKey:@"textForBarcodePresenceDetected"];
    if (t3 && [t3 isKindOfClass:[NSString class]]) {
        [scanditSDKBarcodePicker.overlayController setTextForBarcodePresenceDetected:((NSString *) t3)];
    }
    NSObject *t4 = [options objectForKey:@"textForBarcodeDecodingInProgress"];
    if (t4 && [t4 isKindOfClass:[NSString class]]) {
        [scanditSDKBarcodePicker.overlayController setTextForBarcodeDecodingInProgress:((NSString *) t4)];
    }
    NSObject *t5 = [options objectForKey:@"searchBarActionButtonCaption"];
    if (t5 && [t5 isKindOfClass:[NSString class]]) {
        [scanditSDKBarcodePicker.overlayController setSearchBarActionButtonCaption:((NSString *) t5)];
    }
    NSObject *t6 = [options objectForKey:@"searchBarCancelButtonCaption"];
    if (t6 && [t6 isKindOfClass:[NSString class]]) {
        [scanditSDKBarcodePicker.overlayController setSearchBarCancelButtonCaption:((NSString *) t6)];
    }
    NSObject *t7 = [options objectForKey:@"searchBarPlaceholderText"];
    if (t7 && [t7 isKindOfClass:[NSString class]]) {
        [scanditSDKBarcodePicker.overlayController setSearchBarPlaceholderText:((NSString *) t7)];
    }
    NSObject *t8 = [options objectForKey:@"toolBarButtonCaption"];
    if (t8 && [t8 isKindOfClass:[NSString class]]) {
        [scanditSDKBarcodePicker.overlayController setToolBarButtonCaption:((NSString *) t8)];
    }
    
    
    NSObject *color1 = [options objectForKey:@"viewfinderColor"];
    if (color1 && [color1 isKindOfClass:[NSString class]]) {
        NSString *color1String = (NSString *)color1;
        if ([color1String length] == 6) {
            unsigned int redInt;
            NSScanner *redScanner = [NSScanner scannerWithString:[color1String substringToIndex:2]];
            [redScanner scanHexInt:&redInt];
            float red = ((float) redInt) / 256.0;
            
            unsigned int greenInt;
            NSScanner *greenScanner = [NSScanner scannerWithString:[[color1String substringFromIndex:2] substringToIndex:2]];
            [greenScanner scanHexInt:&greenInt];
            float green = ((float) greenInt) / 256.0;
            
            unsigned int blueInt;
            NSScanner *blueScanner = [NSScanner scannerWithString:[color1String substringFromIndex:4]];
            [blueScanner scanHexInt:&blueInt];
            float blue = ((float) blueInt) / 256.0;
            
            [scanditSDKBarcodePicker.overlayController setViewfinderColor:red green:green blue:blue];
        }
    }
    NSObject *color2 = [options objectForKey:@"viewfinderDecodedColor"];
    if (color2 && [color2 isKindOfClass:[NSString class]]) {
        NSString *color2String = (NSString *)color2;
        if ([color2String length] == 6) {
            unsigned int redInt;
            NSScanner *redScanner = [NSScanner scannerWithString:[color2String substringToIndex:2]];
            [redScanner scanHexInt:&redInt];
            float red = ((float) redInt) / 256.0;
            
            unsigned int greenInt;
            NSScanner *greenScanner = [NSScanner scannerWithString:[[color2String substringFromIndex:2] substringToIndex:2]];
            [greenScanner scanHexInt:&greenInt];
            float green = ((float) greenInt) / 256.0;
            
            unsigned int blueInt;
            NSScanner *blueScanner = [NSScanner scannerWithString:[color2String substringFromIndex:4]];
            [blueScanner scanHexInt:&blueInt];
            float blue = ((float) blueInt) / 256.0;
            
            [scanditSDKBarcodePicker.overlayController setViewfinderDecodedColor:red green:green blue:blue];
        }
    }
    
    NSObject *minManual = [options objectForKey:@"minSearchBarBarcodeLength"];
    if (minManual && [minManual isKindOfClass:[NSNumber class]]) {
        [scanditSDKBarcodePicker.overlayController setMinSearchBarBarcodeLength:[((NSNumber *) minManual) integerValue]];
    }
    NSObject *maxManual = [options objectForKey:@"maxSearchBarBarcodeLength"];
    if (maxManual && [maxManual isKindOfClass:[NSNumber class]]) {
        [scanditSDKBarcodePicker.overlayController setMaxSearchBarBarcodeLength:[((NSNumber *) maxManual) integerValue]];
    }
    
    // Show the toolbar that contains a cancel button.
    [scanditSDKBarcodePicker.overlayController showToolBar:YES];
    
    // Show the bar for manual entry of a barcode.
    [scanditSDKBarcodePicker.overlayController showSearchBar:YES];
	
    // Set this class as the delegate for the overlay controller. It will now receive events when
    // a barcode was successfully scanned, manually entered or the cancel button was pressed.
	scanditSDKBarcodePicker.overlayController.delegate = self;
    
	// present the barcode picker modally and start scanning
    [self.viewController presentModalViewController:scanditSDKBarcodePicker animated:YES];
	[scanditSDKBarcodePicker performSelector:@selector(startScanning) withObject:nil afterDelay:0.1];
    [scanditSDKBarcodePicker release];
}

#pragma mark -
#pragma mark ScanDKOverlayControllerDelegate methods

/**
 * This delegate method of the ScanDKOverlayController protocol needs to be implemented by 
 * every app that uses the ScanDK and this is where the custom application logic goes.
 * In the example below, we are just showing an alert view that asks the user whether he 
 * wants to continue scanning.
 */
- (void)scanditSDKOverlayController:(ScanditSDKOverlayController *)scanditSDKOverlayController1 
                     didScanBarcode:(NSDictionary *)barcodeResult {
	
    if (!wasStatusBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
	
	NSString *symbology = [barcodeResult objectForKey:@"symbology"];
	NSString *barcode = [barcodeResult objectForKey:@"barcode"];
    
    [self.viewController dismissModalViewControllerAnimated:YES];
     
    
    NSString *concat =[NSString stringWithFormat:@"%@|%@", symbology, barcode];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK 
                                                      messageAsString:concat];
    [self writeJavascript:[pluginResult toSuccessCallbackString:self.callbackId]];
    self.hasPendingOperation = NO;
}

/**
 * This delegate method of the ScanDKOverlayController protocol needs to be implemented by 
 * every app that uses the ScanDK and this is where the custom application logic goes.
 * In the example below, we are just showing an alert view that asks the user whether he 
 * wants to continue scanning.
 */
- (void)scanditSDKOverlayController:(ScanditSDKOverlayController *)scanditSDKOverlayController1 
                didCancelWithStatus:(NSDictionary *)status {
	
    if (!wasStatusBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
    
    [self.viewController dismissModalViewControllerAnimated:YES];
    
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK 
                                                messageAsString:@"Canceled"];
    [self writeJavascript:[pluginResult toErrorCallbackString:self.callbackId]];
    self.hasPendingOperation = NO;
}

/**
 * This delegate method of the ScanDKOverlayController protocol needs to be implemented by 
 * every app that uses the ScanDK and this is where the custom application logic goes.
 * In the example below, we are just showing an alert view that asks the user whether he 
 * wants to continue scanning.
 */
- (void)scanditSDKOverlayController:(ScanditSDKOverlayController *)scanditSDKOverlayController 
                    didManualSearch:(NSString *)input {
	
    if (!wasStatusBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
	
    [self.viewController dismissModalViewControllerAnimated:YES];
    
    NSArray *result = [NSArray arrayWithObjects:
                       [@"UNKNOWN" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                       [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], nil];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK 
                                                       messageAsArray:result];
    [self writeJavascript:[pluginResult toSuccessCallbackString:self.callbackId]];
    self.hasPendingOperation = NO;
}



@end
