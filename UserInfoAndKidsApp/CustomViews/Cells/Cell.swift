//
//  Cell.swift
//  UserInfoAndKidsApp
//
//  Created by ARMBP
//

import UIKit


protocol ReloadTableFromCellProtocol{
    func reloadTable()
}

class Cell: UITableViewCell {
    
    var kidsList = PersistenceManager.sharedRealm.item
    var cellId = 0
    var delegate: ReloadTableFromCellProtocol?
    static let reuseID = "Cell"
    let padding: CGFloat = 5
    let nameLabel = DataLabel(textAlignment: .left, fontSize: 20, palceHolderText: "Имя")
    let ageLabel  = DataLabel(textAlignment: .left, fontSize: 20, palceHolderText: "Возраст")
    let deleteCellButton = Button()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        configureDeleteButton()
        configureNameLabel()
        configureAgeLabel()
    }
    
    private func configureNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: deleteCellButton.leadingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configureAgeLabel() {
        contentView.addSubview(ageLabel)
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            ageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            ageLabel.trailingAnchor.constraint(equalTo: deleteCellButton.leadingAnchor, constant: -padding),
            ageLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configureDeleteButton(){
        contentView.addSubview(deleteCellButton)
        deleteCellButton.set(title: " Удалить ")
        deleteCellButton.translatesAutoresizingMaskIntoConstraints = false
        deleteCellButton.titleLabel?.font = .systemFont(ofSize: 12)
        deleteCellButton.setTitleColor(UIColor.black, for: .normal)
        
        NSLayoutConstraint.activate([
            deleteCellButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            deleteCellButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            deleteCellButton.heightAnchor.constraint(equalToConstant: 60),
            deleteCellButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        deleteCellButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped(){
        PersistenceManager.sharedRealm.deleteKid(item: kidsList[cellId])
        delegate?.reloadTable()
    }
}
