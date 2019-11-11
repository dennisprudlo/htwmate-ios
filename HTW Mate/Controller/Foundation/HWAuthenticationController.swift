//
//  HWAuthenticationController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 11/1/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import CoreGraphics

class HWAuthenticationController: UIViewController, UITextFieldDelegate {

	var keyboardVisible: Bool	= false
	
	let contentView				= UIView()
	var offsetConstraint:		NSLayoutConstraint?
	
    let usernameTextField		= UITextField()
    let passwordTextField		= UITextField()
	let authenticateButton		= UIButton(type: .system)
	
	var presenter: UIViewController?
	var successPushTarget: UIViewController?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = HWColors.StyleGuide.primaryGreen

		if UIDevice.current.userInterfaceIdiom == .phone {
			NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
		}
		
		configureConstraints()
    }
	
	deinit {
		if UIDevice.current.userInterfaceIdiom == .pad {
			NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
			NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		}
	}
	
	@objc private func keyboardWillChange(notification: NSNotification) {
		guard let rectangle = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
			return
		}

		if notification.name == UIResponder.keyboardWillShowNotification && !self.keyboardVisible {
			self.offsetConstraint?.constant	= -rectangle.height
			self.keyboardVisible			= true
		} else if notification.name == UIResponder.keyboardWillHideNotification {
			self.offsetConstraint?.constant	= 0
			self.keyboardVisible			= false
		}
		
		self.view.layoutIfNeeded()
	}
	
	private func configureConstraints() -> Void {
		let coverView		= UIView()
        let privacyPanel	= generatePrivacyPanel()
        let formPanel		= generateFormPanel()
        
		contentView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(contentView)
		
		contentView.addSubview(coverView)
		contentView.addSubview(privacyPanel)
		contentView.addSubview(formPanel)

		privacyPanel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        privacyPanel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: HWInsets.large).isActive = true
        privacyPanel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -HWInsets.large).isActive = true
		privacyPanel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		privacyPanel.bottomAnchor.constraint(equalTo: formPanel.topAnchor, constant: -HWInsets.extraLarge).isActive = true
        
		let offset: CGFloat = 50
		coverView.translatesAutoresizingMaskIntoConstraints = false
		coverView.backgroundColor = .white
		coverView.transform = CGAffineTransform(rotationAngle: -7 * CGFloat.pi / 180)
		coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -offset).isActive = true
		coverView.topAnchor.constraint(equalTo: formPanel.topAnchor, constant: 0).isActive = true
		coverView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: offset).isActive = true
		coverView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset * 2).isActive = true
		
        formPanel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        formPanel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HWInsets.large).isActive = true
        formPanel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HWInsets.large).isActive = true
        formPanel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -HWInsets.large).isActive = true
		
		contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		contentView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
		contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		offsetConstraint = contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		offsetConstraint?.isActive = true
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
		wrapper.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
		wrapper.topAnchor.constraint(greaterThanOrEqualTo: upperPanel.topAnchor, constant: HWInsets.extraLarge).isActive = true
		wrapper.bottomAnchor.constraint(lessThanOrEqualTo: upperPanel.bottomAnchor).isActive = true
		wrapper.heightAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
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
		usernameTextField.delegate = self
		usernameTextField.placeholder = HWStrings.Authentication.studentId
		usernameTextField.rightViewMode = .always
		usernameTextField.rightView = studentInfoButton
		usernameTextField.autocorrectionType = .no
		usernameTextField.autocapitalizationType = .none
		usernameTextField.keyboardType = .emailAddress
		usernameTextField.returnKeyType = .next
		usernameTextField.tintColor = HWColors.StyleGuide.primaryGreen
		usernameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
		usernameTextField.leadingAnchor.constraint(equalTo: usernamePanel.leadingAnchor, constant: inset).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: usernamePanel.topAnchor, constant: inset).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: usernamePanel.trailingAnchor, constant: -inset).isActive = true
		usernameTextField.bottomAnchor.constraint(equalTo: usernamePanel.bottomAnchor, constant: -inset).isActive = true

		passwordPanel.addSubview(passwordTextField)
		AppearanceManager.dropShadow(for: passwordPanel, withRadius: 1.5, opacity: 0.3, ignoreBackground: true)
		passwordTextField.translatesAutoresizingMaskIntoConstraints = false
		passwordTextField.delegate = self
		passwordTextField.placeholder = HWStrings.Authentication.password
        passwordTextField.isSecureTextEntry = true
		passwordTextField.autocorrectionType = .no
		passwordTextField.autocapitalizationType = .none
		passwordTextField.keyboardType = .default
		passwordTextField.returnKeyType = .join
		passwordTextField.tintColor = HWColors.StyleGuide.primaryGreen
		passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
		passwordTextField.leadingAnchor.constraint(equalTo: passwordPanel.leadingAnchor, constant: inset).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordPanel.topAnchor, constant: inset).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passwordPanel.trailingAnchor, constant: -inset).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: passwordPanel.bottomAnchor, constant: -inset).isActive = true
        
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
    
	private func setStatusText(_ text: String? = nil) {
		if let text = text {
			authenticateButton.setTitle(text, for: .normal)
		} else {
			authenticateButton.setTitle(HWStrings.Authentication.signInButton, for: .normal)
		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == usernameTextField {
			passwordTextField.becomeFirstResponder()
		} else if textField == passwordTextField {
			didTapSignIn()
		}
		
		// Do not add a line break
		return false
	}
	
    @objc private func didTapUsernameHelp() -> Void {
        AlertManager.init(in: self)
			.with(title: HWStrings.Authentication.studentIdInfoTitle)
			.with(message: HWStrings.Authentication.studentIdInfoDescription)
			.dispatch(ofType: .ok)
    }
    
    @objc private func didTapSignIn() -> Void {
		usernameTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
		
		var username = usernameTextField.text ?? ""
		let password = passwordTextField.text ?? ""
		
		if username.count == 0 || password.count == 0 {
			AlertManager.init(in: self)
				.with(title: HWStrings.Authentication.invalidInputTitle)
				.with(message: HWStrings.Authentication.invalidInputDescription)
				.dispatch()
			return
		}
		
		self.setStatusText("Authenticating...")
		
		if username.range(of: "s0", options: .caseInsensitive) == nil {
			username = "s0\(username)"
		}
		
		username = username.replacingOccurrences(of: "@htw-berlin.de", with: "", options: .caseInsensitive)
		
		API.shared.lsf().auth(username: username, password: password) { (success, response) in
			DispatchQueue.main.async {
				if !success {
					self.setStatusText()
					AlertManager.init(in: self)
						.with(title: HWStrings.Authentication.incorrectInputTitle)
						.with(message: HWStrings.Authentication.incorrectInputDescription)
						.dispatch()
					return
				}
				
				self.dismiss(animated: true) {
					guard let presenter = self.presenter, let target = self.successPushTarget else {
						return
					}
					
					presenter.navigationController?.pushViewController(target, animated: true)
				}
			}
		}
    }
}
