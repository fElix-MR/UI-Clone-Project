//
//  PhoneNumberInputView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/14.
//

import UIKit

final class PhoneNumberInputView: SignUpInputView {
  
  let phoneNumberTextField = SignUpBaseTextField(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func firstResponder() {
    phoneNumberTextField.becomeFirstResponder()
  }
  
  override func isCompleted() -> Bool {
    guard let text = phoneNumberTextField.text else { return false }
    
    return text.count == 11
  }
}

private extension PhoneNumberInputView {
  
  func setupView() {
    phoneNumberTextField.keyboardType = .numberPad
    phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldBeginEditing(_:)), for: .editingDidBegin)
    phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEndEditing(_:)), for: .editingDidEnd)
    phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldChanged(_:)), for: .editingChanged)
  }
  
  func setupConstraints() {
    [phoneNumberTextField].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      phoneNumberTextField.topAnchor.constraint(equalTo: topAnchor),
      phoneNumberTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
      phoneNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
      phoneNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  @objc func phoneNumberTextFieldBeginEditing(_ sender: AnyObject) {
    delegate?.selectedInputView(self)
  }
  
  @objc func phoneNumberTextFieldEndEditing(_ sender: UITextField) {
    if let text = sender.text,
       text == "" {
      delegate?.deselectedInputView(self)
    }
  }
  
  @objc func phoneNumberTextFieldChanged(_ sender: UITextField) {
    if isCompleted() {
      delegate?.completedInputView(self)
    }
  }
}
