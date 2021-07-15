//
//  SignUpCollectionViewCell.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/14.
//

import UIKit

protocol SignUpCollectionViewCellDelegate: AnyObject {
  
  func selcted(_ sender: SignUpCollectionViewCell, frame: CGRect)
  func completed(_ sender: SignUpCollectionViewCell)
}

final class SignUpCollectionViewCell: UICollectionViewCell {
  
  weak var delegate: SignUpCollectionViewCellDelegate?
  
  let largePlaceHolderLabel = UILabel(frame: .zero)
  let smallPlaceHolderLabel = UILabel(frame: .zero)
  var signUpInputView: SignUpInputView?
  
  var signUpInputViewType: SignUpInputViewType? {
    didSet {
      guard let signUpInputViewType = signUpInputViewType else { return }
      
      setupInputView(signUpInputViewType.value.signUpInputView)
      setupLabel(with: signUpInputViewType.value.title)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupInputViewType(_ signUpInputViewType: SignUpInputViewType) {
    self.signUpInputViewType = signUpInputViewType
  }
  
  func setFirstResponder() {
    signUpInputView?.firstResponder()
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
  }
  
  func setupConstraints() {
    [largePlaceHolderLabel, smallPlaceHolderLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      largePlaceHolderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      largePlaceHolderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      largePlaceHolderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      largePlaceHolderLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
      
      smallPlaceHolderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      smallPlaceHolderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      smallPlaceHolderLabel.bottomAnchor.constraint(equalTo: largePlaceHolderLabel.firstBaselineAnchor, constant: -5)
    ])
  }
  
  func setupInputView(_ signUpInputView: SignUpInputView) {
    self.signUpInputView = signUpInputView
    signUpInputView.delegate = self
    signUpInputView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(signUpInputView)
    
    NSLayoutConstraint.activate([
      signUpInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      signUpInputView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
      signUpInputView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      signUpInputView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
    ])
  }
  
  func setupLabel(with title: String) {
    smallPlaceHolderLabel.text = title
    largePlaceHolderLabel.text = title
  }
}

extension SignUpCollectionViewCell: SignUpInputViewDelegate {
  
  func selectedInputView(_ sender: SignUpInputView) {
    self.largePlaceHolderLabel.isHidden = true
    self.smallPlaceHolderLabel.isHidden = false
    delegate?.selcted(self, frame: frame)
  }
  
  func deselectedInputView(_ sender: SignUpInputView) {
    self.largePlaceHolderLabel.isHidden = false
    self.smallPlaceHolderLabel.isHidden = true
  }
  
  func completedInputView(_ sender: SignUpInputView) {
    delegate?.completed(self)
  }
}
