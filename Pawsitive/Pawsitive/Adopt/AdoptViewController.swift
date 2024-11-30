//
//  AdoptViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit

class AdoptViewController: UIViewController {
    
    // label
    @IBOutlet weak var adoptAdLabel: UILabel!
    @IBOutlet weak var adoptTitleLabel: UILabel!
    @IBOutlet weak var adoptSubLabel: UILabel!
    
    // view
    @IBOutlet weak var adoptListCollectionView: UICollectionView!
    
    let adoptListLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()

        // Nib 파일 등록
        let adoptListNib = UINib(nibName: "AdoptListCollectionViewCell", bundle: nil)
        adoptListCollectionView.register(adoptListNib, forCellWithReuseIdentifier: "adoptListCell")
        
        // Layout 설정
        adoptListLayout.scrollDirection = .vertical
        adoptListCollectionView.collectionViewLayout = adoptListLayout
        
        // DataSource와 Delegate 연결
        adoptListCollectionView.dataSource = self
        adoptListCollectionView.delegate = self
    }
    
    private func setupFont() {
        adoptAdLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        adoptTitleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        adoptSubLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
    }
}

// MARK: - UICollectionViewDataSource
extension AdoptViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // 데이터 개수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adoptListCell", for: indexPath) as? AdoptListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // 셀 데이터 설정
        cell.titleLabel.text = "Adopt \(indexPath.row + 1)"
        cell.speciesDetailLabel.text = "Dog"
        cell.shelterDetailLabel.text = "Seoul Shelter"
        cell.dateDetailLabel.text = "2024-11-29"
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AdoptViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 393, height: 140) // 셀 크기
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // 행 간 간격
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0 // 열 간 간격 (수직 방향이므로 0)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // 섹션 여백
//    }
}

// MARK: - UICollectionViewDelegate
extension AdoptViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Adopt \(indexPath.row + 1)")
    }
}
