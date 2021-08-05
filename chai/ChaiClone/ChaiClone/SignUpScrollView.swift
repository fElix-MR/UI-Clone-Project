//
//  SignUpScrollView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/14.
//

import UIKit

final class SignUpScrollView: UIScrollView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    super.touchesBegan(touches, with: event)
//    
//    endEditing(true)
//  }
}

private extension SignUpScrollView {
  
  func setupView() {
    bounces = true
    backgroundColor = .systemGray6
    showsHorizontalScrollIndicator = false
    setNeedsLayout()
  }
}
