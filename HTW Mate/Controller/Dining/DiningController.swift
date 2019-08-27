//
//  DiningController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/17/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DiningController: UIViewController, UITableViewDelegate, UITableViewDataSource, CafeteriaStorageDelegate {

    var date = Date() {
        didSet {
            dateButton.title = dateString
        }
    }
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self.date)
    }

    var dateButton: UIBarButtonItem!

    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    let datePicker = UIDatePicker()
    let datePickerDisclosePosition: CGFloat = 300
    var datePickerBottomConstraint: NSLayoutConstraint!
    let datePickerToolbar = UIToolbar()

    /// Whether to update the menu when the view appears
    public static var updateOnAppear: Bool = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //
        // Handles the menu reload after updating the cafeteria settings
        if DiningController.updateOnAppear {
            DiningController.updateOnAppear = false

            self.reloadMenu()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = HWStrings.Controllers.Dining.title

        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76

        tableView.register(CafeteriaDishTableViewCell.self, forCellReuseIdentifier: String(describing: CafeteriaDishTableViewCell.self))

        CafeteriaStorage.shared.delegate = self

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.date = self.date
        datePicker.backgroundColor = UIColor.groupTableViewBackground
        datePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        datePickerBottomConstraint = datePicker.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: datePickerDisclosePosition)
        datePickerBottomConstraint.isActive = true

        self.view.addSubview(datePickerToolbar)
        datePickerToolbar.tintColor = HWColors.StyleGuide.primaryGreen
        datePickerToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelDatePicker(_:))),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: HWStrings.Controllers.Dining.todayLabel, style: .plain, target: self, action: #selector(didTodaySubmitDatePicker(_:))),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSubmitDatePicker(_:)))
        ]
        datePickerToolbar.translatesAutoresizingMaskIntoConstraints = false
        datePickerToolbar.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor).isActive = true
        datePickerToolbar.trailingAnchor.constraint(equalTo: datePicker.trailingAnchor).isActive = true
        datePickerToolbar.bottomAnchor.constraint(equalTo: datePicker.topAnchor).isActive = true

        dateButton = UIBarButtonItem(title: self.dateString, style: .plain, target: self, action: #selector(didRequestDateSelector(_:)))
        navigationItem.leftBarButtonItem = dateButton
    }

    // MARK: - Lecturer storage handler

    func cafeteriaStorage(didReloadDishes dishes: [CafeteriaDish]) {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }

    private func reloadMenu() {
        CafeteriaStorage.shared.reload(forDate: self.date, cafeteria: .treskowallee)
    }

    @objc func didRequestDateSelector(_ sender: UIBarButtonItem) {
        collapseDatePicker(show: true)
    }

    @objc private func didCancelDatePicker(_ sender: UIDatePicker) {
        collapseDatePicker()
    }

    @objc private func didTodaySubmitDatePicker(_ sender: UIDatePicker) {
        collapseDatePicker()
        self.date = Date()
        self.datePicker.date = self.date
        self.reloadMenu()
    }

    @objc private func didSubmitDatePicker(_ sender: UIDatePicker) {
        collapseDatePicker()
        self.date = datePicker.date
        self.reloadMenu()
    }

    private func collapseDatePicker(show: Bool = false) {
        if show {
            self.datePicker.isHidden = false
            self.datePickerToolbar.isHidden = false
        }

        datePickerBottomConstraint.constant = show ? 0 : datePickerDisclosePosition

        let option: UIView.AnimationOptions = show ? .curveEaseOut : .curveEaseIn

        UIView.animate(withDuration: 0.2, delay: 0, options: option, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (success) in
            if !show {
                self.datePicker.isHidden = true
                self.datePickerToolbar.isHidden = true
            }
        })
    }

    // MARK: Table view delegate and data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return CafeteriaStorage.shared.displayedSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CafeteriaStorage.shared.cafeteriaDishes(inSection: section).count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CafeteriaStorage.shared.titleForSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let dish = CafeteriaStorage.shared.cafeteriaDishes(inSection: indexPath.section)[indexPath.row]

        let cell = CafeteriaDishTableViewCell.dequeue(from: tableView)
        cell.setModel(dish)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #warning("TODO: Implement the segue to the detail view of a dish")
    }
}
