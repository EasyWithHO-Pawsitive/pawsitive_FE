//
//  LoginViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/29/24.
//

import UIKit

class LoginViewController: UIViewController {
    // label
    @IBOutlet weak var introduceLabel: UILabel!
    
    // textfield
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // button
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        setupUI()
        addUnderlineSignupBtn()
    }
    
    private func setupFont() {
        introduceLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        loginBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        signupBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 12)
    }
    
    private func setupUI() {
        idTextField.borderStyle = .none // 기본 설정 제거
        idTextField.layer.cornerRadius = 10
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        idTextField.clipsToBounds = true
        idTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        idTextField.leftViewMode = .always
        idTextField.attributedPlaceholder = NSAttributedString(
            string: "아이디",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 15)!
            ]
        )
        
        passwordTextField.borderStyle = .none // 기본 설정 제거
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        passwordTextField.clipsToBounds = true
        passwordTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        passwordTextField.leftViewMode = .always
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "비밀번호",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 15)!
            ]
        )
        
        loginBtn.layer.cornerRadius = 27.5
    }
    
    private func addUnderlineSignupBtn() {
        let title = "회원가입"
        let attributedTitle = NSAttributedString(string: title, attributes: [ .underlineStyle: NSUnderlineStyle.single.rawValue,])
        signupBtn.setAttributedTitle(attributedTitle, for: .normal)
    }

}
