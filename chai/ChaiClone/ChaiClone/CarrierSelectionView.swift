//
//  CarrierSelectionView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/15.
//

import UIKit

final class CarrierSelectionView: UIView {

  let titleView = CarrierTitleView(frame: .zero)
  let dividerView = UIView(frame: .zero)
  let carrierTableView = UITableView(frame: .zero)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupCarrierTitleViewDelegate(_ delegate: CarrierTitleViewDelegate) {
    titleView.delegate = delegate
  }
}

private extension CarrierSelectionView {
  
  func setupView() {
    backgroundColor = #colorLiteral(red: 0.08234294504, green: 0.08235850185, blue: 0.08233765513, alpha: 1)
    titleView.backgroundColor = .clear
    
    dividerView.backgroundColor = .black
    
    carrierTableView.backgroundColor = .clear
    carrierTableView.isScrollEnabled = false
    carrierTableView.rowHeight = 70
    carrierTableView.register(CarrierTableViewCell.self, forCellReuseIdentifier: "CarrierTableViewCell")
  }
  
  func setupConstraints() {
    [titleView, dividerView, carrierTableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      titleView.topAnchor.constraint(equalTo: topAnchor),
      titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleView.heightAnchor.constraint(equalToConstant: 50),
      
      dividerView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
      dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      dividerView.heightAnchor.constraint(equalToConstant: 1),
      
      carrierTableView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
      carrierTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      carrierTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      carrierTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}

protocol CarrierTitleViewDelegate: AnyObject {
  
  func closeButtonTapped(_ sender: UIButton)
}

final class CarrierTitleView: UIView {
  
  let titleLabel = UILabel(frame: .zero)
  let closeButton = UIButton(frame: .zero)
  
  weak var delegate: CarrierTitleViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension CarrierTitleView {
  
  func setupView() {
    titleLabel.text = "통신사선택"
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    titleLabel.textColor = .white
    
    closeButton.setTitle("닫기", for: .normal)
    closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    closeButton.setTitleColor(.systemGray2, for: .normal)
    closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
  }
  
  func setupConstraints() {
    [titleLabel, closeButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      
      closeButton.topAnchor.constraint(equalTo: topAnchor),
      closeButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    ])
  }
  
  @objc func closeButtonTapped(_ sender: UIButton) {
    delegate?.closeButtonTapped(sender)
  }
}
