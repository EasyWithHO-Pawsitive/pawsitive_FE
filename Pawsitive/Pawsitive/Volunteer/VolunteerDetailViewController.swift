//
//  VolunteerDetailViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit

class VolunteerDetailViewController: UIViewController {
    
    // label
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDetailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberDetailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusDetailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationDetailLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startDetailLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var endDetailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var managerLabel: UILabel!
    @IBOutlet weak var managerDetailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneDetailLabel: UILabel!
    @IBOutlet weak var copLabel: UILabel!
    @IBOutlet weak var copDetailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressDetailLabel: UILabel!
    
    // button
    @IBOutlet weak var applyBtn: UIButton!
    
    // view
    @IBOutlet weak var detailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        setupUI()
    }
    
    private func setupFont() {
        nameLabel.font = UIFont(name: "Pretendard-Bold", size: 18)
        dateLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        dateDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        numberLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        numberDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        statusLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        statusDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        locationLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        locationDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        startLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        startDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        endLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        endDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        
        contentLabel.font = UIFont(name: "Pretendard-Regular", size: 17)
        
        managerLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        managerDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        phoneLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        phoneDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        copLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        copDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        addressLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        addressDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        
        applyBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
    }
    
    private func setupUI() {
        detailView.layer.cornerRadius = 15
        detailView.layer.borderWidth = 1
        detailView.layer.borderColor = UIColor.textfieldBorder.cgColor
        
        applyBtn.layer.cornerRadius = 27.5
    }
    
    // action
    @IBAction func backBtn(_ sender: Any) {
        guard let volunteerVC = storyboard?.instantiateViewController(withIdentifier: "VolunteerViewController") as? VolunteerViewController else {
            return
        }
        volunteerVC.modalPresentationStyle = .fullScreen
        present(volunteerVC, animated: true)
    }
    
    @IBAction func tapApply(_ sender: Any) {
        let alert = UIAlertController(title: "해당 봉사를 신청하시겠습니까?", message: "상세 내용을 한 번 더 확인해주세요.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(cancelAction)
        cancelAction.setValue(UIColor.cancelAlert, forKey: "titleTextColor")
        
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        confirmAction.setValue(UIColor.buttonSelected, forKey: "titleTextColor")
        
        alert.preferredAction = confirmAction
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
