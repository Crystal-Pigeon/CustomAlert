//
//  ViewController.swift
//  CustomAlertView
//
//  Created by Mariana Samardzic on 21.12.20..
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Properties
    @IBOutlet weak var configurationName: UILabel!
    @IBOutlet weak var notificationsAllowedLabel: UILabel!
    
    private lazy var alertView: AlertView = {
        let view = AlertView.instanceFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var alertViewConstraint: NSLayoutConstraint!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alertViewConstraint = NSLayoutConstraint(item: self.alertView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        self.alertViewConstraint.constant = -100
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.alertViewConstraint.constant = 0
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func openAlert(_ sender: Any) {
        self.view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
        
        self.view.addSubview(alertView)
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            alertView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            alertViewConstraint
        ])
    }
}

// MARK: - AlertViewDelegate
extension ViewController: AlertViewDelegate {
    func removeAlert(sender: AlertView) {
        sender.removeFromSuperview()
        self.backgroundView.removeFromSuperview()
    }
    func handleData(name: String, isAllowed: Bool) {
        configurationName.text = name
        if isAllowed {
            notificationsAllowedLabel.text = "Notifications are allowed"
        } else {
            notificationsAllowedLabel.text = "Notifications are not allowed"
        }
    }
}
