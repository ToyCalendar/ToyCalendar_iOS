//
//  ViewController.swift
//  ToyCalendar
//
//  Created by sdondon on 23/12/2018.
//  Copyright © 2018 YAPP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.present(loginViewController, animated: true, completion: nil)
    }

}

