// namespace for all things Moral Compass
MCApp = {};

MCApp.isDebug = function(){return true};

MCApp.getUrlForAPI = function(){
    return "http://127.0.0.1/";
}

MCApp.currentBarcode = false;

/**
 *  Scans a barcode and calls a handler.
 *  
 *  void -> void
 */
MCApp.scanBarcode = function(){
   MCApp.scanBarcodeWithScandit();
}

MCApp.getCurrentBarcode = function(){
    return MCApp.currentBarcode;
}

MCApp.scanBarcodeWithScandit = function(){
     ScanditSDK.nativeFunction(MCApp.scanBarcodeSuccessScandit,
                              MCApp.scanBarcodeFailScandit,
                              "nIGuaOlnEeGXNUEZL6NnwOyanGE2nEdWOtIrkDGfuVs", {
                                          "beep": true, 
                                          "1DScanning" : true, 
                                          "2DScanning" : true, 
                                          "scanningHotspot" : "0.5/0.5", 
                                          "vibrate" : true, 
                                          "showMostLikelyBarcodeUIElement" : false,
                                          "textForMostLikelyBarcodeUIElement" : "Most likely barcode",
                                          "textForInitialScanScreenState" : "Align code with box",
                                          "textForBarcodePresenceDetected" : "Align code and hold still",
                                          "textForBarcodeDecodingInProgress" : "Decoding",
                                          "searchBarActionButtonCaption" : "Go",
                                          "searchBarCancelButtonCaption" : "Cancel",
                                          "searchBarPlaceholderText" : "Scan barcode or enter it here",
                                          "toolBarButtonCaption" : "Cancel",
                                          "viewfinderColor" : "FFFFFF",
                                          "viewfinderDecodedColor" : "00FF00",
                                          "minSearchBarBarcodeLength" : 8,
                                          "maxSearchBarBarcodeLength" : 15
                                          });
}

/**
 *  Function to handle barcode scanning success.
 *  
 *  void -> 
 */
MCApp.scanBarcodeSuccessScandit = function(concatResult){
    var resultArray = concatResult.split("|"); 
    MCApp.currentBarcode = resultArray[1];
}

/**
 *  Function to handle barcode scanning failure.
 *  
 *  void -> false
 */
MCApp.scanBarcodeFailScandit = function(){
    MCApp.currentBarcode = false;
}

/**
 *  Produces a company name from a barcode result.
 *  
 *  string -> string
 */
MCApp.getCompanyNameFromBarcode = function(barcodeStr){
    var result = MCApp.getCompanyNameFromBarcodeLocal(barcodeStr);
    
    if(result == "unknown"){
        result = MCApp.getCompanyNameFromBarcodeRemote(barcodeStr);
    }
    
    return result;
}

/**
 *  Produces a locally-stored company name or "unknown"
 *  
 *  string -> string
 */
MCApp.getCompanyNameFromBarcodeLocal = function(barcodeStr){
    var code = $.trim(barcodeStr);
    if(code == "065633506657") return "Nature Valley";
    else return "unknown";
}

/**
 *  Produces a company name from an external database, or "unknown"
 *  
 *  string -> string
 */
MCApp.getCompanyNameFromBarcodeRemote = function(barcodeStr){
    return "unknown";
}

/**
 *  Fetches company beliefs from the server.
 *  
 *  string -> array(<MCStance>)
 */
MCApp.getCompanyBeliefsFromServer = function(companyName){
    throw "unimplemented";
}

/**
 *  A dictionary for beliefs.
 * 
 */
MCBeliefDictionary = {};
MCBeliefDictionary.beliefArray = [  "healthy living",
                                    "planet earth",
                                    "gay marriage",
                                    "animal rights",
                                    "fair trade"];
MCBeliefDictionary.getBeliefForId = function(idx){
    if(idx < 0 || idx >= MCBeliefDictionary.beliefArray.length) return "unknown";
    return MCBeliefDictionary.beliefArray[idx];
}
MCBeliefDictionary.getNumBeliefs = function(){
    return MCBeliefDictionary.beliefArray.length;
}

/**
 *  A stance on an issue.
 */
MCStance = {};
MCStance.yes = function(){
    return 0;
}
MCStance.no = function(){
    return 1;
}
MCStance.donotcare = function(){
    return 2;
}

/**
 *  Container for belief array
 * 
 */
