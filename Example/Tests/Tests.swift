import XCTest
@testable import BurmaNRC

class Tests: XCTestCase {
    
    var burmaNRC: BurmaNRC!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBurmeseNrcCheckWithoutExtract() {
        burmaNRC = BurmaNRC("၁၂/လသန(နိုင်)၁၃၂၇၄၉")
        
        // Test getState()
        XCTAssertEqual(burmaNRC.getState(), "")
        XCTAssertEqual(burmaNRC.getState(.mm), "")
        XCTAssertEqual(burmaNRC.getState(.en), "")
        
        // Test getDistrict()
        XCTAssertEqual(burmaNRC.getDistrict(), "")
        XCTAssertEqual(burmaNRC.getDistrict(.mm), "")
        XCTAssertEqual(burmaNRC.getDistrict(.en), "")
        
        // Test getCitizen()
        XCTAssertEqual(burmaNRC.getCitizen(), "")
        XCTAssertEqual(burmaNRC.getCitizen(.mm), "")
        XCTAssertEqual(burmaNRC.getCitizen(.en), "")
        
        // Test getNumber()
        XCTAssertEqual(burmaNRC.getNumber(), "")
        XCTAssertEqual(burmaNRC.getNumber(.mm), "")
        XCTAssertEqual(burmaNRC.getNumber(.en), "")
    }
    
    func testEnglishNrcCheckWithoutExtract() {
        burmaNRC = BurmaNRC("၁၂/လသန(နိုင်)၁၃၂၇၄၉")
        
        // Test getState()
        XCTAssertEqual(burmaNRC.getState(), "")
        XCTAssertEqual(burmaNRC.getState(.mm), "")
        XCTAssertEqual(burmaNRC.getState(.en), "")
        
        // Test getDistrict()
        XCTAssertEqual(burmaNRC.getDistrict(), "")
        XCTAssertEqual(burmaNRC.getDistrict(.mm), "")
        XCTAssertEqual(burmaNRC.getDistrict(.en), "")
        
        // Test getCitizen()
        XCTAssertEqual(burmaNRC.getCitizen(), "")
        XCTAssertEqual(burmaNRC.getCitizen(.mm), "")
        XCTAssertEqual(burmaNRC.getCitizen(.en), "")
        
        // Test getNumber()
        XCTAssertEqual(burmaNRC.getNumber(), "")
        XCTAssertEqual(burmaNRC.getNumber(.mm), "")
        XCTAssertEqual(burmaNRC.getNumber(.en), "")
    }
    
    func testBurmeseNrcTranslation() {
        burmaNRC = BurmaNRC("၁၂/လသန(နိုင်)၁၃၂၇၄၉")
        
        // Translation empty without nrc extract
        XCTAssertEqual(burmaNRC.translate(), "")
        
        // Translation Success after nrc extract
        XCTAssertNoThrow(try burmaNRC.extractNRC())
        XCTAssertEqual(burmaNRC.translate(), "12/LaThaNa(N)132749")
    }
    
    func testEnglishNrcTranslation() {
        burmaNRC = BurmaNRC("12/LaThaNa(N)132749")
        
        // Translation empty without nrc extract
        XCTAssertEqual(burmaNRC.translate(), "")
        
        // Translation Success after nrc extract
        XCTAssertNoThrow(try burmaNRC.extractNRC())
        XCTAssertEqual(burmaNRC.translate(), "၁၂/လသန(နိုင်)၁၃၂၇၄၉")
    }
    
    func testEnglishNrcGetLocale() {
        burmaNRC = BurmaNRC("12/LaThaNa(N)132749")
        XCTAssertNil(burmaNRC.getLocale())
        
        XCTAssertNoThrow(try burmaNRC.extractNRC())
        XCTAssertEqual(burmaNRC.getLocale(), .en)
    }
    
    func testBurmeseNrcGetLocale() {
        burmaNRC = BurmaNRC("၁၂/လသန(နိုင်)၁၃၂၇၄၉")
        XCTAssertNil(burmaNRC.getLocale())
        
        XCTAssertNoThrow(try burmaNRC.extractNRC())
        XCTAssertEqual(burmaNRC.getLocale(), .mm)
    }
    
    func testBurmeseNrcCheckSuccess() {
        burmaNRC = BurmaNRC("၁၂/လသန(နိုင်)၁၃၂၇၄၉")
        XCTAssertNoThrow(try burmaNRC.extractNRC())
        
        // Test getState()
        XCTAssertEqual(burmaNRC.getState(), "ရန်ကုန်တိုင်း")
        XCTAssertEqual(burmaNRC.getState(.mm), "ရန်ကုန်တိုင်း")
        XCTAssertEqual(burmaNRC.getState(.en), "Yangon")
        
        // Test getDistrict()
        XCTAssertEqual(burmaNRC.getDistrict(), "လသန")
        XCTAssertEqual(burmaNRC.getDistrict(.mm), "လသန")
        XCTAssertEqual(burmaNRC.getDistrict(.en), "LaThaNa")
        
        // Test getCitizen()
        XCTAssertEqual(burmaNRC.getCitizen(), "နိုင်")
        XCTAssertEqual(burmaNRC.getCitizen(.mm), "နိုင်")
        XCTAssertEqual(burmaNRC.getCitizen(.en), "N")
        
        // Test getNumber()
        XCTAssertEqual(burmaNRC.getNumber(), "၁၃၂၇၄၉")
        XCTAssertEqual(burmaNRC.getNumber(.mm), "၁၃၂၇၄၉")
        XCTAssertEqual(burmaNRC.getNumber(.en), "132749")
    }
    
