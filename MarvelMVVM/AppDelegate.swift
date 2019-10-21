//
//  AppDelegate.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 7/25/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let characterService = CharacterService()
        let heroesViewModel = HeroesViewModel(characterService: characterService)
        let heroesViewController = HeroesViewController(heroesViewModel: heroesViewModel)
        let navigationController = UINavigationController(rootViewController: heroesViewController)
        
        navigationController.navigationBar.isTranslucent = true
        
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        self.window?.frame = UIScreen.main.bounds
        self.window?.rootViewController = navigationController
        
        return true
    }
}