MCBeliefs = function(){
    this.arrayOfBeliefs = [];
    this.init();
    this.saveKey = "MC_Stances";
    this.isLoaded = false;
    
    this.init();
}

/**
 *  Initialize to "do not care" for all issues.
 * 
 *  void -> void
 */
MCBeliefs.prototype.init = function(){
    for(var i=0; i<MCBeliefDictionary.getNumBeliefs(); i++){
        // sets everything to do not care
        this.arrayOfBeliefs[i] = MCStance.donotcare();
    }
}

/**
 *  Validates whether an index is valid.
 *  
 *  int -> boolean
 */
MCBeliefs.prototype.isIssueIdxValid = function(idx){
    return idx >= 0 && idx < MCBeliefDictionary.getNumBeliefs();
}

/**
 *  Validates whether a stance is valid.
 *  
 *  MCStance -> boolean
 */
MCBeliefs.prototype.isStanceValid = function(stance){
    return stance == MCStance.yes() || stance == MCStance.no() || stance == MCStance.donotcare();
}

/**
 *  Sets a stance to an issue index.
 *  
 *  uint MCStance -> boolean
 */
MCBeliefs.prototype.setStance = function(issueIdx, stance){
    if(!this.isIssueIdxValid(issueIdx)) return false;
    if(!this.isStanceValid(stance)) return false;
    
    this.arrayOfBeliefs[issueIdx] = stance;
    return true;
}

/**
 *  Has anything ever been saved?
 * 
 *  void -> boolean
 */
MCBeliefs.prototype.isFirstTimeSave = function(){
    return window.localStorage.getItem(this.saveKey) == null;
}

/**
 *  Save belief stances to local storage.
 *  
 *  If hasn't been loaded yet, fail to prevent writing blanks over stored data.
 *  
 *  void -> boolean
 */
MCBeliefs.prototype.save = function(){
    if(!this.isLoaded) return false;
    window.localStorage.setItem(this.saveKey, JSON.stringify(this.getStances()));
    return true;
}

/**
 *  Produces the currently stored array of stances.
 *  
 *  void -> array(<MCStance>)
 */
MCBeliefs.prototype.getStances = function(){
    return this.arrayOfBeliefs;
}

/**
 *  Get a stance at an index.
 *  
 *  uint -> MCStance or false
 */
MCBeliefs.prototype.getStanceAtIdx = function(idx){
    if(!this.isIssueIdxValid(idx)) return false;
    return this.arrayOfBeliefs[idx];
}

/**
 *  Load belief stances from local storage.
 *  
 *  If nothing has been saved initially, save stuff.
 * 
 *  void -> boolean
 */
MCBeliefs.prototype.load = function(){
    this.isLoaded = true;
    if(this.isFirstTimeSave()) this.save();
    this.arrayOfBeliefs = JSON.parse(window.localStorage.getItem(this.saveKey));
    return true;
}

/**
 *  Produces the percent the stances agree with the company stances.
 * 
 *  array(<MCStance>) -> number
 */
MCBeliefs.prototype.getNumAgreeToArrayOfCompanyStances = function(stancesArray){
    if(stancesArray.length < this.getStances().length){
        if(MCApp.isDebug()) alert("error: size of array from server smaller than local array");
        return false;
    }
    
    var sumMatch = 0;
    
    for(var i=0; i<this.arrayOfBeliefs.length; i++){
        if(this.arrayOfBeliefs[i] == stancesArray[i] &&
           this.arrayOfBeliefs[i] != MCStance.donotcare() &&
           stancesArray[i] != MCStance.donotcare()){
            sumMatch ++;
        }
    }
    
    return sumMatch;
}

/**
 *  Produces the string representation of the array of stances.
 * 
 *  void -> string
 */
MCBeliefs.prototype.toString = function(){
    return JSON.stringify(this.arrayOfBeliefs);
}

/**
 *  Test data generator.
 */
MCTest = function(){
    
}

/**
 *  Produces deterministic test stances from a barcode
 * 
 *  barcode -> array(<MCStance>)
 */
MCTest.prototype.getTestStancesFromBarcode = function(barcode){
    var size = MCBeliefDictionary.getNumBeliefs();
    var numCode = parseInt(barcode);
    var toyData = [];
    
    for(var i=0; i<size; i++){
        toyData[i] = Math.floor(numCode/(i+1)) % 3;
    }
    
    return toyData;
}