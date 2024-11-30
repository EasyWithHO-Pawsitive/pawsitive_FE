//
//  VolunteerListCollectionViewCell.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit

class VolunteerListCollectionViewCell: UICollectionViewCell {
    
    // label
    @IBOutlet weak var volunteerName: UILabel!
    @IBOutlet weak var volunteerDate: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var volunteerNumber: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var volunteerCop: UILabel!
    @IBOutlet weak var copLabel: UILabel!
    @IBOutlet weak var volunteerLocation: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupFont()
    }

    private func setupFont() {
        volunteerName.font = UIFont(name: "Pretendard-Bold", size: 15)
        volunteerDate.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        dateLabel.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        volunteerNumber.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        numberLabel.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        volunteerCop.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        copLabel.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        volunteerLocation.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        locationLabel.font = UIFont(name: "Pretendard-SemiBold", size: 12)
    }
}
