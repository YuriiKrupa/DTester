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
    
    @IBOutlet weak var logInLB: UILabel! //Just for debug
    
//    let dataManager = DataManager.dataManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func logInBtn(_ sender: Any) {
//        let query = HTTPManager()
//        query.post(username: userNameTF.text!, password: passwordTF.text!)
//        query.post(username: userNameTF.text!, password: passwordTF.text!) { (user, cookie) in
        HTTPManager().post(username: userNameTF.text!, password: passwordTF.text!) { (user, cookie) in
            if user.id == "-1" {
                self.showWarningMsg("ALARM")
            } else {
//                self.performSegue(withIdentifier: "granted", sender: (loginResponse, cookieResponse))
                self.logInLB.text = user.username
                print("\nCOOKIE MAIN",cookie,"\n\n")
//                HTTPManager().getFaculties(cookie)
//                UserDefaults.standard.set(cookie, forKey: "cookie")
                UserDefaults.standard.set((cookie.first?.value)!, forKey: "cookieValue")
                UserDefaults.standard.set(true, forKey: "isLogIn")
//                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.synchronize()
                
                //UserDefaults.standard.set(cookie, forKey: "cookie")
            }
        }
    }
    
    @IBAction func logOutBtn(_ sender: Any) { //BTN FIRE
//        if UserDefaults.standard.bool(forKey: "isLogIn") == true { HTTPManager().getFaculties(cook: UserDefaults.standard.value(forKey: "cookieValue") as? String)}
        //        HTTPManager().userLogout()
//        UserDefaults.standard.removeObject(forKey: <#T##String#>)
//        print("USERNAME: ",UserDefaults.standard.string(forKey: "username"))
//        print("Cookie: ", UserDefaults.standard.string(forKey: "cookie"))
        HTTPManager().getFaculties(UserDefaults.standard.string(forKey: "cookieValue")!)
        
    }
    
    private func showWarningMsg(_ textMsg: String) {
        let alert = UIAlertController(title: "Warning!", message: textMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

