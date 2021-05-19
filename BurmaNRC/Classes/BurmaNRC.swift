//
// BurmaNRC.swift
//

import Foundation

public enum BurmaNRCError: Error, Equatable {
    case InvalidNRC
}

extension BurmaNRCError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("Invalid NRC", comment: "")
    }
}

public enum Locale: String {
    case en
    case mm
}

public final class BurmaNRC {
    private var nrc: String!
    private var wholeNrc: String!
    private var state: String!
    private var district: String!
    private var citizen: String!
    private var num: String!
    private var lang: Locale!
    
    public init(_ nrc: String) {
        self.nrc = nrc.replacingOccurrences(of: " ", with: "")
    }
    
    private let TOWNCODE_BURMESE_TO_ENGLISH: [String: String] = [
        "က" : "Ka", "ခ" : "Kha", "ဂ" : "Ga", "ဃ" : "Gha", "င" : "Nga",
        "စ" : "Sa", "ဆ" : "Hsa", "ဇ" : "Za", "ဈ" : "Zha", "ည" : "Nya",
        "ဎ" : "Dd", "ဏ" : "Nha", "တ" : "Ta", "ထ" : "Hta", "ဒ" : "Da",
        "ဓ" : "Dha", "န" : "Na", "ပ" : "Pa", "ဖ" : "Pha", "ဗ" : "Bha",
        "ဘ" : "Ba", "မ" : "Ma", "ယ" : "Ya", "ရ" : "Ra", "လ" : "La",
        "ဝ" : "Wa", "သ" : "Tha", "ဟ" : "Ha", "ဠ" : "Ll", "အ" : "Ah",
        "ဥ" : "U", "ဧ" : "E"
    ]
    
    private let TOWNCODE_ENGLISH_TO_BURMESE: [String: String] = [
        "Ka": "က", "Kha": "ခ", "Ga": "ဂ", "Gha": "ဃ", "Nga": "င",
        "Sa": "စ", "Hsa": "ဆ", "Za": "ဇ", "Zha": "စျ", "Nya": "ည",
        "Dd": "ဎ", "Nha": "ဏ", "Ta": "တ", "Hta": "ထ", "Da": "ဒ",
        "Dha": "ဓ", "Na": "န", "Pa": "ပ", "Pha": "ဖ", "Bha": "ဗ",
        "Ba": "ဘ", "Ma": "မ", "Ya": "ယ", "Ra": "ရ", "La": "လ",
        "Wa": "ဝ", "Tha": "သ", "Ha": "ဟ", "Ll": "ဠ", "Ah": "အ",
        "U": "ဥ", "E": "ဧ"
    ]
    
    private let CITIZEN_BURMESE_TO_ENGLISH: [String: String] = [
        "နိုင်": "N", "ဧည့်": "E", "ပြု": "P"
    ]
    
    private let CITIZEN_ENGLISH_TO_BURMESE: [String: String] = [
        "N": "နိုင်", "E": "ဧည့်", "P": "ပြု",
        "NAING": "နိုင်", "AE": "ဧည့်", "PYU": "ပြု"
    ]
    
    private let BURMESE_NUM = ["၀", "၁", "၂", "၃", "၄", "၅", "၆", "၇", "၈", "၉"]
    
    private let STATES: [[Locale: String]] = [
        [.en: "Kachin", .mm: "ကချင်ပြည်နယ်"],
        [.en: "Kayah", .mm: "ကယားပြည်နယ်"],
        [.en: "Kayin", .mm: "ကရင်ပြည်နယ်"],
        [.en: "Chin", .mm: "ချင်းပြည်နယ်"],
        [ .en: "Sagaing", .mm: "စစ်ကိုင်းတိုင်း"] ,
        [.en: "Tanintharyi", .mm: "တနင်္သာရီတိုင်း"],
        [.en: "Bago", .mm: "ပဲခူးတိုင်း"],
        [.en: "Magway", .mm: "မကွေးတိုင်း"],
        [.en: "Mandalay", .mm: "မန္တလေးတိုင်း"],
        [.en: "Mon", .mm: "မွန်ပြည်နယ်"],
        [.en: "Rakhine", .mm: "ရခိုင်ပြည်နယ်"],
        [.en: "Yangon", .mm: "ရန်ကုန်တိုင်း"],
        [.en: "Shan", .mm: "ရှမ်းပြည်နယ်"],
        [.en: "Ayeyarwaddy", .mm: "ဧရာဝတီတိုင်း"]
    ]
    
    let regexEnglish = try? NSRegularExpression(
      pattern: "^([1][0-4]|[1-9])\\/((?:Ka|Kha|Ga|Gha|Nga|Sa|Hsa|Za|Zha|Nya|Dd|Nha|Ta|Hta|Da|Dha|Na|Pa|Pha|Bha|Ba|Ma|Ya|Ra|La|Wa|Tha|Ha|Ll|Ah|U|E){3})\\(((?:N|E|P|NAING|AE|PYU))\\)([\\d]{6})$",
      options: .caseInsensitive
    )
    
    let regexBurmese = try? NSRegularExpression(
      pattern: "^([၁][၀-၄]|[၁-၉])\\/([ကခဂဃငစဆဇဈညဎဏတထဒဓနပဖဗဘမယရလဝသဟဠဥဧအ]{3})\\(((?:နိုင်|ဧည့်|ပြု))\\)([၀-၉]{6})$",
      options: .caseInsensitive
    )
    
