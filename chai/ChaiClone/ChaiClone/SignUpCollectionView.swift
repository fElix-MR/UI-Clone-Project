//
//  SignUpCollectionView.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/14.
//

import UIKit

final class SignUpCollectionView: UICollectionView {
  
  let borderView = BorderView(frame: .zero)
  
  private lazy var borderViewConstraint = borderView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    setupView()
    setupFlowLayout()
    setupConstraints()
    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//      self.borderView.fadeIn()
//    }
//    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//      self.borderView.fadeOut()
//    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var contentSize: CGSize {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  override var intrinsicContentSize: CGSize {
    layoutIfNeeded()
    return CGSize(
      width: UIView.noIntrinsicMetric,
      height: contentSize.height
    )
  }
  
  func moveBorderView(to frame: CGRect) {
    borderViewConstraint.constant = frame.origin.y
    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    } completion: { _ in
      self.borderView.alpha = 1
    }
    
  }
}

private extension SignUpCollectionView {
  
  func setupView() {
    isScrollEnabled = false
    backgroundColor = .clear
    register(SignUpCollectionViewCell.self, forCellWithReuseIdentifier: "SignUpCollectionViewCell")
  }
  
  func setupFlowLayout() {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
    else { return }
    
    flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.85, height: 85)
    flowLayout.minimumLineSpacing = 15
    flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    
    collectionViewLayout = flowLayout
  }
  
  func setupConstraints() {
    [borderView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      borderView.widthAnchor.constraint(equalTo: widthAnchor),
      borderView.centerXAnchor.constraint(equalTo: centerXAnchor),
      borderView.heightAnchor.constraint(equalToConstant: 85),
      borderViewConstraint
    ])
    
  }
}
