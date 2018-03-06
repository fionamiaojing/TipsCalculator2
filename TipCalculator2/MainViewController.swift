//
//  MainViewController.swift
//  TipCalculator2
//
//  Created by Fiona Miao on 3/5/18.
//  Copyright © 2018 Fiona Miao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var preTaxField: UITextField!
    @IBOutlet weak var taxField: UITextField!
    @IBOutlet weak var postTaxField: UITextField!
    @IBOutlet weak var splitByPeopleField: UITextField!
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var preTaxAmountInput: Double = 0.00
    var taxAmountInput: Double = 0.00
    var postTaxAmount: Double = 0.00
    var splitPersonInput: Double = 1
    var selectedTip: Double = 0
    var tips: Double = 0.00
    var total: Double = 0.00
    
    let defaults = UserDefaults.standard
    
    var tipArray: [Double] = [0, 1, 5, 10]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load previous stored data
        updateTextFieldForInputs()
        updatePostTax()
        
        selectedTip = defaults.double(forKey: "defaultTip")
        updateTipsPerc()
        
        self.addDoneButtonOnNumpad(preTaxField)
        self.addDoneButtonOnNumpad(taxField)
        self.addDoneButtonOnNumpad(splitByPeopleField)
        
        preTaxField.delegate = self
        taxField.delegate = self
        splitByPeopleField.delegate = self
        
    }
    
    func addDoneButtonOnNumpad(_ textField: UITextField) {
        
        let keypadToolbar: UIToolbar = UIToolbar()
        
        // add a done button to the numberpad
        keypadToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: textField, action: #selector(UITextField.resignFirstResponder))
        ]
        keypadToolbar.sizeToFit()
        print("executed")
        // add a toolbar with a done button above the number pad
        textField.inputAccessoryView = keypadToolbar
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let inputAmount: String = textField.text!
        if textField == preTaxField {
            if  Double(inputAmount) != nil {
                preTaxAmountInput = Double(inputAmount)!
            } else {
                triggerAlert()
            }
        } else if textField == taxField {
            if  Double(inputAmount) != nil {
                taxAmountInput = Double(inputAmount)!
            } else {
                triggerAlert()
            }
        } else if textField == splitByPeopleField {
            if  Double(inputAmount) != nil {
                splitPersonInput = Double(inputAmount)!
            } else {
                triggerAlert()
            }
        }
        updateTextFieldForInputs()
        updatePostTax()
        calculateTipAndTotal()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    @IBAction func TipButtonPressed(_ sender: UIButton) {
        selectedTip = selectedTip + tipArray[sender.tag - 1]
        updateTipsPerc()
        
    }
    
    
    @IBAction func ResetValueButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        if sender.tag == 1 {
            defaults.set(selectedTip, forKey: "defaultTip")
        } else if sender.tag == 2 {
            selectedTip = 0
            updateTipsPerc()
        }
    }
    
    
    func updateTipsPerc() {
        tipButton.setTitle("\(selectedTip)%", for: .normal)
        calculateTipAndTotal()
    }
    
    func updateTextFieldForInputs() {
        preTaxField.text = String(preTaxAmountInput)
        taxField.text = String(taxAmountInput)
        splitByPeopleField.text = String(splitPersonInput)
    }
    
    func updatePostTax() {
        postTaxAmount = preTaxAmountInput + taxAmountInput
        postTaxField.text = String(postTaxAmount)
    }
    
    func calculateTipAndTotal() {
        
        tips = Double(round(preTaxAmountInput * selectedTip / splitPersonInput) / 100)
        total = Double(round(postTaxAmount / splitPersonInput * 100) / 100) + tips
        tipsLabel.text = " Tips: \(tips)"
        totalLabel.text = " Total: \(total)"
        
    }
    
    func triggerAlert() {
        let alert = UIAlertController(title: "Error", message: "Invalid Input", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Input Again", style: .default, handler: { (alert) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}







