//
//  MainTabBarController.swift
//  CarrotHomeTab
//
//  Created by 백소망 on 2022/09/23.
//

import UIKit

// 탭이 눌릴 때마다 그에 맞는 navigationBar 구성하고 싶어요
// - 탭이 눌리는 것을 감지
// - 감지 후에, 그 탭에 맞게 navigationBar 구성을 업데이트

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 탭이 눌리는 것을 감지
        delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateNavigationItem(vc: self.selectedViewController!)
        
    }
    
    private func updateNavigationItem(vc: UIViewController) {
        switch vc {
        case is HomeViewController:
            
            let titleConfig = CustomBarItemConfiguration(
                title: "정자동",
                handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let searchConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "magnifyingglass"),
                handler: { print("---> search tapped") })
            let searchItem = UIBarButtonItem.generate(with: searchConfig, width: 30)
            
            let feedConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "bell"),
                handler: { print("---> feed tapped") })
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem, searchItem]
            navigationItem.backButtonDisplayMode = .minimal     // 타이틀 말고 아이콘만 보여짐
            
        case is MyTownViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "정자동",
                handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let feedConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "bell"),
                handler: { print("---> feed tapped") })
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            navigationItem.backButtonDisplayMode = .minimal
        case is ChatViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "채팅",
                handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let feedConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "bell"),
                handler: { print("---> feed tapped") })
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is MyProfileViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "나의 당근",
                handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let settingConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "gearshape"),
                handler: { print("---> setting tapped") })
            let settingItem = UIBarButtonItem.generate(with: settingConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [settingItem]
        default:
            let titleConfig = CustomBarItemConfiguration(
                title: "정자동",
                handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = []
            navigationItem.backButtonDisplayMode = .minimal 
        }
    }
}

// 각 탭에 맞게 네비게이션 바 아이템 구성하기
// - 홈: 타이틀, 피드, 서치 ✅
// - 동네활동: 타이틀, 피드 ✅
// - 내 근처: 타이틀 ✅
// - 채팅: 타이틀, 피드 ✅
// - 나의 당근: 타이틀, 설정 ✅

extension MainTabBarController: UITabBarControllerDelegate {
    
    // 탭이 눌리는 것을 감지
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        updateNavigationItem(vc: viewController)
        
    }
}
