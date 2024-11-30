//
//  AdoptDetailViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit

class AdoptDetailViewController: UIViewController {
    
    // image
    @IBOutlet weak var adoptImg: UIImageView!
    
    // label
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var speciesDetailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderDetailLabel: UILabel!
    @IBOutlet weak var neuterLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageDetailLabel: UILabel!
    @IBOutlet weak var specialLabel: UILabel!
    @IBOutlet weak var specialContentLabel: UILabel!
    @IBOutlet weak var shelterLabel: UILabel!
    @IBOutlet weak var shelterDetailLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDetailLabel: UILabel!
    @IBOutlet weak var managerLabel: UILabel!
    @IBOutlet weak var managerDetailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneDetailLabel: UILabel!
    @IBOutlet weak var cautionLabel: UILabel!
    
    // button
    @IBOutlet weak var speciesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        setupUI()
    }
    
    private func setupFont() {
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        speciesDetailLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        speciesBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 10)
        genderLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        genderDetailLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        neuterLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        ageLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        ageDetailLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        specialLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        specialContentLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        shelterLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        shelterDetailLable.font = UIFont(name: "Pretendard-Regular", size: 16)
        dateLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        dateDetailLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        managerLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        managerDetailLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        phoneLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        phoneDetailLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        cautionLabel.font = UIFont(name: "Pretendard-Medium", size: 11)
    }
    
    private func setupUI() {
        speciesBtn.layer.cornerRadius = 10
        speciesBtn.layer.borderWidth = 1
        speciesBtn.layer.borderColor = UIColor.cityLabel.cgColor
    }

}
