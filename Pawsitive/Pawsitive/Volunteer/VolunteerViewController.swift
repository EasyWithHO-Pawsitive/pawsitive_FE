//
//  VolunteerViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit
import Alamofire

class VolunteerViewController: UIViewController {

    // label
    @IBOutlet weak var volunteerAskLabel: UILabel!
    @IBOutlet weak var volunteerTitleLabel: UILabel!
    @IBOutlet weak var volunteerSubLabel: UILabel!
    
    // view
    @IBOutlet weak var volunteerCollectionView: UICollectionView!
    
    let volunteerListLayout = UICollectionViewFlowLayout()
    var volunteers: [VolunteerItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        
        volunteerCollectionView.delegate = self
        volunteerCollectionView.dataSource = self
        
        let volunteerListNib = UINib(nibName: "VolunteerListCollectionViewCell", bundle: nil)
        volunteerCollectionView.register(volunteerListNib, forCellWithReuseIdentifier: "volunteerCell")
        
        volunteerListLayout.scrollDirection = .vertical
        volunteerCollectionView.collectionViewLayout = volunteerListLayout
        
        fetchVolunteerData() // 데이터 가져오기
    }
    
    private func setupFont() {
        volunteerAskLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        volunteerTitleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        volunteerSubLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
    }
    
    private func fetchVolunteerData() {
        APIClient.getRequest(endpoint: "/volunteer", parameters: nil) { (result: Result<VolunteerResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    DispatchQueue.main.async {
                        self.volunteers = response.result.volunteers
                        self.volunteerCollectionView.reloadData()
                    }
                } else {
                    print("Failed to fetch volunteers: \(response.message)")
                }
            case .failure(let error):
                print("API call failed: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension VolunteerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return volunteers.count // 데이터 개수
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "volunteerCell", for: indexPath) as! VolunteerListCollectionViewCell
        
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth  = 1
        cell.layer.borderColor  = UIColor.textfieldBorder.cgColor
        
        // 셀 데이터 설정
        let volunteer = volunteers[safe: indexPath.row]
        cell.volunteerName.text = volunteer?.title ?? "Unknown Volunteer"
        cell.dateLabel.text = volunteer?.date ?? "Unknown Date"
        cell.numberLabel.text = "\(volunteer?.numberOfStaffs ?? 0)명"
        cell.copLabel.text = volunteer?.shelterName ?? "Unknown Shelter"
        cell.locationLabel.text = volunteer?.region ?? "Unknown Location"
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension VolunteerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let volunteer = volunteers[safe: indexPath.row] else { return }
        
        // 봉사 상세 화면으로 이동
        fetchVolunteerDetail(postId: volunteer.id)
    }
    
    private func fetchVolunteerDetail(postId: Int) {
        let endpoint = "/volunteer/\(postId)"
        
        APIClient.getRequest(endpoint: endpoint, parameters: nil) { (result: Result<VolunteerDetailResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    DispatchQueue.main.async {
                        // 데이터가 로드되면 상세 화면으로 이동
                        self.navigateToDetail(with: response.result)
                    }
                } else {
                    print("Failed to fetch volunteer detail: \(response.message)")
                }
            case .failure(let error):
                print("API call failed: \(error.localizedDescription)")
            }
        }
    }
    
    private func navigateToDetail(with detail: VolunteerDetail) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "VolunteerDetailViewController") as? VolunteerDetailViewController else {
            return
        }

        // 봉사 상세 데이터를 전달
        detailVC.volunteerId = detail.id // volunteerId 전달
        detailVC.volunteerDetail = detail // 상세 데이터도 전달
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
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
}
