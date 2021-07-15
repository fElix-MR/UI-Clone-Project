//
//  RRNInputView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/15.
//

import UIKit

final class RRNInputView: SignUpInputView {
  
  let birthTextField = SignUpBaseTextField(frame: .zero)
  let genderTextField = SignUpBaseTextField(frame: .zero)
  
  let hyphenLabel = UILabel(frame: .zero)
  let encryptionLabelStackView = UIStackView(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func firstResponder() {
    birthTextField.becomeFirstResponder()
  }
  
  override func isCompleted() -> Bool {
    guard
      let birth = birthTextField.text,
      let gender = genderTextField.text else { return false }
    
    return birth.count == 6 && gender.count == 1
  }
}

private extension RRNInputView {
  
  func setupView() {
    hyphenLabel.text = "-"
    
    for _ in 0..<6 {
      let encryptionLabel = UILabel(frame: .zero)
      encryptionLabel.text = "•"
      encryptionLabel.translatesAutoresizingMaskIntoConstraints = false
      encryptionLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
      encryptionLabelStackView.addArrangedSubview(encryptionLabel)
    }
    encryptionLabelStackView.distribution = .fillEqually
    
    hyphenLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
    
    birthTextField.addTarget(self, action: #selector(rrnTextFieldBeginEditing(_:)), for: .editingDidBegin)
    birthTextField.addTarget(self, action: #selector(rrnTextFieldEndEditing(_:)), for: .editingDidEnd)
    birthTextField.addTarget(self, action: #selector(rrnTextFieldChanged(_:)), for: .editingChanged)
    birthTextField.keyboardType = .numberPad
    
    genderTextField.addTarget(self, action: #selector(rrnTextFieldBeginEditing(_:)), for: .editingDidBegin)
    genderTextField.addTarget(self, action: #selector(rrnTextFieldEndEditing(_:)), for: .editingDidEnd)
    genderTextField.addTarget(self, action: #selector(rrnTextFieldChanged(_:)), for: .editingChanged)
    genderTextField.keyboardType = .numberPad
    
    endEdit()
  }
  
  func setupConstraints() {
    [birthTextField, genderTextField, hyphenLabel, encryptionLabelStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      birthTextField.topAnchor.constraint(equalTo: topAnchor),
      birthTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
      birthTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
      
      hyphenLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      hyphenLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      hyphenLabel.leadingAnchor.constraint(equalTo: birthTextField.trailingAnchor),
      hyphenLabel.widthAnchor.constraint(equalToConstant: 10),
      
      genderTextField.leadingAnchor.constraint(equalTo: hyphenLabel.trailingAnchor, constant: 15),
      genderTextField.widthAnchor.constraint(equalToConstant: 20),
      genderTextField.topAnchor.constraint(equalTo: birthTextField.topAnchor),
      genderTextField.bottomAnchor.constraint(equalTo: birthTextField.bottomAnchor),
      
      encryptionLabelStackView.leadingAnchor.constraint(equalTo: genderTextField.trailingAnchor),
      encryptionLabelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
      encryptionLabelStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  func endEdit() {
    hyphenLabel.isHidden = true
    encryptionLabelStackView.isHidden = true
    genderTextField.isHidden = true
  }
  
  func beginEditing() {
    hyphenLabel.isHidden = false
    encryptionLabelStackView.isHidden = false
    genderTextField.isHidden = false
  }
  
  @objc func rrnTextFieldBeginEditing(_ sender: UITextField) {
    delegate?.selectedInputView(self)
    beginEditing()
  }
  
  @objc func rrnTextFieldEndEditing(_ sender: UITextField) {
    if let birth = birthTextField.text,
       let gender = genderTextField.text,
       birth == "",
       gender == "" {
      delegate?.deselectedInputView(self)
      endEdit()
    }
  }
  
  @objc func rrnTextFieldChanged(_ sender: UITextField) {
    if isCompleted() {
      delegate?.completedInputView(self)
      birthTextField.resignFirstResponder()
      genderTextField.resignFirstResponder()
    }
    
    guard let birth = birthTextField.text,
          let gender = genderTextField.text else { return }
    
    if birth.count == 6,
       gender.count != 1 {
      genderTextField.becomeFirstResponder()
    }
    
    if birth.count != 6,
       gender.count == 1 {
      birthTextField.becomeFirstResponder()
    }
  }
}
