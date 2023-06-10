//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import UIKit

class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
    }
    
    private func setUpTabBar () {
        
        let characterVC = RMCharacterViewController()
        let episodeVC = RMEpisodeViewController()
        
        characterVC.title = "Characters"
        episodeVC.title = "Episodes"
        
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
    
        let characterVCNavigation = UINavigationController(rootViewController: characterVC)
        let episodeVCNavigation = UINavigationController(rootViewController: episodeVC)
        
        characterVCNavigation.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        episodeVCNavigation.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 2)
        
        for navigation in [characterVCNavigation,episodeVCNavigation] {
            navigation.navigationBar.prefersLargeTitles = true
            
        }
        setViewControllers([characterVCNavigation,episodeVCNavigation], animated: true)

    }


}

