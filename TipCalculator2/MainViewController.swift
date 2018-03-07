//
//  MainViewController.swift
//  TipCalculator2
//
//  Created by Fiona Miao on 3/5/18.
//  Copyright © 2018 Fiona Miao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var preTaxField: UITextField!
    @IBOutlet weak var taxField: UITextField!
    @IBOutlet weak var postTaxField: UITextField!
    @IBOutlet weak var splitByPeopleField: UITextField!
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var tipsPerPersonLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var tipsForAllLAbel: UILabel!
    @IBOutlet weak var totalForAllLabel: UILabel!
    
    
    //MARK: Declare vatiable
    var preTaxAmountInput: Double = 0.00
    var taxAmountInput: Double = 0.00
    var postTaxAmount: Double = 0.00
    var splitPersonInput: Double = 1
    var selectedTip: Double = 0
    var tipsPerPerson: Double = 0.00
    var totalPerPerson: Double = 0.00
    var tipsForAll: Double = 0.00
    var totalForAll: Double = 0.00
    
    let defaults = UserDefaults.standard
    
    var tipArray: [Double] = [0, 1, 5, 10]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load previous stored data
        updateTextFieldForInputs()
        updatePostTax()
        postTaxField.isEnabled = false
        
        selectedTip = defaults.double(forKey: "defaultTip")
        updateTipsPerc()
        
        self.addDoneButtonOnNumpad(preTaxField)
        self.addDoneButtonOnNumpad(taxField)
        self.addDoneButtonOnNumpad(splitByPeopleField)
        
        preTaxField.delegate = self
        taxField.delegate = self
        splitByPeopleField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        view.addGestureRecognizer(tapGesture)

    }
    
    //MARK: Add DoneBar
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
    
    //MARK: Declare TextField Function
    @objc func mainViewTapped() {
        preTaxField.endEditing(true)
        taxField.endEditing(true)
        splitByPeopleField.endEditing(true)
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
    
    func triggerAlert() {
        let alert = UIAlertController(title: "Error", message: "Invalid Input", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Input Again", style: .default, handler: { (alert) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: TipButton / Default Button / Reset Button Pressed
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
    
    
    //MARK: Update Tips / Inputs / Output
    func updateTipsPerc() {
        tipButton.setTitle("\(selectedTip)%", for: .normal)
        calculateTipAndTotal()
    }
    
    func updateTextFieldForInputs() {
        
        preTaxField.text = String(preTaxAmountInput)
        taxField.text = String(taxAmountInput)
        splitByPeopleField.text = String(round(splitPersonInput))
        
    }
    
    func updatePostTax() {
        postTaxAmount = preTaxAmountInput + taxAmountInput
        postTaxField.text = String(postTaxAmount)
    }
    
    func calculateTipAndTotal() {
        tipsForAll = Double(round(preTaxAmountInput * selectedTip) / 100)
        tipsPerPerson = Double(round(tipsForAll / splitPersonInput * 100) / 100)
        totalPerPerson = Double(round(postTaxAmount / splitPersonInput * 100) / 100) + tipsPerPerson
        totalForAll = Double(postTaxAmount + tipsForAll)
        tipsPerPersonLabel.text = " Tips Per Person: \(tipsPerPerson)"
        totalPerPersonLabel.text = " Total Per Person: \(totalPerPerson)"
        tipsForAllLAbel.text = " Tips For All: \(tipsForAll)"
        totalForAllLabel.text = " Total For All: \(totalForAll)"
        
    }
    
    
    //MARK: Return to RootPage
    @IBAction func returnBarPressed(_ sender: UIBarButtonItem) {
        guard navigationController?.popToRootViewController(animated: true) != nil
            else {
                print("error")
                return
        }
    }
    
    
}







