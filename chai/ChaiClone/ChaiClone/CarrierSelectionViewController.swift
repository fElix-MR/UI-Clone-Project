//
//  CarrierSelectionViewController.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/15.
//

import UIKit

protocol CarrierSelectionViewControllerDelegate: AnyObject {
  
  func carrierSelected(_ sender: CarrierSelectionViewController, carrierTitle: String)
}

final class CarrierSelectionViewController: UIViewController {
  
  weak var delegate: CarrierSelectionViewControllerDelegate?
  
  lazy var dimmedView: UIView = {
    let bdView = UIView(frame: self.view.bounds)
    bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    return bdView
  }()
  
  let carrierView = CarrierSelectionView(frame: .zero)
  private let carrierViewHeight: CGFloat = 500
  private var isPresenting = false
  
  private let selectionTableViewModel = ["SKT", "KT", "LG U+", "SKT 알뜰폰","KT 알뜰폰", "LG U+ 알뜰폰"]
  
  init() {
    super.init(nibName: nil, bundle: nil)
    modalPresentationStyle = .custom
    transitioningDelegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraints()
  }
}

private extension CarrierSelectionViewController {
  
  func setupView() {
    view.backgroundColor = .clear
    
    carrierView.carrierTableView.dataSource = self
    carrierView.carrierTableView.delegate = self
    carrierView.layer.cornerRadius = 30
    carrierView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    carrierView.layer.masksToBounds = true
    carrierView.setupCarrierTitleViewDelegate(self)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    dimmedView.addGestureRecognizer(tapGesture)
  }
  
  func setupConstraints() {
    [dimmedView, carrierView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
      dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      carrierView.heightAnchor.constraint(equalToConstant: carrierViewHeight),
      carrierView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      carrierView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      carrierView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
}

extension CarrierSelectionViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    selectionTableViewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarrierTableViewCell") as? CarrierTableViewCell
    else { fatalError() }
    
    let title = selectionTableViewModel[indexPath.row]
    cell.updateTitleLabel(with: title)
    
    return cell
  }
}

extension CarrierSelectionViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? CarrierTableViewCell else { return }
    if let title = cell.carrierLabel.text {
      delegate?.carrierSelected(self, carrierTitle: title)
    }
    
    dismiss(animated: true, completion: nil)
  }
}

extension CarrierSelectionViewController: CarrierTitleViewDelegate {
  
  func closeButtonTapped(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}

extension CarrierSelectionViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
    guard let toVC = toViewController else { return }
    isPresenting = !isPresenting
    
    if isPresenting == true {
      containerView.addSubview(toVC.view)
      
      carrierView.frame.origin.y += carrierViewHeight
      dimmedView.alpha = 0
      
      UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
        self.carrierView.frame.origin.y -= self.carrierViewHeight
        self.dimmedView.alpha = 1
      }, completion: { (finished) in
        transitionContext.completeTransition(true)
      })
    } else {
      UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
        self.carrierView.frame.origin.y += self.carrierViewHeight
        self.dimmedView.alpha = 0
      }, completion: { (finished) in
        transitionContext.completeTransition(true)
      })
    }
  }
}


