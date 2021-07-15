//
//  SignUpInputViewType.swift
//  ChaiClone
//
//  Created by 서명렬 on 2021/07/15.
//

import Foundation

enum SignUpInputViewType {
  case name
  case carrier
  case rrn
  case phoneNumber
  
  var value: SignUpInputViewProtocol {
    switch self {
    case .name: return NameInputViewType()
    case .carrier: return CarrierInputViewType()
    case .rrn: return RRNInputViewType()
    case .phoneNumber: return PhoneNumberInputViewType()
    }
  }
}

protocol SignUpInputViewProtocol {
  
  var title: String { get }
  var signUpInputView: SignUpInputView { get }
}

struct NameInputViewType: SignUpInputViewProtocol {
  
  var title: String {
    return "이름"
  }
  
  var signUpInputView: SignUpInputView {
    return NameInputView(frame: .zero)
  }
}

struct CarrierInputViewType: SignUpInputViewProtocol {
  
  var title: String {
    return "통신사"
  }
  
  var signUpInputView: SignUpInputView {
    return CarrierInputView(frame: .zero)
  }
}

struct RRNInputViewType: SignUpInputViewProtocol {
  
  var title: String {
    return "주민등록번호"
  }
  
  var signUpInputView: SignUpInputView {
    return RRNInputView(frame: .zero)
  }
}

struct PhoneNumberInputViewType: SignUpInputViewProtocol {
  
  var title: String {
    return "핸드폰번호"
  }
  
  var signUpInputView: SignUpInputView {
    return PhoneNumberInputView(frame: .zero)
  }
}

