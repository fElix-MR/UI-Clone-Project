//
//  ViewController.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/13.
//

import UIKit

final class MainViewController: UIViewController {

  let signUpButton = UIButton(frame: .zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraints()
  }
}

private extension MainViewController {
  
  func setupView() {
    signUpButton.setTitle("회원가입", for: .normal)
    signUpButton.setTitleColor(.black, for: .normal)
    signUpButton.backgroundColor = .systemBlue
    signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
  }
  
  func setupConstraints() {
    [signUpButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
  
  @objc func signUpButtonTapped(_ sender: UIButton) {
    navigationController?.pushViewController(SignUpViewController(), animated: true)
  }
}

