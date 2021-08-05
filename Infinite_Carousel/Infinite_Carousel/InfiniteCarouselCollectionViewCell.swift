//
//  InfiniteCarouselCollectionViewCell.swift
//  Infinite_Carousel
//
//  Created by 서명렬 on 2021/08/05.
//

import UIKit

final class InfiniteCarouselCollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    backgroundColor = .clear
  }
  
  func updateViewBackground(with color: UIColor) {
    backgroundColor = color
  }
}
