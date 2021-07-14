//
//  BorderView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/14.
//

import UIKit

final class BorderView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func fadeIn() {
    self.alpha = 0
    self.transform = CGAffineTransform(translationX: 0, y: -5)
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) {
      self.transform = .identity
      self.alpha = 1
    }
  }
  
  func fadeOut() {
    self.alpha = 1
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) {
      self.transform = CGAffineTransform(translationX: 0, y: 5)
      self.alpha = 0
    }
  }
}

private extension BorderView {
  
  func setupView() {
    layer.cornerRadius = 20
    layer.borderWidth = 4
    layer.borderColor = UIColor.black.cgColor
    alpha = 0
  }
}
