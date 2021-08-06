//
//  ViewController.swift
//  Infinite_Carousel
//
//  Created by 서명렬 on 2021/08/05.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
  
  private let itemSize = 10000
  private var disposeBag = DisposeBag()
  
  private let infiniteCarousel = InfiniteCarouselCollectionView(frame: .zero,
                                                                collectionViewLayout: UICollectionViewFlowLayout())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraints()
    binding()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    infiniteCarousel.scrollToItem(
      at: IndexPath(row: itemSize / 2, section: 0),
      at: .centeredHorizontally,
      animated: false
    )
  }
}

private extension ViewController {
  
  func setupView() {
    view.backgroundColor = .white
    
    infiniteCarousel.dataSource = self
    infiniteCarousel.register(
      InfiniteCarouselCollectionViewCell.self,
      forCellWithReuseIdentifier: "InfiniteCarouselCollectionViewCell"
    )
  }
  
  func setupConstraints() {
    [infiniteCarousel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      infiniteCarousel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      infiniteCarousel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      infiniteCarousel.widthAnchor.constraint(equalTo: view.widthAnchor),
      infiniteCarousel.heightAnchor.constraint(equalToConstant: 150)
    ])
  }
  
  func binding() {
    infiniteCarousel.rx.willEndDragging
      .bind { velocity, targetContentOffset in
        let cellWidthIncludeSpacing: CGFloat = UIScreen.main.bounds.width + 16
        var offset = targetContentOffset.pointee
        let index = (offset.x + self.infiniteCarousel.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex: CGFloat = round(index)
        offset = CGPoint(
          x: roundedIndex * cellWidthIncludeSpacing - self.infiniteCarousel.contentInset.left,
          y: self.infiniteCarousel.contentInset.top
        )
        targetContentOffset.pointee = offset
      }
      .disposed(by: disposeBag)
  }
  
  private func step() {
    let currentContentOffset = infiniteCarousel.contentOffset
    let width = UIScreen.main.bounds.width
    infiniteCarousel.setContentOffset(CGPoint(x: currentContentOffset.x + width, y: currentContentOffset.y), animated: true)
  }
}

extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemSize
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "InfiniteCarouselCollectionViewCell",
      for: indexPath
    ) as? InfiniteCarouselCollectionViewCell
    else { return InfiniteCarouselCollectionViewCell() }
    
    let red: CGFloat = CGFloat.random(in: 0...255) / 255
    let green: CGFloat = CGFloat.random(in: 0...255) / 255
    let blue: CGFloat = CGFloat.random(in: 0...255) / 255
    
    cell.updateViewBackground(with: UIColor(red: red, green: green, blue: blue, alpha: 1))
    
    return cell
  }
}
