//
//  HomeViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/29/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // label
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var volunteerTitleLabel: UILabel!
    @IBOutlet weak var volunteerSubLabel: UILabel!
    @IBOutlet weak var volunteer1: UILabel!
    @IBOutlet weak var volunteer2: UILabel!
    @IBOutlet weak var volunteer3: UILabel!
    @IBOutlet weak var adoptTitleLabel: UILabel!
    @IBOutlet weak var adoptSubLabel: UILabel!
    
    // button
    @IBOutlet weak var city1: UIButton!
    @IBOutlet weak var city2: UIButton!
    @IBOutlet weak var city3: UIButton!
    
    // view
    @IBOutlet weak var volunteerView: UIView!
    @IBOutlet weak var adoptCollectionView: UICollectionView!
    
    let adoptLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupFont()
        setupUI()
        
        adoptCollectionView.delegate = self
        adoptCollectionView.dataSource = self
        
        let adoptNib = UINib(nibName: "AdoptCollectionViewCell", bundle: nil)
        adoptCollectionView.register(adoptNib, forCellWithReuseIdentifier: "adoptCell")
        
        adoptLayout.scrollDirection = .horizontal
        adoptCollectionView.collectionViewLayout = adoptLayout
        
    }

    private func setupFont() {
        logoLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 24)
        subLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        volunteerTitleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        volunteerSubLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        volunteer1.font = UIFont(name: "Pretendard-Bold", size: 13)
        volunteer2.font = UIFont(name: "Pretendard-Bold", size: 13)
        volunteer3.font = UIFont(name: "Pretendard-Bold", size: 13)
        city1.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 10)
        city2.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 10)
        city3.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 10)
        adoptTitleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        adoptSubLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
    }
    
    private func setupUI() {
        volunteerView.layer.cornerRadius = 15
        volunteerView.layer.borderWidth = 1
        volunteerView.layer.borderColor = UIColor.textfieldBorder.cgColor
        
        city1.layer.cornerRadius = 10
        city1.layer.borderWidth = 1
        city1.layer.borderColor =  UIColor.cityLabel.cgColor
        
        city2.layer.cornerRadius = 10
        city2.layer.borderWidth = 1
        city2.layer.borderColor =  UIColor.cityLabel.cgColor
        
        city3.layer.cornerRadius = 10
        city3.layer.borderWidth = 1
        city3.layer.borderColor =  UIColor.cityLabel.cgColor
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 // 데이터 개수
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adoptCell", for: indexPath) as! AdoptCollectionViewCell
        
        cell.infoNameLabel.text = "Animal \(indexPath.row + 1)"
        cell.infoShelterLabel.text = "Shelter \(indexPath.row + 1)"
        cell.infoDateLabel.text = "2024-11-29"
        cell.speciesBtn.setTitle("Dog", for: .normal)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    // UICollectionView의 기본 동작을 필요에 따라 확장
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 133, height: 202) // 셀 크기
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20 // 열 간 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0) // 첫 번째 셀 왼쪽 16pt 여백 추가
    }
}
