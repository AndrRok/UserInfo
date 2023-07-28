//
//  ViewController.swift
//  UserInfoAndKidsApp
//
//  Created by ARMBP 
//

import UIKit


class ViewController: UIViewController {
    
    let tableView = UITableView()
    var kidsList = PersistenceManager.sharedRealm.item
    let padding: CGFloat = 20
    let userNameTextField   = TextField(palceHolderText: "Имя")
    let userAgeTextField    = TextField(palceHolderText: "Возраст")
    let titleLabel          = Label(textAlignment: .left, fontSize: 20)
    let kidsLabel           = Label(textAlignment: .left, fontSize: 20)
    let addKidButton        = Button()
    let deleteButton        = Button()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        view.backgroundColor = .systemBackground
        configureTitleLabel()
        configureUserNameTextField()
        configureUserAgeTextField()
        configureKidsLabel()
        configureAddButton()
        checkKidsCount()
        checkKidsCount()
        configureDeleteButton()
        configureTableView()
        reloadTableView()
        
    }
    
    func reloadTableView(){
        kidsList = PersistenceManager.sharedRealm.item
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func checkKidsCount(){
        guard self.kidsList.count <= 4 else {
            disableAddButoon(addKidButton)
            return
        }
        enableButton(addKidButton)
    }
    
    func disableAddButoon(_ button: UIButton){
        DispatchQueue.main.async {
            button.isEnabled  = false
            button.alpha = 0
        }
    }
    
    func enableButton(_ button: UIButton){
        DispatchQueue.main.async {
            button.isEnabled  = true
            button.alpha = 1
        }
    }
    
    
    //MARK: - Labels
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Персональные данные родителя"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureKidsLabel() {
        view.addSubview(kidsLabel)
        kidsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        kidsLabel.text = "Дети (макс. 5)"
        
        NSLayoutConstraint.activate([
            kidsLabel.topAnchor.constraint(equalTo: userAgeTextField.bottomAnchor, constant: padding),
            kidsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            kidsLabel.heightAnchor.constraint(equalToConstant: 28),
            kidsLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    //MARK: - Text fields
    func configureUserNameTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNameTextField.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureUserAgeTextField(){
        view.addSubview(userAgeTextField)
        userAgeTextField.keyboardType = UIKeyboardType.decimalPad
        userAgeTextField.translatesAutoresizingMaskIntoConstraints = false
        userAgeTextField.delegate = self
       
        NSLayoutConstraint.activate([
            userAgeTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: padding),
            userAgeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userAgeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userAgeTextField.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    //MARK: - TableView
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = .zero
        tableView.rowHeight = 250
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addKidButton.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -10)
        ])
    }
    
    //MARK: - Buttons
    private func configureAddButton(){
        view.addSubview(addKidButton)
        addKidButton.set(title: "Добавить ребенка")
        addKidButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        addKidButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addKidButton.topAnchor.constraint(equalTo: userAgeTextField.bottomAnchor, constant: padding),
            addKidButton.leadingAnchor.constraint(equalTo: kidsLabel.trailingAnchor),
            addKidButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            addKidButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        addKidButton.addTarget(self, action: #selector(addKidButtonTapped), for: .touchUpInside)
    }
    
    @objc func addKidButtonTapped(){
        let destinationVC = AddKidVC()
        let navController = UINavigationController(rootViewController: destinationVC)
        destinationVC.reloadDelegate = self
        present(navController, animated: true)
    }
    
    //MARK: - Delete Button
    private func configureDeleteButton(){
        view.addSubview(deleteButton)
        deleteButton.set(title: "Сбросить данные")
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalToConstant: 200)
            
        ])
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped(){
        let alert = UIAlertController(title: "", message: "Выберите", preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive , handler:{ (UIAlertAction)in
            PersistenceManager.sharedRealm.deleteAll()
            self.reloadTable()
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler:{ (UIAlertAction)in
        }))
        
        self.present(alert, animated: true, completion: {
        })
    }
    
    
    
    
    //MARK: - Dismiss Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kidsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseID) as! Cell
        let kid = kidsList[indexPath.row]
        cell.nameLabel.text = kid.kidsName
        cell.ageLabel.text  = kid.kidsAge
        cell.cellId         = indexPath.row
        cell.delegate       = self
        cell.contentView.isUserInteractionEnabled = true
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
}

//MARK: - Protocol for reload
extension ViewController: ReloadTableFromCellProtocol{
    func reloadTable() {
        checkKidsCount()
        reloadTableView()
    }
}


//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == userAgeTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
}

extension ViewController: ReloadTableProtocol{
    func reloadTableFunc() {
        checkKidsCount()
        reloadTableView()
    }
    
    
}





