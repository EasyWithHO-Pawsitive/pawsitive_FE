//
//  CustomTabBarViewController.swift
//  Pawsitive
//
//  Created by 성호은 on 11/29/24.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.buttonSelected
        self.tabBar.unselectedItemTintColor = UIColor.buttonSelected
        
        self.selectedIndex = 2 // 기본 로드 페이지는 홈
    }

}
