//
//  AdoptListCollectionViewCell.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit

class AdoptListCollectionViewCell: UICollectionViewCell {
    
    // image
    @IBOutlet weak var adoptImg: UIImageView!
    
    // label
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var speciesDetailLabel: UILabel!
    @IBOutlet weak var shelterLabel: UILabel!
    @IBOutlet weak var shelterDetailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupFont()
        setupUI()
    }

    private func setupFont() {
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        speciesLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        speciesDetailLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        shelterLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        shelterDetailLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        dateLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
        dateDetailLabel.font = UIFont(name: "Pretendard-Medium", size: 12)
    }
    
    private func setupUI() {
        adoptImg.layer.cornerRadius = 15
        adoptImg.layer.borderWidth = 1
        adoptImg.layer.borderColor = UIColor.buttonSelected.cgColor
    }
}
