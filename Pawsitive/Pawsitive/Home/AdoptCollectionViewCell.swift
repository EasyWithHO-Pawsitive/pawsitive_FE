//
//  AdoptCollectionViewCell.swift
//  Pawsitive
//
//  Created by 성호은 on 11/29/24.
//

import UIKit

class AdoptCollectionViewCell: UICollectionViewCell {
    
    // image
    @IBOutlet weak var infoImg: UIImageView!
    
    // button
    @IBOutlet weak var speciesBtn: UIButton!
    
    // label
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoShelterLabel: UILabel!
    @IBOutlet weak var infoDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupFont()
        setupUI()
    }

    private func setupFont() {
        speciesBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 10)
        infoNameLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        infoShelterLabel.font = UIFont(name: "Pretendard-Medium", size: 10)
        infoDateLabel.font = UIFont(name: "Pretendard-Medium", size: 10)
    }
    
    private func setupUI() {
        infoImg.layer.cornerRadius = 20
        
        speciesBtn.layer.cornerRadius = 10
        speciesBtn.layer.borderWidth = 1
        speciesBtn.layer.borderColor =  UIColor.cityLabel.cgColor
    }
}
