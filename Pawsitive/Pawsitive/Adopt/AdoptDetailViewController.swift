//
//  AdoptDetailViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit
import Alamofire

class AdoptDetailViewController: UIViewController {
    
    // image
    @IBOutlet weak var adoptImg: UIImageView!
    
    // label
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var speciesDetailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderDetailLabel: UILabel!
    @IBOutlet weak var neuterLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageDetailLabel: UILabel!
    @IBOutlet weak var specialLabel: UILabel!
    @IBOutlet weak var specialContentLabel: UILabel!
    @IBOutlet weak var shelterLabel: UILabel!
    @IBOutlet weak var shelterDetailLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDetailLabel: UILabel!
    @IBOutlet weak var managerLabel: UILabel!
    @IBOutlet weak var managerDetailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneDetailLabel: UILabel!
    @IBOutlet weak var cautionLabel: UILabel!
    
    // button
    @IBOutlet weak var speciesBtn: UIButton!
    
    var postId: Int? // 전달받을 postId
    var adoptImages = ["adopt1", "adopt2", "adopt3", "adopt4", "adopt5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        setupUI()
        
        fetchAdoptionDetail()
    }
    
    private func setupFont() {
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        speciesDetailLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        speciesBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 10)
        genderLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        genderDetailLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        neuterLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        ageLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        ageDetailLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        specialLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        specialContentLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        shelterLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        shelterDetailLable.font = UIFont(name: "Pretendard-Regular", size: 16)
        dateLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        dateDetailLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        managerLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        managerDetailLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        phoneLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        phoneDetailLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        cautionLabel.font = UIFont(name: "Pretendard-Medium", size: 11)
    }
    
    private func setupUI() {
        speciesBtn.layer.cornerRadius = 10
        speciesBtn.layer.borderWidth = 1
        speciesBtn.layer.borderColor = UIColor.cityLabel.cgColor
    }
    
    private func fetchAdoptionDetail() {
        guard let postId = postId else {
            print("postId가 전달되지 않았습니다.")
            return
        }
        
        let endpoint = "/adoption/\(postId)"
        APIClient.getRequest(endpoint: endpoint, parameters: nil) { (result: Result<AdoptionDetailResponse, AFError>) in
            switch result {
            case .success(let response):
                print("API 응답 데이터: \(response)") // JSON 디버깅
                if response.isSuccess, let adoptionDetail = response.result {
                    DispatchQueue.main.async {
                        self.updateUI(with: adoptionDetail)
                    }
                } else {
                    print("입양 상세 정보 요청 실패: \(response.message)")
                }
            case .failure(let error):
                print("API 호출 실패: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI(with detail: AdoptionDetail?) {
        guard let detail = detail else { return }
        
        titleLabel.text = detail.title
        speciesDetailLabel.text = detail.specType
        genderDetailLabel.text = detail.gender
        neuterLabel.text = detail.neutering ? "(중성화 O)" : "(중성화 X)"
        ageDetailLabel.text = detail.age
        specialContentLabel.text = detail.description
        shelterDetailLable.text = detail.shelterName
        dateDetailLabel.text = detail.createdAt
        managerDetailLabel.text = detail.mangerName // "mangerName" 사용
        phoneDetailLabel.text = detail.phone
        
        let imageIndex = (detail.id - 1) % adoptImages.count
        adoptImg.image = UIImage(named: adoptImages[imageIndex])
    }
    
    // action
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
