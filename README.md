# 1. BurmaNRC

[![CI Status](https://img.shields.io/travis/moesteven96@gmail.com/BurmaNRC.svg?style=flat)](https://travis-ci.org/moesteven96@gmail.com/BurmaNRC)
[![Version](https://img.shields.io/cocoapods/v/BurmaNRC.svg?style=flat)](https://cocoapods.org/pods/BurmaNRC)
[![License](https://img.shields.io/cocoapods/l/BurmaNRC.svg?style=flat)](https://cocoapods.org/pods/BurmaNRC)
[![Platform](https://img.shields.io/cocoapods/p/BurmaNRC.svg?style=flat)](https://cocoapods.org/pods/BurmaNRC)

## 1.1. Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 1.2. Requirements

BurmaNRC is written in Swift 5.0+. Compatible with iOS 9.3+.

## 1.3. Installation

BurmaNRC is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BurmaNRC'
```

## 1.4. Usage

### Initializate NRC
Need to use `extractNRC()` after BurmaNRC is initialized.

### Get Translation
Get translation localize give nrc language format
```swift
burmaNRC = BurmaNRC("12/LaThaNa(N)093213")
do {
    try burmaNRC.extractNRC()
    burmaNRC.translate() // ၁၂/လသန(နိုင်)၀၉၃၂၁၃
}catch {
    let err = error as! BurmaNRCError
    print(err.localizedDescription)
}
```

### Get Locale
Get locale returns given NRC language in `Locale`
```swift
burmaNRC = BurmaNRC("၁၂/လသန(နိုင်)၀၉၃၂၁၃")
do {
    try burmaNRC.extractNRC()
    burmaNRC.getLocale() // .mm
}catch {
    let err = error as! BurmaNRCError
    print(err.localizedDescription)
}
```

### Get State, District, Citizen & Number
`getState()` `getDistrict()` `getCitizen()` `getNumber()` return with current Nrc language format
```swift
burmaNRC = BurmaNRC("12/LaThaNa(N)093213") 
// 12/LaThaNa(NAING)093213
// 12/LATHANA(Naing)093213
do {
    try burmaNRC.extractNRC()
    burmaNRC.getState() // Yangon
    burmaNRC.getState(.en) // Yangon
    burmaNRC.getState(.mm) // ရန်ကုန်တိုင်း
    
    burmaNRC.getDistrict() // LaThaNa // LATHANA
    burmaNRC.getDistrict(.en) // LaThaNa
    burmaNRC.getDistrict(.mm) // လသန
    
    burmaNRC.getCitizen() // N  // NAING
    burmaNRC.getCitizen(.en) // N
    burmaNRC.getCitizen(.mm) // နိုင်
    
    burmaNRC.getNumber() // 093213
    burmaNRC.getNumber(.en) // 093213
    burmaNRC.getNumber(.mm) // ၀၉၃၂၁၃
}catch {
    let err = error as! BurmaNRCError
    print(err.localizedDescription)
}
```

## 1.5. Author

moesteven96@gmail.com

## 1.6. License

BurmaNRC is available under the MIT license. See the LICENSE file for more info.
