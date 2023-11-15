//
//  ViewController.swift
//  SwiftNetworkLayer
//
//  Created by macbook pro on 15.11.2023.
//

import UIKit

class homeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let endpoint = EndPoint.getUsers
        
        NetworkManager.shared.getUser { result in
            switch result {
            case .success(let users):
                users.forEach { user in
                    print(user.name)
                }
            case .failure(let err):
                print(err)
            }
        }
        
    }


}

