//
//  NameInputView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/15.
//

import UIKit

final class NameInputView: SignUpInputView {
  
  let nameTextField = SignUpBaseTextField(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func firstResponder() {
    nameTextField.becomeFirstResponder()
    nameTextField.delegate = self
  }
}

private extension NameInputView {
  
  func setupView() {
    nameTextField.addTarget(self, action: #selector(nameTextFieldBeginEditing(_:)), for: .editingDidBegin)
    nameTextField.addTarget(self, action: #selector(nameTextFieldEndEditing(_:)), for: .editingDidEnd)
    
  }
  
  func setupConstraints() {
    [nameTextField].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      nameTextField.topAnchor.constraint(equalTo: topAnchor),
      nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
      nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
      nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  @objc func nameTextFieldBeginEditing(_ sender: AnyObject) {
    delegate?.selectedInputView(self)
  }
  
  @objc func nameTextFieldEndEditing(_ sender: UITextField) {
    if let text = sender.text,
       text == "" {
      delegate?.deselectedInputView(self)
    }
  }
}

extension NameInputView: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
}
