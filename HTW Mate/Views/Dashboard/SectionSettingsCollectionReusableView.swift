//
//  SectionSettingsCollectionReusableView.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SectionSettingsCollectionReusableView: UICollectionReusableView, Dequeable {

    private var titleLabel = UILabel()
    private var detailLabel = UILabel()
    private var settingsButton = UIButton(type: .system)

    public var viewController: UIViewController!

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(settingsButton)

        let outerInset = HWInsets.standard
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setImage(HWIcons.settings, for: .normal)
        settingsButton.tintColor = HWColors.StyleGuide.primaryGreen
        settingsButton.isUserInteractionEnabled = true
        settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outerInset).isActive = true
        settingsButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        settingsButton.addTarget(self, action: #selector(composeSettingsController), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func composeSettingsController(_ sender: UIButton) {
        let settingsController = SettingController(style: .insetGrouped)
        let settingsNavigationController = HWNavigationController(rootViewController: settingsController)
		settingsNavigationController.navigationItem.largeTitleDisplayMode = .never
		settingsNavigationController.navigationBar.prefersLargeTitles = false
        viewController?.present(settingsNavigationController, animated: true, completion: nil)
    }
}
