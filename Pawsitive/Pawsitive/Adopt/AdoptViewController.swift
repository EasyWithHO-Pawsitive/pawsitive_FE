//
//  AdoptViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit
import Alamofire

class AdoptViewController: UIViewController {
    
    // label
    @IBOutlet weak var adoptAdLabel: UILabel!
    @IBOutlet weak var adoptTitleLabel: UILabel!
    @IBOutlet weak var adoptSubLabel: UILabel!
    
    // view
    @IBOutlet weak var adoptListCollectionView: UICollectionView!
    
    let adoptListLayout = UICollectionViewFlowLayout()
    var adoptions: [AdoptionItem] = [] // API 데이터 저장
    let adoptImages = ["adopt1", "adopt2", "adopt3", "adopt4", "adopt5"]
    
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
        
        fetchAdoptions()
    }
    
    private func setupFont() {
        adoptAdLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        adoptTitleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        adoptSubLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
    }
    
    private func fetchAdoptions() {
        APIClient.getRequest(endpoint: "/adoption", parameters: nil) { (result: Result<AdoptionResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    DispatchQueue.main.async {
                        self.adoptions = response.result.adoptions
                        self.adoptListCollectionView.reloadData()
                    }
                } else {
                    print("API 호출 실패: \(response.message)")
                }
            case .failure(let error):
                print("네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension AdoptViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adoptions.count // 데이터 개수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adoptListCell", for: indexPath) as? AdoptListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // 데이터 매핑
        let adoption = adoptions[indexPath.row]
        cell.titleLabel.text = adoption.title
        cell.speciesDetailLabel.text = adoption.specType
        cell.shelterDetailLabel.text = adoption.shelterName
        cell.dateDetailLabel.text = adoption.createdAt
        
        // adoptImg에 이미지 설정
        if indexPath.row < adoptImages.count {
            cell.adoptImg.image = UIImage(named: adoptImages[indexPath.row])
        } else {
            cell.adoptImg.image = UIImage(named: "default_placeholder") // 기본 이미지
        }
        
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
}

// MARK: - UICollectionViewDelegate
extension AdoptViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "AdoptDetailViewController") as? AdoptDetailViewController else {
            return
        }
        
        // 선택한 입양 ID를 전달
        detailVC.postId = adoptions[indexPath.row].id
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
}
