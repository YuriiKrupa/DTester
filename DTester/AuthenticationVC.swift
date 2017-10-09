//
//  AuthenticationVC.swift
//  DTester
//
//  Created by ITA student on 10/9/17.
//  Copyright © 2017 Yurii Kupa. All rights reserved.
//

import UIKit

class AuthenticationVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func logInBtn(_ sender: Any) {
        let query = HTTPManager()
        query.post(username: userNameTF.text!, password: passwordTF.text!)
        
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        let query = HTTPManager()
        query.get()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

