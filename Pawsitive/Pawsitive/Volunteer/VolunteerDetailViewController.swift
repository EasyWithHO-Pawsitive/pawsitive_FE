//
//  VolunteerDetailViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit
import Alamofire

class VolunteerDetailViewController: UIViewController {
    
    // label
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDetailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberDetailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusDetailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationDetailLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startDetailLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var endDetailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var managerLabel: UILabel!
    @IBOutlet weak var managerDetailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneDetailLabel: UILabel!
    @IBOutlet weak var copLabel: UILabel!
    @IBOutlet weak var copDetailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressDetailLabel: UILabel!
    
    // button
    @IBOutlet weak var applyBtn: UIButton!
    
    // view
    @IBOutlet weak var detailView: UIView!
    
    var volunteerId: Int? // 이전 화면에서 전달받을 봉사 ID
    var volunteerDetail: VolunteerDetail? // 데이터를 전달받기 위한 속성
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        setupUI()
        
        fetchVolunteerDetail()
    }
    
    private func setupFont() {
        nameLabel.font = UIFont(name: "Pretendard-Bold", size: 18)
        dateLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        dateDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        numberLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        numberDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        statusLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        statusDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        locationLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        locationDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        startLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        startDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        endLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        endDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        
        contentLabel.font = UIFont(name: "Pretendard-Regular", size: 17)
        
        managerLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        managerDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        phoneLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        phoneDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        copLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        copDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        addressLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        addressDetailLabel.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        
        applyBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
    }
    
    private func setupUI() {
        detailView.layer.cornerRadius = 15
        detailView.layer.borderWidth = 1
        detailView.layer.borderColor = UIColor.textfieldBorder.cgColor
        
        applyBtn.layer.cornerRadius = 27.5
        
        // nameLabel의 trailing 설정
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20)
        ])
        
        // contentLabel의 레이아웃 설정
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: 24),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34)
        ])
    }
    
    private func fetchVolunteerDetail() {
        guard let volunteerId = volunteerId else {
            print("봉사 ID가 전달되지 않았습니다.")
            return
        }

        let endpoint = "/volunteer/\(volunteerId)"
        APIClient.getRequest(endpoint: endpoint, parameters: nil) { (result: Result<VolunteerDetailResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    DispatchQueue.main.async {
                        self.updateUI(with: response.result)
                    }
                } else {
                    print("봉사 상세 정보 요청 실패: \(response.message)")
                }
            case .failure(let error):
                print("API 호출 실패: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI(with detail: VolunteerDetail) {
        nameLabel.text = detail.title
        dateDetailLabel.text = detail.volunteerDate
        numberDetailLabel.text = "\(detail.numberOfStaffs)명"
        statusDetailLabel.text = detail.status
        locationDetailLabel.text = detail.region
        startDetailLabel.text = detail.startTime
        endDetailLabel.text = detail.endTime
        contentLabel.text = detail.content
        managerDetailLabel.text = detail.managerName
        phoneDetailLabel.text = detail.phone
        copDetailLabel.text = detail.shelterName
        addressDetailLabel.text = detail.address
    }
    
    // action
    @IBAction func backBtn(_ sender: Any) {
        guard let volunteerVC = storyboard?.instantiateViewController(withIdentifier: "VolunteerViewController") as? VolunteerViewController else {
            return
        }
        volunteerVC.modalPresentationStyle = .fullScreen
        present(volunteerVC, animated: true)
    }
    
    @IBAction func tapApply(_ sender: Any) {
        let alert = UIAlertController(title: "해당 봉사를 신청하시겠습니까?", message: "상세 내용을 한 번 더 확인해주세요.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(cancelAction)
        cancelAction.setValue(UIColor.cancelAlert, forKey: "titleTextColor")
        
        // 확인 액션
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.applyForVolunteer()
        }
        alert.addAction(confirmAction)
        confirmAction.setValue(UIColor.okAlert, forKey: "titleTextColor")
        
        alert.preferredAction = confirmAction
        
        present(alert, animated: true, completion: nil)
    }
    
    private func applyForVolunteer() {
        guard let volunteerId = volunteerId else {
            print("봉사 ID가 없습니다.")
            return
        }
        
        guard let userId = UserDefaults.standard.value(forKey: "loggedInUserId") as? Int else {
            print("로그인한 사용자 ID가 없습니다.")
            return
        }
        
        let endpoint = "/application"
        let parameters = VolunteerApplyRequest(id: userId, postId: volunteerId)
        
        APIClient.postRequest(endpoint: endpoint, parameters: parameters) { (result: Result<VolunteerApplyResponse, AFError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    if response.isSuccess {
                        let successAlert = UIAlertController(
                            title: "신청 완료",
                            message: "봉사 신청이 성공적으로 완료되었습니다.",
                            preferredStyle: .alert
                        )
                        successAlert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(successAlert, animated: true)
                    } else {
                        let failureAlert = UIAlertController(
                            title: "신청 실패",
                            message: response.message,
                            preferredStyle: .alert
                        )
                        failureAlert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(failureAlert, animated: true)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let errorAlert = UIAlertController(
                        title: "신청 실패",
                        message: "네트워크 오류가 발생했습니다. 다시 시도해주세요.",
                        preferredStyle: .alert
                    )
                    errorAlert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(errorAlert, animated: true)
                    print("API 호출 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}
