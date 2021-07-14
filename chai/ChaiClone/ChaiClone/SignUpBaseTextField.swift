//
//  SignUpBaseTextField.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/14.
//

import UIKit

class SignUpBaseTextField: UITextField {

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SignUpBaseTextField {
  
  func setupView() {
    tintColor = .red
    font = UIFont.systemFont(ofSize: 22, weight: .medium)
    autocorrectionType = .no
  }
}
