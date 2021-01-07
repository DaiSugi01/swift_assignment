//
//  ViewController.swift
//  TipCalculator
//
//  Created by 杉原大貴 on 2021/01/06.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var tipPercentageTextField: UITextField!
    @IBOutlet var tipSlider: UISlider!
    @IBOutlet var tipPercentageLabel: UILabel!
    @IBOutlet var calculateButton: UIButton!
    
    var tipValue = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        registerForKeyboardNotification()
        addGesture()
        scrollView.delegate = self
    }

    private func setupButton() {
        calculateButton.isEnabled = false
        calculateButton.backgroundColor = .lightGray
    }
    
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    private func updateAmount() {
        guard let amount = Double(tipPercentageTextField.text!) else { return }
        let totalAmount = amount * (1 + Double(tipValue) / 100.0)
        tipAmountLabel.text = "$ \(String(format: "%.2f", totalAmount))"
    }
        
    private func checkTF() -> Bool {
        guard let _ = Double(tipPercentageTextField.text!) else { return false }
        return true
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      view.endEditing(true)
    }

    @objc func keyboardWasShown(_ notification: NSNotification) {
      guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }

      let keyboardFrame = keyboardFrameValue.cgRectValue
      let keyboardHeight = keyboardFrame.size.height
      
      let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }

    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
      let insets = UIEdgeInsets.zero
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }
    
    @IBAction func billAmountChanged(_ sender: UITextField) {
        if checkTF() {
            calculateButton.isEnabled = true
            calculateButton.backgroundColor = .systemTeal
        } else {
            setupButton()
        }
    }
    
    @IBAction func calculateButtonPrressed(_ sender: UIButton) {
        updateAmount()
    }

    @IBAction func adjustTipPercentage(_ sender: UISlider) {
        let amount = tipAmountLabel.text!.suffix(tipAmountLabel.text!.count - 1)
        let tip = String(format: "%.0f", round(sender.value * 100))
        tipValue = Int(round(sender.value * 100))
        tipPercentageLabel.text = "\(tip)%"

        if let currentAmount = Double(amount.trimmingCharacters(in: .whitespacesAndNewlines)) {
            if currentAmount > 0 { updateAmount() }
        }
    }
    
}
