//
//  InfiniteCarouselCollectionView.swift
//  Infinite_Carousel
//
//  Created by 서명렬 on 2021/08/05.
//

import UIKit

class InfiniteCarouselCollectionView: UICollectionView {

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    setupView()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

private extension InfiniteCarouselCollectionView {
  
  func setupView() {
    backgroundColor = .clear
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false
    decelerationRate = .fast
  }
  
  func setupLayout() {
    let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
    
    flowLayout?.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
    flowLayout?.minimumLineSpacing = 16
    flowLayout?.scrollDirection = .horizontal
  }
}
