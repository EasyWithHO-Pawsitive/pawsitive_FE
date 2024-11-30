//
//  HomeViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/29/24.
//

import UIKit
import Alamofire

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
    var volunteers: [Volunteer] = []
    var adoptions: [Adoption] = []
    
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
        
        fetchHomeData()
        
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
        
        // volunteer labels 설정
        let volunteerLabels = [volunteer1, volunteer2, volunteer3]
        volunteerLabels.forEach { label in
            guard let label = label else { return } // 옵셔널 해제
            label.translatesAutoresizingMaskIntoConstraints = false
            label.lineBreakMode = .byTruncatingTail // ... 처리
            label.trailingAnchor.constraint(equalTo: volunteerView.trailingAnchor, constant: -22).isActive = true
            label.numberOfLines = 1 // 한 줄로 제한
        }
    }
    
    private func fetchHomeData() {
        APIClient.getRequest(endpoint: "/main", parameters: nil) { (result: Result<VolunteerAdoptionResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    DispatchQueue.main.async {
                        self.volunteers = response.result.volunteers
                        self.adoptions = response.result.adoptions
                        self.updateUIWithData()
                    }
                } else {
                    print("Failed to fetch data: \(response.message)")
                }
            case .failure(let error):
                print("API call failed: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUIWithData() {
        // Update volunteers data
        if volunteers.count > 0 {
            volunteer1.text = volunteers[safe: 0]?.title ?? ""
            city1.setTitle(volunteers[safe: 0]?.region ?? "Unknown", for: .normal)
        }
        if volunteers.count > 1 {
            volunteer2.text = volunteers[safe: 1]?.title ?? ""
            city2.setTitle(volunteers[safe: 1]?.region ?? "Unknown", for: .normal)
        }
        if volunteers.count > 2 {
            volunteer3.text = volunteers[safe: 2]?.title ?? ""
            city3.setTitle(volunteers[safe: 2]?.region ?? "Unknown", for: .normal)
        }
        
        // Reload collection view for adoptions
        adoptCollectionView.reloadData()
    }

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adoptions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adoptCell", for: indexPath) as! AdoptCollectionViewCell
        
        let adoption = adoptions[safe: indexPath.row]
        cell.infoNameLabel.text = adoption?.specType ?? ""
        cell.infoShelterLabel.text = adoption?.shelterName ?? ""
        
        // 날짜를 변환하여 표시
        if let createdAt = adoption?.createdAt {
            cell.infoDateLabel.text = createdAt.toFormattedDateString()
        } else {
            cell.infoDateLabel.text = "Unknown"
        }
        
        cell.speciesBtn.setTitle(adoption?.type ?? "", for: .normal)
        
        // 이미지 설정
        switch indexPath.row {
        case 0:
            cell.infoImg.image = UIImage(named: "cat1")
        case 1:
            cell.infoImg.image = UIImage(named: "cat2")
        case 2:
            cell.infoImg.image = UIImage(named: "dog1")
        default:
            cell.infoImg.image = nil // 기본값
        }
        
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

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension String {
    /// 날짜 문자열을 "yyyy-MM-dd" 형식으로 변환
    func toFormattedDateString() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS" // 서버에서 전달된 형식
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // 서버 형식에 맞는 로케일
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd" // 표시하고자 하는 형식
        
        // 문자열 -> Date -> 원하는 형식의 문자열
        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        }
        
        // 변환 실패 시 원본 반환
        return self
    }
}
