//

//  HW3SanityTest.swift
//  HW3
//
//  Created by Harrison Weinerman on 8/24/18.
//  Copyright © 2018 Harrison Weinerman. All rights reserved.
//

import XCTest

class HW3SanityTest: XCTestCase {
    
    private let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        XCUIApplication().launch()
    }
    
    /// This test should pass regardless of how you configured your app; should have all these components
    func testBasicUIElements() {
        // UI components that you can interact with
        let amountTextField = app.textFields[HW3AccessibilityIdentifiers.amountTextField]
        let segmentedTax = app.segmentedControls[HW3AccessibilityIdentifiers.segmentedTax]
        let includeTaxSwitch = app.switches[HW3AccessibilityIdentifiers.includeTaxSwitch]
        let tipSlider = app.sliders[HW3AccessibilityIdentifiers.tipSlider]
        let splitStepper = app.steppers[HW3AccessibilityIdentifiers.splitStepper]
        let resetButton = app.buttons[HW3AccessibilityIdentifiers.resetButton]

        // Dynamic labels
        let taxAmountLabel = app.staticTexts[HW3AccessibilityIdentifiers.taxAmountLabel]
        let subtotalAmountLabel = app.staticTexts[HW3AccessibilityIdentifiers.subtotalAmountLabel]
        let tipAmountLabel = app.staticTexts[HW3AccessibilityIdentifiers.tipAmountLabel]
        let totalWithTipAmountLabel = app.staticTexts[HW3AccessibilityIdentifiers.totalWithTipAmountLabel]
        let totalPerPersonAmountLabel = app.staticTexts[HW3AccessibilityIdentifiers.totalPerPersonAmountLabel]
        let sliderLabel = app.staticTexts[HW3AccessibilityIdentifiers.sliderLabel]
        let splitLabel = app.staticTexts[HW3AccessibilityIdentifiers.splitLabel]
 
        // Static labels
        let tipCalculaterLabel = app.staticTexts[HW3AccessibilityIdentifiers.tipCalculaterLabel]
        let billLabel = app.staticTexts[HW3AccessibilityIdentifiers.billLabel]
        let segmentedLabel = app.staticTexts[HW3AccessibilityIdentifiers.segmentedLabel]
        let includeTaxLabel = app.staticTexts[HW3AccessibilityIdentifiers.includeTaxLabel]
        let evenSplitLabel = app.staticTexts[HW3AccessibilityIdentifiers.evenSplitLabel]
        let taxLabel = app.staticTexts[HW3AccessibilityIdentifiers.taxLabel]
        let subtotalLabel = app.staticTexts[HW3AccessibilityIdentifiers.subtotalLabel]
        let tipLabel = app.staticTexts[HW3AccessibilityIdentifiers.tipLabel]
        let totalWithTipLabel = app.staticTexts[HW3AccessibilityIdentifiers.totalWithTipLabel]
        let totalPerPersonLabel = app.staticTexts[HW3AccessibilityIdentifiers.totalPerPersonLabel]
        
        // Ensure these elements exist
        [amountTextField,
         segmentedTax,
         includeTaxSwitch,
         tipSlider,
         splitStepper,
         taxAmountLabel,
         subtotalAmountLabel,
         tipAmountLabel,
         totalWithTipAmountLabel,
         totalPerPersonAmountLabel,
         sliderLabel,
         splitLabel,
         tipCalculaterLabel,
         billLabel,
         segmentedLabel,
         includeTaxLabel,
         evenSplitLabel,
         taxLabel,
         subtotalLabel,
         tipLabel,
         totalWithTipLabel,
         totalPerPersonLabel,
         resetButton].forEach({ XCTAssert($0.exists) })
    }
    
    /// Simulates a real life scenario for the students to test. This test should also pass if you have setup your math/output correctly.
    func testCase1() {
        
        // Type $100 into the textfield
        let amountTextField = app.textFields["amountTextField"]
        amountTextField.tap()
        amountTextField.typeText("100")
        
        // Simulate background press
        let tipCalcLabel = app.staticTexts["tipCalculaterLabel"]
        tipCalcLabel.tap()
        
        // Grab all the necessary labels
        let taxAmountLabel = app.staticTexts["taxAmountLabel"]
        let subtotalAmountLabel = app.staticTexts["subtotalAmountLabel"]
        let tipAmountLabel = app.staticTexts["tipAmountLabel"]
        let totalWithTipAmountLabel = app.staticTexts["totalWithTipAmountLabel"]
        let totalPerPersonAmountLabel = app.staticTexts["totalPerPersonAmountLabel"]
        let sliderLabel = app.staticTexts["sliderLabel"]
        let splitLabel = app.staticTexts["splitLabel"]

        // Split  1 case: works when the tip is 15% and the split is 1
        let switchtax = app.switches["includeTaxSwitch"]
        switchtax.tap()
        let isOn = switchtax.value as! String
        if (isOn == "0")
        {
            // want to make sure this is enable, so tap again
            switchtax.tap()
        }
        
        // Set tax to .1 of slider
        let slider = app.sliders["tipSlider"]
        slider.adjust(toNormalizedSliderPosition: 0.10)
        let sliderval = Float((slider.value as! String).components(separatedBy: "%").first!)
        
        // Do the math
        let mathfortip = 108.50 * (sliderval! / 100.00)
        let tipamountString = String(format: "$%.02f", mathfortip)
        let totalwTip = mathfortip + 108.50
        let totalwTipString = String(format: "$%.02f", totalwTip)

        // Set segmented control to 8.5
        let segmented = app.segmentedControls["segmentedTax"]
        segmented.tap()
        
        // Grabs the split value because not everyones may start at 1
        let stepperValue = Int(splitLabel.label)
        let totalperperson = totalwTip / Float(stepperValue!)
        let totalperpersonstring = String(format: "$%.02f", totalperperson)
        
        // Verify output in labels is correct
        XCTAssertEqual(taxAmountLabel.label, "$8.50")
        XCTAssertEqual(subtotalAmountLabel.label, "$108.50")
        XCTAssertEqual(tipAmountLabel.label, tipamountString)
        XCTAssertEqual(totalWithTipAmountLabel.label, totalwTipString)
        XCTAssertEqual(totalPerPersonAmountLabel.label, totalperpersonstring)
        XCTAssertEqual(sliderLabel.label, slider.value as! String)
    }
}
