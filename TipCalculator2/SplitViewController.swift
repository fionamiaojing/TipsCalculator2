//
//  SplitViewController.swift
//  TipCalculator2
//
//  Created by Fiona Miao on 3/5/18.
//  Copyright © 2018 Fiona Miao. All rights reserved.
//

import UIKit

class SplitViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var splitPicker: UIPickerView!
    @IBOutlet weak var NextButton: UIButton!
    
    var preTaxAmountInput: Double = 0.00
    var taxAmountInput: Double = 0.00
    var splitPerson: Double = 1
    
    var numberOfPeople: [Double] = [1,2,3,4,5,6,7,8,9,10]

    override func viewDidLoad() {
        super.viewDidLoad()
        splitPicker.delegate = self
        
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfPeople.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(numberOfPeople[row])
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Georgia", size: 30.0)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = String(numberOfPeople[row])
        pickerLabel?.textColor = UIColor.white
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        splitPerson = numberOfPeople[row]
    }
    
    @IBAction func NextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "SplitToMain", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SplitToMain" {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.preTaxAmountInput = preTaxAmountInput
            destinationVC.taxAmountInput = taxAmountInput
            destinationVC.splitPersonInput = splitPerson

        }
        
        
    }
    
    
    
}
