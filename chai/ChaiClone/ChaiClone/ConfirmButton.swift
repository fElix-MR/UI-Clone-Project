//
//  ConfirmButton.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/14.
//

import UIKit

final class ConfirmButton: UIButton {

  override var isEnabled: Bool {
    didSet {
      DispatchQueue.main.async {
        self.isEnabled ? self.setEnable() : self.setDisenable()
      }
      
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension ConfirmButton {
  
  func setupView() {
    setTitle("확인", for: .normal)
    layer.cornerRadius = 30
    titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    setDisenable()
  }
  
  func setEnable() {
    backgroundColor = .black
    isEnabled = true
  }
  
  func setDisenable() {
    backgroundColor = .systemGray5
    isEnabled = false
  }
}
