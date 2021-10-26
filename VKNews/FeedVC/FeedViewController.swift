//
//  FeedViewController.swift
//  VKNews
//
//  Created by Антон Усов on 26.10.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        networkService.getFeed()
    }
    

  

}
