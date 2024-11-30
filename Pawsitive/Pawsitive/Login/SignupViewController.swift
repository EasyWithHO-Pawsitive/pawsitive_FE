//
//  SignupViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/29/24.
//

import UIKit

class SignupViewController: UIViewController {

    // label
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    // textfield
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    // button
    @IBOutlet weak var signupCompleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        setupUI()
        
        setupTextFieldObservers()
        updateSignupButtonState()
    }
    
    private func setupFont() {
        signupLabel.font = UIFont(name: "Pretendard-Bold", size: 25)
        userInfoLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        signupCompleteBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
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
        passwordTextField.isSecureTextEntry = true
        
        nameTextField.borderStyle = .none // 기본 설정 제거
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        nameTextField.clipsToBounds = true
        nameTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        nameTextField.leftViewMode = .always
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "이름",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 15)!
            ]
        )
        
        birthTextField.borderStyle = .none // 기본 설정 제거
        birthTextField.layer.cornerRadius = 10
        birthTextField.layer.borderWidth = 1
        birthTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        birthTextField.clipsToBounds = true
        birthTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        birthTextField.leftViewMode = .always
        birthTextField.attributedPlaceholder = NSAttributedString(
            string: "생년월일",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 15)!
            ]
        )
        
        phoneNumberTextField.borderStyle = .none // 기본 설정 제거
        phoneNumberTextField.layer.cornerRadius = 10
        phoneNumberTextField.layer.borderWidth = 1
        phoneNumberTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        phoneNumberTextField.clipsToBounds = true
        phoneNumberTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        phoneNumberTextField.leftViewMode = .always
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(
            string: "전화번호",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 15)!
            ]
        )
        
        signupCompleteBtn.layer.cornerRadius = 27.5
        signupCompleteBtn.backgroundColor = UIColor.buttonUnselected // 초기 비활성화 상태 색상
        signupCompleteBtn.isEnabled = false // 초기 비활성화 상태
    }
    
    private func setupTextFieldObservers() {
        let textFields = [idTextField, passwordTextField, nameTextField, birthTextField, phoneNumberTextField]
        
        textFields.forEach { textField in
            textField?.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        }
    }
    
    @objc private func textFieldsDidChange() {
        updateSignupButtonState()
    }
    
    private func updateSignupButtonState() {
        let textFields = [idTextField, passwordTextField, nameTextField, birthTextField, phoneNumberTextField]
        
        let areAllFieldsFilled = textFields.allSatisfy { textField in
            !(textField?.text?.isEmpty ?? true)
        }
        
        if areAllFieldsFilled {
            signupCompleteBtn.isEnabled = true
            signupCompleteBtn.backgroundColor = UIColor.buttonSelected // 활성화 색상
        } else {
            signupCompleteBtn.isEnabled = false
            signupCompleteBtn.backgroundColor = UIColor.buttonUnselected // 비활성화 색상
        }
    }
    
    // action
    @IBAction func tapSignup(_ sender: Any) {
        guard let signupCompleteVC = storyboard?.instantiateViewController(withIdentifier: "SignupCompleteViewController") as? SignupCompleteViewController else {
            return
        }
        signupCompleteVC.modalPresentationStyle = .fullScreen
        present(signupCompleteVC, animated: true)
    }
    
}
