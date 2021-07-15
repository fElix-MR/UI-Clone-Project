//
//  CarrierInputView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/15.
//

import UIKit

final class CarrierInputView: SignUpInputView {
  
  let carrierLabel = UILabel(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func firstResponder() {
    delegate?.selectedInputView(self)
  }
}

private extension CarrierInputView {
  
  func setupView() {
    carrierLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(carrierLabelTapped(_:)))
    addGestureRecognizer(tapGesture)
  }
  
  func setupConstraints() {
    [carrierLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      carrierLabel.topAnchor.constraint(equalTo: topAnchor),
      carrierLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      carrierLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      carrierLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
  
  @objc func carrierLabelTapped(_ sender: UILabel) {
    firstResponder()
    delegate?.selectedInputView(self)
  }
}

extension CarrierInputView: CarrierSelectionViewControllerDelegate {
  
  func carrierSelected(_ sender: CarrierSelectionViewController, carrierTitle: String) {
    carrierLabel.text = carrierTitle
    delegate?.completedInputView(self)
  }
}
