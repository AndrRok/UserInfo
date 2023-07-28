//
//  AddKidVC.swift
//  UserInfoAndKidsApp
//
//  Created by ARMBP 
//

import UIKit

protocol ReloadTableProtocol {
    func reloadTableFunc()
}


class AddKidVC: UIViewController {
    
    let padding: CGFloat = 20
    var reloadDelegate: ReloadTableProtocol?
    var kidsList = PersistenceManager.sharedRealm.item
    let nameTextField               = TextField(palceHolderText: "Имя")
    let ageTextField                = TextField(palceHolderText: "Возраст")
    let titleLabel                  = Label(textAlignment: .left, fontSize: 20)
    let addKidButtonSecondVC        = Button()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        view.backgroundColor = .systemBackground
        configureTitleNameLabel()
        configureKidsNameTextField()
        configureKidsAgeTextField()
        configureActionButton()
    }
    
    
    //MARK: - Labels
    func configureTitleNameLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Данные вашего ребенка"
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    //MARK: - Text fields
    func configureKidsNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    func configureKidsAgeTextField(){
        view.addSubview(ageTextField)
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.keyboardType = UIKeyboardType.decimalPad
        ageTextField.delegate = self
        
        
        NSLayoutConstraint.activate([
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ageTextField.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    //MARK: - Buttons
    private func configureActionButton(){
        view.addSubview(addKidButtonSecondVC)
        addKidButtonSecondVC.set(title: " Добавить ребенка ")
        addKidButtonSecondVC.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            addKidButtonSecondVC.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: padding),
            addKidButtonSecondVC.heightAnchor.constraint(equalToConstant: 60),
            addKidButtonSecondVC.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        addKidButtonSecondVC.addTarget(self, action: #selector(addKidButtonTapped), for: .touchUpInside)
    }
    
    @objc func addKidButtonTapped(){
        guard !(nameTextField.text!.isEmpty) && !(ageTextField.text!.isEmpty) else{
            self.presentCustomAllertOnMainThred(allertTitle: "Ошибка", message: "Необходимо ввести все данные о ребенке", butonTitle: "Ok")
        return
        }
        
        guard kidsList.count <= 5 else {
            self.presentCustomAllertOnMainThred(allertTitle: "Ошибка", message: "Вы можете добавить не более 5 детей", butonTitle: "Ok")
            return
        }
        
    
        
        guard  Int(ageTextField.text ?? "0")! < 18 else {
            self.presentCustomAllertOnMainThred(allertTitle: "Ошибка", message: "Максимальный возраст ребенка в вашей стране 18 лет", butonTitle: "Ok")
            return
        }
       
        PersistenceManager.sharedRealm.addKid(name: nameTextField.text!, age: ageTextField.text!)//
        reloadDelegate?.reloadTableFunc()
       dismiss(animated: true, completion: nil)
    }
    
    //MARK: - DismissKeyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate allows only decimals in age TF
extension AddKidVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == ageTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
        
 

}
