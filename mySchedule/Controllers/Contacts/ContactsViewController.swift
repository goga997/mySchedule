//
//  ContactsViewController.swift
//  mySchedule
//
//  Created by Grigore on 31.03.2023.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
       let segmControl = UISegmentedControl(items: ["Friends", "Professors"])
        segmControl.selectedSegmentIndex = 0
        segmControl.selectedSegmentTintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        return segmControl
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.9321168065, green: 0.9681312442, blue: 0.8774852157, alpha: 1)
        tableView.separatorStyle = .singleLine
        
        
        return tableView
    }()
    
    let searchController = UISearchController()
    
    let idContactsCell = "idContactsCell"
    
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactModel>!
    private var filteredArray: Results<ContactModel>!
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    
    var isFiltring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        view.backgroundColor = #colorLiteral(red: 0.9321168065, green: 0.9681312442, blue: 0.8774852157, alpha: 1)
        
        //setari pentru searchContr.
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        contactsArray = localRealm.objects(ContactModel.self).filter("contactType = 'Friend'")
        
        //setez delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "idContactsCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        setContraints()
    }
    
    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactType = 'Friend'")
            tableView.reloadData()
        } else {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactType = 'Professor'")
            tableView.reloadData()
        }
    }
    
    @objc func addButtonTapped() {
        let contactOption = ContactOptionsTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
    }
    
    @objc func editingModel(contactModel: ContactModel) {
        let contactOption = ContactOptionsTableViewController()
        contactOption.contactModel = contactModel
        contactOption.editModel = true
        contactOption.cellNameArray = [contactModel.contactName, contactModel.contactPhone, contactModel.contactMail, contactModel.contactType, ""]
        contactOption.imageIsChanged = true
        navigationController?.pushViewController(contactOption, animated: true)
    }
    
}

//MARK: - tableview Delegates

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltring ? filteredArray.count : contactsArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idContactsCell", for: indexPath) as! ContactsTableViewCell
        let model = (isFiltring ? filteredArray[indexPath.row] : contactsArray[indexPath.row])
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        editingModel(contactModel: model)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactsArray[indexPath.row]
        
        let deteleAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deteleAction])
    }
}

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredArray = contactsArray.filter("contactName CONTAINS[c] %@", searchText)
    
        tableView.reloadData()
    }
    
}

extension ContactsViewController {
    private func setContraints() {
   
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
    }
}
