// Zhuowei Zhang

//  ViewController.swift
//  ZhuoweiZhang_itp342HW3
//
//  Created by Joey on 9/28/18.
//  Copyright © 2018 Joey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var billTitle: UILabel!
    @IBOutlet weak var taxTitle: UILabel!
    @IBOutlet weak var includeTaxForTipTitle: UILabel!
    @IBOutlet weak var tipRateTitle: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var taxAmountLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    
    @IBOutlet weak var tipShowLabel: UILabel!
    @IBOutlet weak var taxShowLabel: UILabel!
    @IBOutlet weak var subtotalShowLabel: UILabel!
    @IBOutlet weak var totalShowLabel: UILabel!
    @IBOutlet weak var totalPerPersonShowLabel: UILabel!
    
    @IBOutlet weak var billAmountInputLabel: UITextField!
    @IBOutlet weak var taxRateInputLabel: UISegmentedControl!
    @IBOutlet weak var includeTaxForTipInputLabel: UISwitch!
    @IBOutlet weak var tipRateInputLabel: UISlider!
    @IBOutlet weak var splitInputLabel: UIStepper!
    @IBOutlet weak var clearButtonLabel: UIButton!
    
    func setDefaultValues() {
        
        
        tipAmount = 0.00;
        taxAmount = 0.00;
        subtotal = 0.00
        total = 0.00
        totalSplit = 0.00
        
        billAmountInput = 0.00
        taxRateInput = 7.5/100
        tipRateInput = 0.15;
        eventSplitNumberInput = 1;
        
        includeTaxForTipTrue = true;
        
        tipShowLabel.text = "$0.00";
//        tipAmountLabel.text = "$0.00";
        taxShowLabel.text = "$0.00";
        subtotalShowLabel.text = "$0.00";
        totalShowLabel.text = "$0.00";
        totalPerPersonShowLabel.text = "$0.00"
        
        tipRateTitle.text = "15%";
        splitNumberLabel.text = "1";
        
        billAmountInputLabel.text = nil;
        tipRateInputLabel.setValue(15, animated: true);
        taxRateInputLabel.selectedSegmentIndex = 0;
        includeTaxForTipInputLabel.isOn = true;
        splitInputLabel.value = 1;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        //tapgesturetest2
        setDefaultValues();
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")));
//        self.view.addGestureRecognizer(gestureRecognizer)
        
        //make settings for variables
        appTitle.accessibilityIdentifier = HW3AccessibilityIdentifiers.tipCalculaterLabel;
        billTitle.accessibilityIdentifier = HW3AccessibilityIdentifiers.billLabel;
        taxTitle.accessibilityIdentifier = HW3AccessibilityIdentifiers.segmentedLabel;
        includeTaxForTipTitle.accessibilityIdentifier = HW3AccessibilityIdentifiers.includeTaxLabel;
        tipRateTitle.accessibilityIdentifier = HW3AccessibilityIdentifiers.sliderLabel;
        eventLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.evenSplitLabel;
        splitNumberLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.splitLabel;
        
        tipAmountLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.tipLabel;
        taxAmountLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.taxLabel;
        subtotalLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.subtotalLabel;
        totalLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.totalWithTipLabel;
        totalPerPersonLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.totalPerPersonLabel;
        
        tipShowLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.tipAmountLabel;
        taxShowLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.taxAmountLabel;
        subtotalShowLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.subtotalAmountLabel;
        totalShowLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.totalWithTipAmountLabel;
        totalPerPersonShowLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.totalPerPersonAmountLabel;
        
        billAmountInputLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.amountTextField;
        taxRateInputLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.segmentedTax;
        includeTaxForTipInputLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.includeTaxSwitch;
        tipRateInputLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.tipSlider;
        splitInputLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.splitStepper;
        clearButtonLabel.accessibilityIdentifier = HW3AccessibilityIdentifiers.resetButton;
        
    }
    
    //global var input
    var billAmountInput: Float? = 0.00;
    var taxRateInput: Float = 0.00;
    
    var includeTaxForTipTrue: Bool = true;
    
    var tipRateInput: Float = 0.15;
    var eventSplitNumberInput: Int = 1;
    
    //global var show
    var tipAmount: Float = 0.00;
    var taxAmount: Float = 7.5/100;
    var subtotal: Float = 0.00;
    var total: Float = 0.00;
    var totalSplit: Float = 0.00;
    
    
    @IBAction func backgroundButtonPushed(_ sender: UIButton) {
        self.view.endEditing(true);
    }
    @IBAction func viewBackgroundButtonPushed(_ sender: UIButton) {
        self.view.endEditing(true);
    }
    

    @IBAction func billInputAction(_ sender: UITextField) {
        billAmountInput = Float(billAmountInputLabel.text!);
        if(billAmountInput == nil){
            billAmountInput = 0.00;
        }
        
        calcPerperson();
    }
    
    @IBAction func taxRateInputAction(_ sender: UISegmentedControl) {
        taxRateInput = (Float(sender.selectedSegmentIndex)*0.5 + 7.5)/100;
        
        calcPerperson();
    }
    
    @IBAction func includeTaxForTipInputAction(_ sender: UISwitch) {
        includeTaxForTipTrue = sender.isOn;
        
        calcPerperson();
    }
    
    @IBAction func changeTipRateAction(_ sender: UISlider) {
        tipRateInput = round(sender.value)/100;
        let showTipRateTemp = Int(tipRateInput * 100);
        tipRateTitle.text = "\(showTipRateTemp)%";
        
        calcPerperson();
    }
    
    
    @IBAction func eventSplitChangeAction(_ sender: UIStepper) {
        eventSplitNumberInput = Int(sender.value);
        splitNumberLabel.text = "\(eventSplitNumberInput)";
        
        calcPerperson();
    }
    
    @IBAction func clearAllButtonPushed(_ sender: UIButton) {
        setDefaultValues();
    }
    
    //Helper functions
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true);
        }
    }
    func calcTax() {
        taxAmount = taxRateInput * billAmountInput!
        taxShowLabel.text = "$\(String(format: "%.2f", taxAmount))";
    }
    func calcTip() {
        if(includeTaxForTipTrue) {
            calcTax();
            tipAmount = (billAmountInput! + taxAmount) * tipRateInput;
        }else {
            tipAmount = billAmountInput! * tipRateInput;
        }
        tipShowLabel.text = "$\(String(format: "%.2f", tipAmount))";
    }
    func calcSubtotal() {
        calcTax();
        subtotal = taxAmount + billAmountInput!;
        subtotalShowLabel.text = "$\(String(format: "%.2f", subtotal))";
    }
    func calcTotal() {
        calcSubtotal()
        calcTip();
        
        total = subtotal + tipAmount;
        totalShowLabel.text = "$\(String(format: "%.2f", total))"
    }
    func calcPerperson() {
        calcTotal()
        totalSplit = total/Float(eventSplitNumberInput);
        totalPerPersonShowLabel.text = "$\(String(format: "%.2f", totalSplit))"
    }
}

