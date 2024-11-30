//
//  LoginViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/29/24.
//

import UIKit
import Alamofire

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
        
        setupTextFieldObservers()
        updateLoginButtonState()
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
        passwordTextField.isSecureTextEntry = true
        
        loginBtn.layer.cornerRadius = 27.5
        loginBtn.backgroundColor = UIColor.buttonUnselected // 초기 비활성화 상태 색상
        loginBtn.isEnabled = false // 초기 비활성화 상태
    }
    
    private func addUnderlineSignupBtn() {
        let title = "회원가입"
        let attributedTitle = NSAttributedString(string: title, attributes: [ .underlineStyle: NSUnderlineStyle.single.rawValue,])
        signupBtn.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    private func setupTextFieldObservers() {
        idTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldsDidChange() {
        updateLoginButtonState()
    }
    
    private func updateLoginButtonState() {
        let isIdEntered = !(idTextField.text?.isEmpty ?? true)
        let isPasswordEntered = !(passwordTextField.text?.isEmpty ?? true)
        
        if isIdEntered && isPasswordEntered {
            loginBtn.isEnabled = true
            loginBtn.backgroundColor = UIColor.buttonSelected // 활성화 색상
        } else {
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = UIColor.buttonUnselected // 비활성화 색상
        }
    }

    // aciton
    @IBAction func tapLogin(_ sender: Any) {
        guard let id = idTextField.text, let password = passwordTextField.text else { return }
                
        let requestBody = LoginRequestBody(id: id, password: password)
        
        APIClient.postRequest(endpoint: "/user/login", parameters: requestBody) { (result: Result<LoginResponseBody, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    DispatchQueue.main.async {
                        self.moveToMainScreen()
                    }
                } else {
                    DispatchQueue.main.async {
                        print("로그인 실패: \(response.message)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.debugFailure(error: error)
                }
            }
        }
    }
    
    @IBAction func tapSignup(_ sender: Any) {
        guard let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else {
            return
        }
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true)
    }
    
    private func moveToMainScreen() {
        guard let customTabBarVC = storyboard?.instantiateViewController(withIdentifier: "CustomTabBarViewController") as? CustomTabBarViewController else {
            return
        }
        customTabBarVC.modalPresentationStyle = .fullScreen
        present(customTabBarVC, animated: true)
    }
    
    private func debugFailure(error: AFError) {
        let message: String
        if let underlyingError = error.underlyingError {
            message = "Underlying Error: \(underlyingError.localizedDescription)"
        } else if let responseCode = error.responseCode {
            message = "HTTP Response Code: \(responseCode)"
        } else {
            message = "Error: \(error.localizedDescription)"
        }
        print("API Debug Info: \(message)")
    }
}
