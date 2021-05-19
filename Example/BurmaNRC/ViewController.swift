//
//  ViewController.swift
//  BurmaNRC
//
//  Created by moesteven96@gmail.com on 05/13/2021.
//  Copyright (c) 2021 moesteven96@gmail.com. All rights reserved.
//

import UIKit
import BurmaNRC

class ViewController: UIViewController {
    @IBOutlet weak var txtFieldNRC: UITextField!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lbTranslation: UILabel!
    @IBOutlet weak var lbStates: UILabel!
    @IBOutlet weak var lbDistrict: UILabel!
    @IBOutlet weak var lbCitizen: UILabel!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbInvalidNRC: UILabel!
    @IBOutlet weak var resultView: UIStackView!
    @IBOutlet weak var langSwitch: UISwitch!
    
    var nrcExtractSuccess: Bool = false
    var switchOn: Bool! = false {
        didSet {
            lbStates.text = burmaNRC.getState(switchOn ? .mm : .en)
            lbDistrict.text = burmaNRC.getDistrict(switchOn ? .mm : .en)
            lbCitizen.text = burmaNRC.getCitizen(switchOn ? .mm : .en)
            lbNumber.text = burmaNRC.getNumber(switchOn ? .mm : .en)
        }
    }
    
    var burmaNRC: BurmaNRC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFieldNRC.delegate = self
        
        btnCheck.layer.cornerRadius = 10
        resultView.isHidden = true
        lbInvalidNRC.isHidden = true
    }

    @IBAction func btnCheck(_ sender: Any) {
        if txtFieldNRC.text?.count == 0 { return }
        
        burmaNRC = BurmaNRC(txtFieldNRC.text!)
        
        do {
            try burmaNRC.extractNRC()
            nrcExtractSuccess = true
            lbInvalidNRC.isHidden = true
            resultView.isHidden = false
            langSwitch.setOn(burmaNRC.getLocale() == .mm, animated: true)
            
            lbTranslation.text = burmaNRC.translate()
            lbStates.text = burmaNRC.getState()
            lbDistrict.text = burmaNRC.getDistrict()
            lbCitizen.text = burmaNRC.getCitizen()
            lbNumber.text = burmaNRC.getNumber()
        }catch {
            let err = error as! BurmaNRCError
            lbInvalidNRC.text = err.localizedDescription
            
            nrcExtractSuccess = false
            lbInvalidNRC.isHidden = false
            resultView.isHidden = true
        }
    }
    
    @IBAction func langSwitch(_ sender: Any) {
        if !nrcExtractSuccess { return }
        
        switchOn = langSwitch.isOn
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
}