    /// extractNRC() extracts states, districts, citizens and numbers
    /// throws InvalidNRC error if NRC format is wrong
    public func extractNRC() throws {
        if let match = regexEnglish?.firstMatch(in: self.nrc, options: [], range: NSRange(location: 0, length: self.nrc.utf16.count)) {
            self.lang = .en
            extractRegex(match)
        }else if let match = regexBurmese?.firstMatch(in: self.nrc, options: [], range: NSRange(location: 0, length: self.nrc.utf16.count)) {
            self.lang = .mm
            extractRegex(match)
        }else {
            throw BurmaNRCError.InvalidNRC
        }
    }
    
    /// extractRegex(match: NSTextCheckingResult) extracts regular expression matches group
    private func extractRegex(_ match: NSTextCheckingResult) {
        if let matchNRC = Range(match.range(at: 0), in: self.nrc) {
            let wholeNRC = nrc[matchNRC]
            self.wholeNrc = String(wholeNRC)
        }
        
        if let matchState = Range(match.range(at: 1), in: self.nrc) {
            let state = nrc[matchState]
            self.state = String(state)
        }
        
        if let matchDistrict = Range(match.range(at: 2), in: self.nrc) {
            let district = nrc[matchDistrict]
            self.district = String(district)
        }
        
        if let matchCitizen = Range(match.range(at: 3), in: self.nrc) {
            let citizen = nrc[matchCitizen]
            self.citizen = String(citizen)
        }
        
        if let matchNumber = Range(match.range(at: 4), in: self.nrc) {
            let number = nrc[matchNumber]
            self.num = String(number)
        }
    }
    
    /// translate() localize given NRC and return full NRC localized format
    public func translate() -> String {
        if self.state == nil || self.district == nil || self.citizen == nil || self.num == nil {
            return ""
        }
        
        if self.lang == .en {
            return "\(toBurmeseNum(self.state))/\(getDistrict(.mm))(\(getCitizen(.mm)))\(toBurmeseNum(self.num))"
        }
        
        return "\(toEnglishNum(self.state))/\(getDistrict(.en))(\(getCitizen(.en)))\(toEnglishNum(self.num))"
    }
    
    /// getLocale() return given NRC language
    public func getLocale() -> Locale! {
        return self.lang
    }
    
    /// getState() return state in given language
    public func getState(_ locale: Locale? = nil) -> String {
        if self.state == nil {
            return ""
        }
        
        if locale == self.lang || locale == nil {
            return self.lang == .en ? STATES[(Int(self.state) ?? 0) - 1][.en]! : STATES[(Int(toEnglishNum(self.state)) ?? 0) - 1][.mm]!
        }
        
        return locale == .en ? STATES[(Int(toEnglishNum(self.state)) ?? 0) - 1][.en]! : STATES[(Int(self.state) ?? 0) - 1][.mm]!
    }
    
    /// getDistrict() return district in given language
    public func getDistrict(_ locale: Locale? = nil) -> String {
        if self.district == nil {
            return ""
        }
        
        if locale == self.lang || locale == nil {
            return self.district
        }
        
        var _res = ""
        var _temp_district = ""
        var _temp_district_normalized = ""
        if locale == .en {
            self.district.forEach() {
                d in
                _temp_district.append(d)
                if TOWNCODE_BURMESE_TO_ENGLISH[_temp_district] != nil {
                    _res.append(TOWNCODE_BURMESE_TO_ENGLISH[_temp_district]!)
                    _temp_district.removeAll()
                }
            }
        }else {
            self.district.forEach() {
                d in
                _temp_district.append(d)
                _temp_district_normalized = _temp_district.prefix(1).uppercased() + _temp_district.lowercased().dropFirst()
                if TOWNCODE_ENGLISH_TO_BURMESE[_temp_district_normalized] != nil {
                    _res.append(TOWNCODE_ENGLISH_TO_BURMESE[_temp_district_normalized]!)
                    _temp_district.removeAll()
                }
            }
        }
        
        return _res
    }
    
    /// getCitizen() return citizen in given language
    public func getCitizen(_ locale: Locale? = nil) -> String {
        if self.citizen == nil {
            return ""
        }
        
        if locale == self.lang || locale == nil {
            return self.citizen
        }
        
        return locale == .en ? CITIZEN_BURMESE_TO_ENGLISH[self.citizen] ?? "" : CITIZEN_ENGLISH_TO_BURMESE[self.citizen.uppercased()] ?? ""
    }
    
    /// getNumber() return nrc number in given language
    public func getNumber(_ locale: Locale? = nil) -> String {
        if self.num == nil {
            return ""
        }
        
        if locale == self.lang || locale == nil {
            return self.num
        }
        
        return locale == .en ? toEnglishNum(self.num) : toBurmeseNum(self.num)
    }
    
    /// toBurmeseNum() return converted burmese number
    /// this function does not check the input parameter is already burmese or not
    private func toBurmeseNum(_ engNum: String) -> String {
        var _res = ""
        engNum.forEach() {
            s in
            if let index = Int(String(s)) {
                _res += BURMESE_NUM[index]
            }
        }
        
        return _res
    }
    
    /// toEnglishNum() return converted english number
    /// this function does not check the input parameter is already english or not
    private func toEnglishNum(_ burNum: String) -> String {
        var _res = ""
        burNum.forEach() {
            s in
            _res += String(describing: BURMESE_NUM.index(of: String(s))!)
        }
        
        return _res
    }
}
