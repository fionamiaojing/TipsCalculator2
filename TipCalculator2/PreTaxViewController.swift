//
//  ViewController.swift
//  TipCalculator2
//
//  Created by Fiona Miao on 3/5/18.
//  Copyright © 2018 Fiona Miao. All rights reserved.
//

import UIKit

class PreTaxViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var PreTaxTextField: UITextField!
    @IBOutlet weak var NextButton: UIButton!
    
    var preTaxAmount: Double = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //--- add UIToolBar on keyboard and Done button on UIToolBar ---//
        self.addDoneButtonOnNumpad(PreTaxTextField)

        NextButton.isEnabled = false
        PreTaxTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        NextButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func viewTapped() {
        PreTaxTextField.endEditing(true)
        
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

    @IBAction func NextButtonPressed(_ sender: Any) {
        let inputAmount: String = PreTaxTextField.text!
        
        if  (Double(inputAmount) != nil) {
            preTaxAmount = Double(inputAmount)!
            performSegue(withIdentifier: "PreTaxToTax", sender: self)
        } else {
            let alert = UIAlertController(title: "Error", message: "Invalid Input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Input Again", style: .default, handler: { (alert) in
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PreTaxToTax" {
            let destinationVC = segue.destination as! TaxViewController
            destinationVC.PreTaxAmountInput = preTaxAmount

        }
    }
    
}

