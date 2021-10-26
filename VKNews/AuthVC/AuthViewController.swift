//
//  ViewController.swift
//  VKNews
//
//  Created by Антон Усов on 26.10.2021.
//

import UIKit
import VK_ios_sdk

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
        
        view.backgroundColor = .systemOrange
    }

    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

