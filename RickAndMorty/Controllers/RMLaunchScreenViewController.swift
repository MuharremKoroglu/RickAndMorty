//
//  RMLaunchScreenViewController.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 25.08.2023.
//

import UIKit

class RMLaunchScreenViewController: UIViewController {

    private let launchScreen : RMLaunchScreenView
    private let userDefaults = UserDefaults.standard
    
    init() {
        self.launchScreen = RMLaunchScreenView(frame: .zero)
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpViews()
        launchScreenOperations() 

    }
    
    private func launchScreenOperations () {
        
        let isFirstLaunch = userDefaults.bool(forKey: "isFirstLaunch")
        
        if !isFirstLaunch {
            launchScreen.launchLabel.text = "Welcome!"
            userDefaults.set(true, forKey: "isFirstLaunch")

        } else {
            launchScreen.launchLabel.text = "Hello!"

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.goToTabController()
        }
        
    }
    
    private func goToTabController () {
        
        let mainViewController = RMTabBarController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setNavigationBarHidden(true, animated: true)
        self.present(navigationController, animated: false, completion: nil)
        
    }
    
    private func setUpViews () {
    
        view.addSubview(launchScreen)
        
        NSLayoutConstraint.activate([
        
            launchScreen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            launchScreen.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            launchScreen.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            launchScreen.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
    

}
