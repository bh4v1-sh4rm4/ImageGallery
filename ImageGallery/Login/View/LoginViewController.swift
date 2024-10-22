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
        tfUsername.layer.borderColor = UIColor.systemIndigo.cgColor
        tfPassword.layer.borderColor = UIColor.systemIndigo.cgColor
        tfUsername.textColor = .white
        tfPassword.textColor = .white
        let usernameText = "username"
        tfUsername.attributedPlaceholder = NSAttributedString(
            string: usernameText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        let passwordText = "password"
        tfPassword.attributedPlaceholder = NSAttributedString(
            string: passwordText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        tfUsername.layer.borderWidth = 1
        tfPassword.layer.borderWidth = 1
        tfUsername.layer.cornerRadius = 10
        tfPassword.layer.cornerRadius = 10
    }
    
    private func navigate(){
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showErrorDialog() {
        DispatchQueue.main.async{
            let alert = UIAlertController(title: "Wrong Credentials!", message: "username: hello@123, password: hello@123. Go Ahead!", preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
                self.dismiss(animated: true)
            }
            
            alert.addAction(retryAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnActionLogin(_ sender: Any) {
        if tfUsername.text == "hello@123" && tfPassword.text == "hello@123" {
            navigate()
        } else {
            showErrorDialog()
        }
    }
}

