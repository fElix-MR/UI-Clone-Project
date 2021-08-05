//
//  SignUpViewController.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/13.
//

import UIKit

final class SignUpViewController: UIViewController {
  
  let scrollView = SignUpScrollView(frame: .zero)
  let titleLabel = UILabel(frame: .zero)
  let button = ConfirmButton(frame: .zero)
  let collectionView = SignUpCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  var count = 1
  
  private lazy var keyboardShowConstraint = [
    button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    button.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
    collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -380)
  ]
  
  private lazy var keyboardHideConstraint = [
    button.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.85),
    button.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15),
    button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25)
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraints()
    setupNotification()
  }
  
  deinit {
    print("deinit")
  }
}

private extension SignUpViewController {
  
  func next() {
    DispatchQueue.main.async {
      self.count += 1
      self.collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
      
      self.collectionView.performBatchUpdates(nil) { _ in
        if self.count == 4 {
          self.button.isHidden = false
        }
      }
    }
  }
  
  func setupView() {
    view.backgroundColor = .white
    
    collectionView.dataSource = self
    
    titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
    titleLabel.numberOfLines = 0
    titleLabel.text = "휴대폰번호를\n입력해주세요"
    
    button.isHidden = true
  }
  
  func setupConstraints() {
    [scrollView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    [titleLabel, collectionView, button].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      scrollView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
      scrollView.contentLayoutGuide.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor),
      scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor),
      
      titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.85),
      titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
      titleLabel.heightAnchor.constraint(equalToConstant: 100),
      
      collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      collectionView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
      collectionView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
      
      button.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
      button.heightAnchor.constraint(equalToConstant: 60),
    ])
    
    NSLayoutConstraint.activate(keyboardHideConstraint)
  }
  
  func setupNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(_ notification: NSNotification) {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    let keyboardHeight = keyboardSize.cgRectValue.height
    button.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
    button.layer.cornerRadius = 0
    NSLayoutConstraint.deactivate(keyboardHideConstraint)
    NSLayoutConstraint.activate(keyboardShowConstraint)
    
    UIViewPropertyAnimator.runningPropertyAnimator(
      withDuration: 0.3,
      delay: 0,
      options: []
    ) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
  
  @objc func keyboardWillHide(_ notification: NSNotification) {
    button.transform = .identity
    button.layer.cornerRadius = 30
    NSLayoutConstraint.deactivate(keyboardShowConstraint)
    NSLayoutConstraint.activate(keyboardHideConstraint)
    
    UIViewPropertyAnimator.runningPropertyAnimator(
      withDuration: 0.3,
      delay: 0,
      options: []
    ) { [weak self] in
      self?.view.layoutIfNeeded()
    }
    
    collectionView.removeBorderView()
  }
}

extension SignUpViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpCollectionViewCell", for: indexPath) as? SignUpCollectionViewCell else { fatalError() }
    
    cell.delegate = self
    
    if count == 1 {
      cell.signUpInputViewType = .phoneNumber
    } else if count == 2 {
      cell.signUpInputViewType = .rrn
    } else if count == 3 {
      cell.signUpInputViewType = .carrier
    } else {
      cell.signUpInputViewType = .name
    }
    
    cell.setFirstResponder()
    
    return cell
  }
}

extension SignUpViewController: SignUpCollectionViewCellDelegate {
  
  func selcted(_ sender: SignUpCollectionViewCell, frame: CGRect) {
    DispatchQueue.main.async { [weak self] in
      self?.view.layoutIfNeeded()
      self?.scrollView.setContentOffset(CGPoint(x: frame.origin.x, y: frame.origin.y - 100), animated: true)
      self?.collectionView.moveBorderView(to: frame)
    }
    
    if sender.signUpInputViewType == .carrier {
      let carrierSelectionViewController = CarrierSelectionViewController()
      if let carrierInputView = sender.signUpInputView as? CarrierInputView {
        carrierSelectionViewController.delegate = carrierInputView
      }
      present(carrierSelectionViewController, animated: true, completion: nil)
      view.endEditing(true)
    }
  }
  
  func completed(_ sender: SignUpCollectionViewCell) {
    next()
  }
}
