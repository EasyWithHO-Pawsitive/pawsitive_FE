//
//  SignupCompleteViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/29/24.
//

import UIKit

class SignupCompleteViewController: UIViewController {

    // label
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var subCompleteLabel: UILabel!
    
    // button
    @IBOutlet weak var loginBtn: UIButton!
    
    // view
    @IBOutlet weak var baseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupFont()
        setupUI()
    }
    
    private func setupFont() {
        completeLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        subCompleteLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        loginBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
    }
    
    private func setupUI() {
        baseView.layer.cornerRadius = 15
        baseView.layer.borderWidth = 1
        baseView.layer.borderColor = UIColor.textfieldBorder.cgColor
        
        loginBtn.layer.cornerRadius = 27.5
    }
}
