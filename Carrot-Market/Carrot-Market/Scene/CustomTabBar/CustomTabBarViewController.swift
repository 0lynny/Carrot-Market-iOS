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
        guard let homeViewController = UIStoryboard.init(name: "HomeStoryboard",               bundle:nil).instantiateViewController(withIdentifier:                        HomeViewController.className) as? HomeViewController,
              let myLocalViewController = UIStoryboard.init(name: "MyLocalStoryboard", bundle: nil).instantiateViewController(withIdentifier:              MyLocalViewController.className) as? MyLocalViewController,
              let nearbyViewController = UIStoryboard.init(name: "NearbyStoryboard", bundle: nil).instantiateViewController(withIdentifier:                 NearbyViewController.className) as? NearbyViewController,
              let chatsViewController = UIStoryboard.init(name: "ChatsStoryboard", bundle: nil).instantiateViewController(withIdentifier:                 ChatsViewController.className) as? ChatsViewController,
              let myCarrotViewController = UIStoryboard.init(name: "MyCarrotStoryboard", bundle: nil).instantiateViewController(withIdentifier:                 MyCarrotViewController.className) as? MyCarrotViewController
        else { return }
        
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .black
        
        homeViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_home" ), selectedImage:  UIImage(named: "icn_home_selected"))
        myLocalViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_myLocal"), selectedImage: UIImage(named: "icn_myLocal_selected"))
        nearbyViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_nearby"), selectedImage: UIImage(named: "icn_nearby_selected" ))
        chatsViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_chats"), selectedImage: UIImage(named: "icn_chats_selected" ))
        myCarrotViewController.tabBarItem = UITabBarItem (title: "", image: UIImage(named: "icn_myCarrot"), selectedImage: UIImage(named: "icn_myCarrot_selected" ))
        
        setViewControllers([homeViewController, myLocalViewController, nearbyViewController, chatsViewController, myCarrotViewController], animated: true)
    }
}


