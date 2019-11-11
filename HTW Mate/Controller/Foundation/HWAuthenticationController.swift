//
//  HWAuthenticationController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 11/1/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import CoreGraphics

class HWAuthenticationController: UIViewController {

    let usernameTextField   = UITextField()
    let passwordTextField   = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = HWColors.StyleGuide.primaryGreen

		if UIDevice.current.userInterfaceIdiom == .phone {
			NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
		}
		
		configureConstraints()
    }
	
	deinit {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc func keyboardWillChange(notification: NSNotification) {
		guard let rectangle = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
			return
		}
		
		if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
			self.view.frame.origin.y = -rectangle.height
		} else {
			self.view.frame.origin.y = 0
		}
		
		self.view.layoutSubviews()
	}
	
	private func configureConstraints() -> Void {
		let coverView = UIView()
//		let titleLabel		= UILabel()
        let privacyPanel	= generatePrivacyPanel()
        let formPanel		= generateFormPanel()
        
		view.addSubview(coverView)
//		view.addSubview(titleLabel)
		view.addSubview(privacyPanel)
		view.addSubview(formPanel)
		

//
//		titleLabel.translatesAutoresizingMaskIntoConstraints = false
//		titleLabel.text = "HTW Account"
//		titleLabel.textColor = HWColors.StyleGuide.primaryGreen
//		titleLabel.font = UIFont.boldSystemFont(ofSize: HWFontSize.title)
//		titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//		titleLabel.centerYAnchor.constraint(equalTo: headerPanel.centerYAnchor).isActive = true
//

		privacyPanel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        privacyPanel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: HWInsets.large).isActive = true
        privacyPanel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -HWInsets.large).isActive = true
		privacyPanel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		privacyPanel.bottomAnchor.constraint(equalTo: formPanel.topAnchor, constant: -HWInsets.extraLarge).isActive = true
        
		let offset: CGFloat = 50
		coverView.translatesAutoresizingMaskIntoConstraints = false
		coverView.backgroundColor = .white
		coverView.transform = CGAffineTransform(rotationAngle: -7 * CGFloat.pi / 180)
		coverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -offset).isActive = true
		coverView.topAnchor.constraint(equalTo: formPanel.topAnchor, constant: 0).isActive = true
		coverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset).isActive = true
		coverView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset).isActive = true
		
        formPanel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: HWInsets.large).isActive = true
        formPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -HWInsets.large).isActive = true
        formPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -HWInsets.large).isActive = true
	}
	
    private func generateHeadlinePanel() -> UIView {
        let wrapper = UIView()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapper.backgroundColor = HWColors.contentBackground
        wrapper.transform = CGAffineTransform(rotationAngle: -12 * CGFloat.pi / 180)
        return wrapper
    }
	
	private func generatePrivacyPanel() -> UIView {
		let upperPanel = UIView()
		upperPanel.translatesAutoresizingMaskIntoConstraints = false
		
		let wrapper = UIView()
		wrapper.translatesAutoresizingMaskIntoConstraints = false
		
		let handshakeIcon	= UIImageView(image: HWIcons.handshake)
		handshakeIcon.translatesAutoresizingMaskIntoConstraints = false
		handshakeIcon.tintColor = HWColors.contentBackground
		
		let infoLabel = UILabel()
		infoLabel.translatesAutoresizingMaskIntoConstraints = false
		infoLabel.numberOfLines = 0
		infoLabel.textAlignment = .center
		infoLabel.adjustsFontSizeToFitWidth = true
		infoLabel.font = UIFont.systemFont(ofSize: HWFontSize.title)
		infoLabel.textColor = HWColors.contentBackground
		infoLabel.text = HWStrings.Authentication.privacyInfo
		
		wrapper.addSubview(handshakeIcon)
		wrapper.addSubview(infoLabel)
	
		handshakeIcon.topAnchor.constraint(equalTo: wrapper.topAnchor).isActive = true
		handshakeIcon.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor).isActive = true
		handshakeIcon.heightAnchor.constraint(equalTo: handshakeIcon.widthAnchor).isActive = true
		handshakeIcon.widthAnchor.constraint(equalToConstant: 48).isActive = true
		
		infoLabel.topAnchor.constraint(equalTo: handshakeIcon.bottomAnchor, constant: HWInsets.extraLarge).isActive = true
		infoLabel.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor).isActive = true
		infoLabel.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor).isActive = true
		infoLabel.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor).isActive = true
		
		upperPanel.addSubview(wrapper)
		wrapper.leadingAnchor.constraint(equalTo: upperPanel.leadingAnchor).isActive = true
		wrapper.trailingAnchor.constraint(equalTo: upperPanel.trailingAnchor).isActive = true
		wrapper.widthAnchor.constraint(lessThanOrEqualToConstant: 375).isActive = true
		wrapper.topAnchor.constraint(greaterThanOrEqualTo: upperPanel.topAnchor, constant: HWInsets.extraLarge).isActive = true
		wrapper.bottomAnchor.constraint(lessThanOrEqualTo: upperPanel.bottomAnchor).isActive = true
		wrapper.centerYAnchor.constraint(equalTo: upperPanel.centerYAnchor).isActive = true
		
		return upperPanel
	}

	private func generateFormPanel() -> UIView {
		let formPanel = UIView()
		formPanel.translatesAutoresizingMaskIntoConstraints = false
		
		let usernamePanel = UIView()
		usernamePanel.translatesAutoresizingMaskIntoConstraints = false
		usernamePanel.backgroundColor		= HWColors.contentBackground
		usernamePanel.layer.cornerRadius	= HWInsets.CornerRadius.panel
		
		let passwordPanel = UIView()
		passwordPanel.translatesAutoresizingMaskIntoConstraints = false
		passwordPanel.backgroundColor		= HWColors.contentBackground
		passwordPanel.layer.cornerRadius	= HWInsets.CornerRadius.panel
        
		let studentInfoButton = UIButton(type: .detailDisclosure)
		studentInfoButton.addTarget(self, action: #selector(didTapUsernameHelp), for: .touchUpInside)
		
		let inset = HWInsets.medium
		let textFieldHeight = HWInsets.standard
		
		usernamePanel.addSubview(usernameTextField)
		AppearanceManager.dropShadow(for: usernamePanel, withRadius: 1.5, opacity: 0.3, ignoreBackground: true)
		usernameTextField.translatesAutoresizingMaskIntoConstraints = false
		usernameTextField.placeholder = HWStrings.Authentication.studentId
		usernameTextField.rightViewMode = .always
		usernameTextField.rightView = studentInfoButton
		usernameTextField.autocorrectionType = .no
		usernameTextField.autocapitalizationType = .none
		usernameTextField.tintColor = HWColors.StyleGuide.primaryGreen
		usernameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
		usernameTextField.leadingAnchor.constraint(equalTo: usernamePanel.leadingAnchor, constant: inset).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: usernamePanel.topAnchor, constant: inset).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: usernamePanel.trailingAnchor, constant: -inset).isActive = true
		usernameTextField.bottomAnchor.constraint(equalTo: usernamePanel.bottomAnchor, constant: -inset).isActive = true

		passwordPanel.addSubview(passwordTextField)
		AppearanceManager.dropShadow(for: passwordPanel, withRadius: 1.5, opacity: 0.3, ignoreBackground: true)
		passwordTextField.translatesAutoresizingMaskIntoConstraints = false
		passwordTextField.placeholder = HWStrings.Authentication.password
        passwordTextField.isSecureTextEntry = true
		passwordTextField.autocorrectionType = .no
		passwordTextField.autocapitalizationType = .none
		passwordTextField.tintColor = HWColors.StyleGuide.primaryGreen
		passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
		passwordTextField.leadingAnchor.constraint(equalTo: passwordPanel.leadingAnchor, constant: inset).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordPanel.topAnchor, constant: inset).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passwordPanel.trailingAnchor, constant: -inset).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: passwordPanel.bottomAnchor, constant: -inset).isActive = true
        
		let authenticateButton = UIButton(type: .system)
        authenticateButton.translatesAutoresizingMaskIntoConstraints = false
		authenticateButton.backgroundColor = HWColors.StyleGuide.primaryGreen
		authenticateButton.setTitle(HWStrings.Authentication.signInButton, for: .normal)
        authenticateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: HWFontSize.enlargedText)
		authenticateButton.setTitleColor(HWColors.contentBackground, for: .normal)
		authenticateButton.heightAnchor.constraint(equalToConstant: textFieldHeight + (inset * 2)).isActive = true
		authenticateButton.layer.cornerRadius = (textFieldHeight + (inset * 2)) / 2
        authenticateButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

		formPanel.addSubview(usernamePanel)
		formPanel.addSubview(passwordPanel)
		formPanel.addSubview(authenticateButton)
		
		usernamePanel.leadingAnchor.constraint(equalTo: formPanel.leadingAnchor).isActive = true
		usernamePanel.topAnchor.constraint(equalTo: formPanel.topAnchor).isActive = true
		usernamePanel.trailingAnchor.constraint(equalTo: formPanel.trailingAnchor).isActive = true
		
		passwordPanel.leadingAnchor.constraint(equalTo: formPanel.leadingAnchor).isActive = true
		passwordPanel.topAnchor.constraint(equalTo: usernamePanel.bottomAnchor, constant: inset).isActive = true
		passwordPanel.trailingAnchor.constraint(equalTo: formPanel.trailingAnchor).isActive = true
		
		authenticateButton.leadingAnchor.constraint(equalTo: formPanel.leadingAnchor).isActive = true
		authenticateButton.topAnchor.constraint(equalTo: passwordPanel.bottomAnchor, constant: inset).isActive = true
		authenticateButton.trailingAnchor.constraint(equalTo: formPanel.trailingAnchor).isActive = true
		authenticateButton.bottomAnchor.constraint(equalTo: formPanel.bottomAnchor).isActive = true
		
		return formPanel
	}
    
    @objc private func didTapUsernameHelp() -> Void {
        AlertManager.init(in: self)
			.with(title: HWStrings.Authentication.studentIdInfoTitle)
			.with(message: HWStrings.Authentication.studentIdInfoDescription)
			.dispatch(ofType: .ok)
    }
    
    @objc private func didTapSignIn() -> Void {
		guard let url = URL(string: "https://lsf.htw-berlin.de/qisserver/rds?state=user&type=1") else {
			return
		}
		
		let request = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			print(data)
		}
		
		task.resume()
    }
}
