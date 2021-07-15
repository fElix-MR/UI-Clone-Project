//
//  CarrierTableViewCell.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/15.
//

import UIKit

final class CarrierTableViewCell: UITableViewCell {
  
  let carrierLabel = UILabel(frame: .zero)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    backgroundColor = isSelected ? .black : .clear
    accessoryType = isSelected ? .checkmark : .none
  }
  
  func updateTitleLabel(with title: String) {
    carrierLabel.text = title
  }
}

private extension CarrierTableViewCell {
  
  func setupView() {
    selectionStyle = .none
    tintColor = .white
    layer.cornerRadius = 30
    
    carrierLabel.text = "TEST"
    carrierLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    carrierLabel.textColor = .systemGray3
  }
  
  func setupConstraints() {
    [carrierLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      carrierLabel.topAnchor.constraint(equalTo: topAnchor),
      carrierLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      carrierLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      carrierLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    ])
  }
}
