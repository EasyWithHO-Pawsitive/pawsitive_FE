//
//  WriteViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import UIKit
import Alamofire

class WriteViewController: UIViewController {
    
    // label
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var shelterLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // textfield
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var finishTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    
    // button
    @IBOutlet weak var selectShelterBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!

    let shelterInfos = [
        ["id": 1, "name": "(사)동물권자유너와"],
        ["id": 2, "name": "동물자원과(유기동물보호소)"],
        ["id": 3, "name": "경기도 도우미견나눔센터"],
        ["id": 4, "name": "서초구립 방배유스센터"],
        ["id": 5, "name": "안다"],
        ["id": 6, "name": "사천시 동물보호센터"],
        ["id": 7, "name": "통영시 동물보호센터"],
        ["id": 8, "name": "옥천시 동물보호센터"]
    ]
    
    var pickerView = UIPickerView()
    var toolbar: UIToolbar!
    var selectedShelter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        setupUI()
        setupPickerView()
    }
    
    private func setupFont() {
        introduceLabel.font = UIFont(name: "Pretendard-Bold", size: 18)
        shelterLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        dateLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        numberLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        startLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        finishLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        detailLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        registerBtn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
    }
    
    private func setupUI() {
        selectShelterBtn.layer.cornerRadius = 10
        selectShelterBtn.layer.borderWidth = 1
        selectShelterBtn.layer.borderColor = UIColor.textfieldBorder.cgColor
        selectShelterBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        titleTextField.borderStyle = .none // 기본 설정 제거
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        titleTextField.clipsToBounds = true
        titleTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        titleTextField.leftViewMode = .always
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "제목을 입력해주세요",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 13)!
            ]
        )
        
        dateTextField.borderStyle = .none // 기본 설정 제거
        dateTextField.layer.cornerRadius = 10
        dateTextField.layer.borderWidth = 1
        dateTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        dateTextField.clipsToBounds = true
        dateTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        dateTextField.leftViewMode = .always
        dateTextField.attributedPlaceholder = NSAttributedString(
            string: "봉사 날짜를 입력해주세요",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 13)!
            ]
        )
        
        numberTextField.borderStyle = .none // 기본 설정 제거
        numberTextField.layer.cornerRadius = 10
        numberTextField.layer.borderWidth = 1
        numberTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        numberTextField.clipsToBounds = true
        numberTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        numberTextField.leftViewMode = .always
        numberTextField.attributedPlaceholder = NSAttributedString(
            string: "봉사 인원을 입력해주세요",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 13)!
            ]
        )
        
        startTextField.borderStyle = .none // 기본 설정 제거
        startTextField.layer.cornerRadius = 10
        startTextField.layer.borderWidth = 1
        startTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        startTextField.clipsToBounds = true
        startTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        startTextField.leftViewMode = .always
        startTextField.attributedPlaceholder = NSAttributedString(
            string: "HH:MM",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 13)!
            ]
        )
        
        finishTextField.borderStyle = .none // 기본 설정 제거
        finishTextField.layer.cornerRadius = 10
        finishTextField.layer.borderWidth = 1
        finishTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        finishTextField.clipsToBounds = true
        finishTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        finishTextField.leftViewMode = .always
        finishTextField.attributedPlaceholder = NSAttributedString(
            string: "HH:MM",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 13)!
            ]
        )
        
        detailTextField.borderStyle = .none // 기본 설정 제거
        detailTextField.layer.cornerRadius = 10
        detailTextField.layer.borderWidth = 1
        detailTextField.layer.borderColor = UIColor.textfieldBorder.cgColor
        detailTextField.clipsToBounds = true
        detailTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0)) // padding
        detailTextField.leftViewMode = .always
        detailTextField.attributedPlaceholder = NSAttributedString(
            string: "봉사활동 내용에 대해 자세히 적어주세요",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 13)!
            ]
        )
        
        registerBtn.layer.cornerRadius = 27.5
    }
    
    private func setupPickerView() {
        // PickerView 설정
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.isHidden = true
        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Toolbar 설정
        toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.isHidden = true
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(donePicking))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([space, doneButton], animated: false)
        view.addSubview(toolbar)
        
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: pickerView.topAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @IBAction func tapShelter(_ sender: Any) {
        pickerView.isHidden = false
        toolbar.isHidden = false
    }
    
    @objc func donePicking() {
        // 선택한 값 설정
        selectShelterBtn.setTitle(selectedShelter ?? "보호소를 선택하세요", for: .normal)
        
        // 버튼 텍스트 색상을 검정색으로 설정
        selectShelterBtn.setTitleColor(.black, for: .normal)
        
        // PickerView 및 Toolbar 숨기기
        pickerView.isHidden = true
        toolbar.isHidden = true
    }
    
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension WriteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shelterInfos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shelterInfos[row]["name"] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedShelter = shelterInfos[row]["name"] as? String
    }
}
