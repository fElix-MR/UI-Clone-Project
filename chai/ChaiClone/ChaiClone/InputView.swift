//
//  InputView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/13.
//

import UIKit

class InputView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension InputView {
  
  func setupView() {
    backgroundColor = .white
    layer.cornerRadius = 20
  }
}
