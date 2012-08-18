/**
 * Available options:
 * 
 * exampleStringForOption: defaultValue
 * Short explanation of option.
 *
 * 1DScanning: true
 * Enables or disables the recognition of 1D codes.
 *
 * 2DScanning: true
 * Enables or disables the recognition of 2D codes.
 *
 * scanningHotspot: "0.5/0.5" (x/y)
 * Changes the location of the spot where the recognition actively scans for barcodes. X and y can
 * be between 0 and 1, where 0/0 is the top left corner and 1/1 the bottom right corner.
 *
 * beep: true
 * Enables or disables the sound played when a code was recognized.
 *
 * vibrate: true
 * Enables or disables the vibration when a code was recognized.
 *
 * showMostLikelyUIBarcodeElement: true
 * Enables or disables the lucky shot option if the barcode was not definitely recognized.
 *
 * uiFont: "Helvetica"
 * Sets the font of all text displayed in the UI (must be known by iOS).
 * 
 * textForMostLikelyBarcodeUIElement: "Tap to use"
 * Sets the text that will be displayed alongside the lucky shot to tell the user what to do, to
 * use the displayed barcode.
 * 
 * textForInitialScanScreen: "Align code with box"
 * Sets the text that will be displayed above the viewfinder to tell the user to align it with the
 * barcode that should be recognized.
 *
 * textForBarcodePresenceDetected: "Align code and hold still"
 * Sets the text that will be displayed above the viewfinder to tell the user to align it with the 
 * barcode and hold still because a potential code seems to be on the screen.
 *
 * textForBarcodeDecodingInProgress: "Decoding ..."
 * Sets the text that will be displayed above the viewfinder to tell the user to hold still because
 * a barcode is aligned with the box and the recognition is trying to recognize it.
 * 
 * searchBarActionButtonCaption: "Go"
 * Sets the caption of the manual entry at the top when a barcode of valid length has been entered.
 *
 * searchBarCancelButtonCaption: "Cancel"
 * Sets the caption of the manual entry at the top when no barcode of valid length has been entered.
 * 
 * searchBarPlaceholderText: "Scan barcode or enter it here"
 * Sets the text shown in the manual entry field when nothing has been entered yet.
 * 
 * toolBarButtonCaption: "Cancel"
 * Sets the caption of the toolbar button.
 *
 * viewfinderColor: "FFFFFF"
 * Sets the color of the static viewfinder and while tracking before the code has been recognized.
 * 
 * viewfinderDecodedColor: "00FF00"
 * Sets the color of the viewfinder when the code has been recognized.
 * 
 * minSearchBarBarcodeLength: 8
 * Sets the minimum size a barcode in the manual entry field has to have to possibly be valid.
 * 
 * maxSearchBarBarcodeLength: 100
 * Sets the maximum size a barcode in the manual entry field can have to possibly be valid.
 *
 * automaticShutDown: 0
 * Sets the amount of seconds after which the scanner automatically shuts down and calls the fail
 * method. 0 means it will never shut down on its own.
 */
var ScanditSDK = {
    nativeFunction: function(success, fail, appKey, options) {
        if (options == null) {
            options = [];
        }
alert("good");
        return PhoneGap.exec(success, fail, "ScanditSDK", "scan", [appKey, options]);
    }
}
