//
//  AlertView.swift
//  CustomAlertView
//
//  Created by Mariana Samardzic on 21.12.20..
//

import UIKit

class AlertView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var configurationNameTextField: UITextField!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    // MARK: - Properties
    var delegate: AlertViewDelegate?
    
    // MARK: - Init
    class func instanceFromNib() -> AlertView {
        let view = UINib(nibName: "AlertView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AlertView
        view.setupView()
        return view
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.okButton.isEnabled = false
        self.configurationNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    // MARK: - Button Actions
    @IBAction func cancel(_ sender: Any) {
        self.delegate?.removeAlert(sender: self)
    }
    
    @IBAction func ok(_ sender: Any) {
        self.delegate?.removeAlert(sender: self)
        self.delegate?.handleData(name: self.configurationNameTextField.text!, isAllowed: switchButton.isOn)
    }
    
    // MARK: - Functions
    @objc private func editingChanged() {
        if self.configurationNameTextField.text!.isBlank {
            self.okButton.isEnabled = false
        } else {
            self.okButton.isEnabled = true
        }
    }
}

// MARK: - Delegate
protocol AlertViewDelegate {
    func removeAlert(sender: AlertView)
    func handleData(name: String, isAllowed: Bool)
}
