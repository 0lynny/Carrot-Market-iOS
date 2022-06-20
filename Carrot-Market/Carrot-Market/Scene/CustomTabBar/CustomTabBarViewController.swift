//
//  CustomTabBarViewController.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/01.
//

import UIKit

final class CustomTabBarViewContorller: UITabBarController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarController()
    }

    // MARK: - Functions
    func setTabBarController(){
        
//        let homeViewController = makeNavigationController(
//            unselectedImage: UIImage(named: "icn_home" ),
//            selectedImage: UIImage(named: "icn_home" ),
//            rootViewController: HomeViewController(), title: "홈")
//
//        let myLocalViewController = makeNavigationController(
//            unselectedImage: UIImage(named: "icn_home" ),
//            selectedImage: UIImage(named: "icn_home" ),
//            rootViewController: MyLocalViewController(), title: "동네생활")
//
//        let nearbyViewController = makeNavigationController(
//            unselectedImage: UIImage(named: "icn_home" ),
//            selectedImage: UIImage(named: "icn_home" ),
//            rootViewController: NearbyViewController(), title: "내 근처")
//
//        let chatsViewController = makeNavigationController(
//            unselectedImage: UIImage(named: "icn_home" ),
//            selectedImage: UIImage(named: "icn_home" ),
//            rootViewController: ChatsViewController(), title: "채팅")
//
//        let myCarrotViewController = makeNavigationController(
//            unselectedImage: UIImage(named: "icn_home" ),
//            selectedImage: UIImage(named: "icn_home" ),
//            rootViewController: MyCarrotViewController(), title: "나의 당근")
        
        
        guard let homeViewController = UIStoryboard.init(name: "HomeStoryboard",               bundle:nil).instantiateViewController(withIdentifier:                        HomeViewController.className) as? HomeViewController,
              let myLocalViewController = UIStoryboard.init(name: "MyLocalStoryboard", bundle: nil).instantiateViewController(withIdentifier:              MyLocalViewController.className) as? MyLocalViewController,
              let nearbyViewController = UIStoryboard.init(name: "NearbyStoryboard", bundle: nil).instantiateViewController(withIdentifier:                 NearbyViewController.className) as? NearbyViewController,
              let chatsViewController = UIStoryboard.init(name: "ChatsStoryboard", bundle: nil).instantiateViewController(withIdentifier:                 ChatsViewController.className) as? ChatsViewController,
              let myCarrotViewController = UIStoryboard.init(name: "MyCarrotStoryboard", bundle: nil).instantiateViewController(withIdentifier:                 MyCarrotViewController.className) as? MyCarrotViewController
        else { return }
        
        let homeNavigationViewController = UINavigationController(rootViewController: homeViewController)
        
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .black
        
        homeViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_home" ), selectedImage:  UIImage(named: "icn_home_selected"))
        myLocalViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_myLocal"), selectedImage: UIImage(named: "icn_myLocal_selected"))
        nearbyViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_nearby"), selectedImage: UIImage(named: "icn_nearby_selected" ))
        chatsViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_chats"), selectedImage: UIImage(named: "icn_chats_selected" ))
        myCarrotViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_myCarrot"), selectedImage: UIImage(named: "icn_myCarrot_selected" ))

        setViewControllers([homeNavigationViewController, myLocalViewController, nearbyViewController, chatsViewController, myCarrotViewController], animated: true)
    }
    
    private func makeNavigationController(unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController, title: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.title = title
        nav.navigationBar.tintColor = .black
        nav.navigationBar.backgroundColor = .white
        nav.isNavigationBarHidden = true
        nav.navigationBar.isHidden = true
        
        nav.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        nav.navigationItem.backBarButtonItem?.tintColor = .black
        return nav
    }
}


