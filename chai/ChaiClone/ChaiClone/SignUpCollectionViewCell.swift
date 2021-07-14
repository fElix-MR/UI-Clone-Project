//
//  SignUpCollectionViewCell.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/14.
//

import UIKit

protocol SignUpCollectionViewCellDelegate: AnyObject {
  
  func selcted(_ sender: SignUpCollectionViewCell, frame: CGRect)
}

final class SignUpCollectionViewCell: UICollectionViewCell {
  
  var delegate: SignUpCollectionViewCellDelegate?
  
  let largePlaceHolderLabel = UILabel(frame: .zero)
  let smallPlaceHolderLabel = UILabel(frame: .zero)
  let signUpTextField = SignUpBaseTextField(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SignUpCollectionViewCell {
  
  func setupView() {
    backgroundColor = .white
    layer.cornerRadius = 20
    
    largePlaceHolderLabel.text = "TEST"
    largePlaceHolderLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
    largePlaceHolderLabel.textColor = .systemGray2
    
    smallPlaceHolderLabel.text = "TEST"
    smallPlaceHolderLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    smallPlaceHolderLabel.textColor = .systemGray2
    smallPlaceHolderLabel.isHidden = true
    
    signUpTextField.addTarget(self, action: #selector(signUpTextFieldBeginEditing(_:)), for: .editingDidBegin)
    signUpTextField.addTarget(self, action: #selector(signUpTextFieldEndEditing(_:)), for: .editingDidEnd)
  }
  
  func setupConstraints() {
    [largePlaceHolderLabel, smallPlaceHolderLabel, signUpTextField].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      largePlaceHolderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      largePlaceHolderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      largePlaceHolderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      largePlaceHolderLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
      
      signUpTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      signUpTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
      signUpTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      signUpTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
      
      smallPlaceHolderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      smallPlaceHolderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      smallPlaceHolderLabel.bottomAnchor.constraint(equalTo: largePlaceHolderLabel.firstBaselineAnchor, constant: -5)
    ])
  }
  
  @objc func signUpTextFieldBeginEditing(_ sender: UITextField) {
    self.largePlaceHolderLabel.isHidden = true
    self.smallPlaceHolderLabel.isHidden = false
    delegate?.selcted(self, frame: frame)
  }
  
  @objc func signUpTextFieldEndEditing(_ sender: UITextField) {
    if let text = sender.text,
       text == "" {
      self.largePlaceHolderLabel.isHidden = false
      self.smallPlaceHolderLabel.isHidden = true
    }
  }
}
