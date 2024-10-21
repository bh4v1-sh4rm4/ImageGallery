//
//  ViewController.swift
//  ImageGallery
//
//  Created by Bhavishya Sharma on 20/10/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfUsername : UITextField!
    @IBOutlet weak var tfPassword : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTF()
    }

    private func configureTF() {
        tfUsername.layer.borderColor = UIColor.black.cgColor
        tfPassword.layer.borderColor = UIColor.black.cgColor
        tfUsername.layer.borderWidth = 1
        tfPassword.layer.borderWidth = 1
        tfUsername.layer.cornerRadius = 10
        tfPassword.layer.cornerRadius = 10
    }
    @IBAction func btnActionLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

