//
//  SplashScreenViewController.swift
//  RickAndMortyApp
//
//  Created by Emre Can Şimşek on 24.04.2023.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
                
        if firstLaunch {
            welcomeLabel.text = "Welcome!"
            UserDefaults.standard.set(false, forKey: "isFirstLaunch")
        }else{
            welcomeLabel.text = "Hello!"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.goToHomePage()
        }
    }
    
    func goToHomePage(){
        performSegue(withIdentifier: "toHomePage", sender: nil)
    }
}


