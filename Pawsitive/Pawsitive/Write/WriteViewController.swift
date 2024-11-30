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

    var shelterInfos: [Shelter] = [] // 보호소 리스트 데이터
    var pickerView = UIPickerView()
    var toolbar: UIToolbar!
    var selectedShelter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFont()
        setupUI()
        
        setupPickerView()
        loadShelters() // 보호소 데이터를 로드
        
        // 초기 버튼 색상 설정
        registerBtn.backgroundColor = .buttonUnselected
        registerBtn.isEnabled = false
        
        // TextField Delegate 설정
        titleTextField.delegate = self
        dateTextField.delegate = self
        numberTextField.delegate = self
        startTextField.delegate = self
        finishTextField.delegate = self
        detailTextField.delegate = self
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
    
    private func loadShelters() {
        APIClient.getRequest(endpoint: "/shelter") { (result: Result<ShelterResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    self.shelterInfos = response.result.shelterInfos
                    self.pickerView.reloadAllComponents() // UIPickerView 새로고침
                } else {
                    print("Error: \(response.message)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
                // 원시 응답 데이터를 출력
                if let data = error.underlyingError as? URLError {
                    print("Underlying Error: \(data)")
                }
            }
        }
    }
    
    private func updateRegisterButtonState() {
        let isShelterSelected = selectedShelter != nil
        let isTitleValid = !(titleTextField.text?.isEmpty ?? true)
        let isDateValid = !(dateTextField.text?.isEmpty ?? true)
        let isNumberValid = !(numberTextField.text?.isEmpty ?? true) && Int(numberTextField.text ?? "") != nil
        let isStartTimeValid = !(startTextField.text?.isEmpty ?? true)
        let isEndTimeValid = !(finishTextField.text?.isEmpty ?? true)
        let isContentValid = !(detailTextField.text?.isEmpty ?? true)

        let allFieldsValid = isShelterSelected && isTitleValid && isDateValid &&
                             isNumberValid && isStartTimeValid && isEndTimeValid && isContentValid

        registerBtn.backgroundColor = allFieldsValid ? .buttonSelected : .buttonUnselected
        registerBtn.isEnabled = allFieldsValid
    }
    
    @IBAction func tapShelter(_ sender: Any) {
        pickerView.isHidden = false
        toolbar.isHidden = false
    }
    
    @objc func donePicking() {
        // 선택한 값 설정
        selectShelterBtn.setTitle(selectedShelter ?? "보호소를 선택하세요", for: .normal)
        selectShelterBtn.setTitleColor(.black, for: .normal)
        
        // PickerView 및 Toolbar 숨기기
        pickerView.isHidden = true
        toolbar.isHidden = true
        
        updateRegisterButtonState()
    }
    
    private func postVolunteer() {
        // 유효성 검사
        guard let shelter = shelterInfos.first(where: { $0.name == selectedShelter }),
              let title = titleTextField.text, !title.isEmpty,
              let date = dateTextField.text, !date.isEmpty,
              let numberOfStaffsText = numberTextField.text, let numberOfStaffs = Int(numberOfStaffsText),
              let startTime = startTextField.text, !startTime.isEmpty,
              let endTime = finishTextField.text, !endTime.isEmpty,
              let content = detailTextField.text, !content.isEmpty else {
            print("모든 필드를 입력해주세요.")
            return
        }
        
        // 요청 데이터 생성
        let request = VolunteerPostRequest(
            shelterId: shelter.id,
            title: title,
            volunteerDate: date,
            numberOfStaffs: numberOfStaffs,
            startTime: startTime,
            endTime: endTime,
            content: content
        )
        
        // API 요청
        APIClient.postRequest(endpoint: "/volunteer/post", parameters: request) { (result: Result<VolunteerPostResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("봉사 게시글 작성 성공: ID \(response.result?.id ?? -1)")
                    self.showAlert(title: "성공", message: "봉사 게시글이 등록되었습니다.") {
                        if let tabBarController = self.tabBarController as? CustomTabBarViewController {
                            tabBarController.selectedIndex = 2
                        }
                    }
                } else {
                    print("서버 에러: \(response.message)")
                    self.showAlert(title: "오류", message: response.message)
                }
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
                self.showAlert(title: "오류", message: "서버와 통신에 실패했습니다.")
            }
        }
    }
    
    @IBAction func registerVolunteer(_ sender: Any) {
        postVolunteer()
    }
    
    // 알림창 표시 메서드
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // 확인 액션 추가
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        }
        confirmAction.setValue(UIColor.okAlert, forKey: "titleTextColor") // 버튼 색상 적용
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
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
        return shelterInfos[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedShelter = shelterInfos[row].name
        updateRegisterButtonState()
    }
}

extension WriteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.updateRegisterButtonState()
        }
        return true
    }
}