    func testEnglishNrcCheckSuccess() {
        // Test English NRC with formal district
        burmaNRC = BurmaNRC("12/LaThaNa(N)132749")
        XCTAssertNoThrow(try burmaNRC.extractNRC())
        
        // Test getState()
        XCTAssertEqual(burmaNRC.getState(), "Yangon")
        XCTAssertEqual(burmaNRC.getState(.en), "Yangon")
        XCTAssertEqual(burmaNRC.getState(.mm), "ရန်ကုန်တိုင်း")
        
        // Test getDistrict()
        XCTAssertEqual(burmaNRC.getDistrict(), "LaThaNa")
        XCTAssertEqual(burmaNRC.getDistrict(.en), "LaThaNa")
        XCTAssertEqual(burmaNRC.getDistrict(.mm), "လသန")
        
        // Test getCitizen()
        XCTAssertEqual(burmaNRC.getCitizen(), "N")
        XCTAssertEqual(burmaNRC.getCitizen(.en), "N")
        XCTAssertEqual(burmaNRC.getCitizen(.mm), "နိုင်")
        
        // Test getNumber()
        XCTAssertEqual(burmaNRC.getNumber(), "132749")
        XCTAssertEqual(burmaNRC.getNumber(.en), "132749")
        XCTAssertEqual(burmaNRC.getNumber(.mm), "၁၃၂၇၄၉")
        
        // Test English NRC with capitalized district
        burmaNRC = BurmaNRC("12/ LATHANA (N) 132749")
        XCTAssertNoThrow(try burmaNRC.extractNRC())
        
        // Test getDistrict()
        XCTAssertEqual(burmaNRC.getDistrict(), "LATHANA")
        XCTAssertEqual(burmaNRC.getDistrict(.en), "LATHANA")
        XCTAssertEqual(burmaNRC.getDistrict(.mm), "လသန")
        
        // Test English NRC with alternative citizen
        burmaNRC = BurmaNRC("12/LaThaNa(NAING)132749")
        XCTAssertNoThrow(try burmaNRC.extractNRC())
        
        XCTAssertEqual(burmaNRC.getCitizen(), "NAING")
        XCTAssertEqual(burmaNRC.getCitizen(.en), "NAING")
        XCTAssertEqual(burmaNRC.getCitizen(.mm), "နိုင်")
        
        burmaNRC = BurmaNRC("12/LaThaNa(Naing)132749")
        XCTAssertNoThrow(try burmaNRC.extractNRC())
        
        XCTAssertEqual(burmaNRC.getCitizen(), "Naing")
        XCTAssertEqual(burmaNRC.getCitizen(.en), "Naing")
        XCTAssertEqual(burmaNRC.getCitizen(.mm), "နိုင်")
    }
    
    func testEnglishNrcExtractFail() {
        //Fail State
        burmaNRC = BurmaNRC("0/LATHANA(N)983214")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        burmaNRC = BurmaNRC("15/LATHANA(N)983214")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        burmaNRC = BurmaNRC("21/LATHANA(N)983214")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        //Fail District
        burmaNRC = BurmaNRC("12/LATANALA(N)983213")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        //Fail Citizen
        burmaNRC = BurmaNRC("12/LATHANA(B)983214")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        //Fail NRC Num
        burmaNRC = BurmaNRC("12/LATHANA(N)9832")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        burmaNRC = BurmaNRC("12/LATHANA(N)98321234")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
    }
    
    func testBurmeseNrcExtractFail() {
        //Fail State
        burmaNRC = BurmaNRC("၀/လသန(နိုင်)၉၈၃၂၁၄")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        burmaNRC = BurmaNRC("၁၅/လသန(နိုင်)၉၈၃၂၁၄")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        burmaNRC = BurmaNRC("၂၁/လသန(နိုင်)၉၈၃၂၁၄")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        //Fail District
        burmaNRC = BurmaNRC("၁၂/လသနလ(နိုင်)၉၈၄၂၁၃")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        //Fail Citizen
        burmaNRC = BurmaNRC("၁၂/လသန(အ)၉၈၃၂၁၄")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        //Fail NRC Num
        burmaNRC = BurmaNRC("၁၂/လသန(နိုင်)၉၈၃၂")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
        
        burmaNRC = BurmaNRC("၁၂/လသန(နိုင်)၉၈၃၂၉၈၃၂")
        XCTAssertThrowsError(try burmaNRC.extractNRC()){ error in
            XCTAssertEqual(error as! BurmaNRCError, BurmaNRCError.InvalidNRC)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
