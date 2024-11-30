//
//  VolunteerViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit

class VolunteerViewController: UIViewController {

    // label
    @IBOutlet weak var volunteerAskLabel: UILabel!
    @IBOutlet weak var volunteerTitleLabel: UILabel!
    @IBOutlet weak var volunteerSubLabel: UILabel!
    
    // view
    @IBOutlet weak var volunteerCollectionView: UICollectionView!
    
    let volunteerListLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        
        volunteerCollectionView.delegate = self
        volunteerCollectionView.dataSource = self
        
        let volunteerListNib = UINib(nibName: "VolunteerListCollectionViewCell", bundle: nil)
        volunteerCollectionView.register(volunteerListNib, forCellWithReuseIdentifier: "volunteerCell")
        
        volunteerListLayout.scrollDirection = .vertical
        volunteerCollectionView.collectionViewLayout = volunteerListLayout
    }
    
    private func setupFont() {
        volunteerAskLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        volunteerTitleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        volunteerSubLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
    }
}

// MARK: - UICollectionViewDataSource
extension VolunteerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 // 데이터 개수
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "volunteerCell", for: indexPath) as! VolunteerListCollectionViewCell
        
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth  = 1
        cell.layer.borderColor  = UIColor.textfieldBorder.cgColor
        
        // 셀 데이터 설정
        cell.volunteerName.text = "Volunteer \(indexPath.row + 1)"
        cell.volunteerDate.text = "2024-11-29"
        cell.dateLabel.text = "Date"
        cell.volunteerNumber.text = "10"
        cell.numberLabel.text = "Participants"
        cell.volunteerCop.text = "Animal Care"
        cell.copLabel.text = "Task"
        cell.volunteerLocation.text = "Seoul"
        cell.locationLabel.text = "Location"
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension VolunteerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Volunteer \(indexPath.row + 1)")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension VolunteerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 353, height: 124) // 셀 크기
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25 // 행 간 간격 (상하)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 16 // 열 간 간격
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 13, left: 0, bottom: 0, right: 0) // 섹션 여백
//    }
}
