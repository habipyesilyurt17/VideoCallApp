//
//  LoginVC.swift
//  VideoCallApp
//
//  Created by Habip Yesilyurt on 2.05.2024.
//

import UIKit

protocol LoginViewInterface: AnyObject {
    func prepareTextFieldDelegate()
    func showVideoCallPage()
    func tapGestureRecognizer()
    func keyboardShow()
    func keyboardHide()
}

final class LoginVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    private lazy var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTextFieldDelegate()
        keyboardShow()
        keyboardHide()
        tapGestureRecognizer()
        configureErrorLabel()
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text else { return }
        if viewModel.validateUsername(username) {
            errorLabel.isHidden = true
            viewModel.saveUsername(username)
            showVideoCallPage()
        } else {
            errorLabel.isHidden = false
            errorLabel.text = viewModel.errorMessage
            errorLabel.textColor = .red
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func configureErrorLabel() {
        errorLabel.isHidden = true
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension LoginVC: LoginViewInterface {
    func prepareTextFieldDelegate() {
        usernameTextField.delegate = self
    }
    
    func showVideoCallPage() {
        guard let videoCallVC = storyboard?.instantiateViewController(withIdentifier: "VideoCallVC") as? VideoCallVC else {
            return
        }
        navigationController?.pushViewController(videoCallVC, animated: true)        
    }
    
    func tapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func keyboardShow() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func keyboardHide() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
