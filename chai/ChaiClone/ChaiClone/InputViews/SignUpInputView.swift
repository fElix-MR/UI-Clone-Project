//
//  SignUpInputView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/13.
//

import UIKit

protocol SignUpInputViewDelegate: AnyObject {
  
  func selectedInputView(_ sender: SignUpInputView)
  func deselectedInputView(_ sender: SignUpInputView)
  func completedInputView(_ sender: SignUpInputView)
}

class SignUpInputView: UIView {
  
  weak var delegate: SignUpInputViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func firstResponder() { }
  func isCompleted() -> Bool { return true }
  
}

private extension SignUpInputView {
  
  func setupView() {
    backgroundColor = .clear
    layer.cornerRadius = 20
  }
}
