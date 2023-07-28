//
//  TextField.swift
//  UserInfoAndKidsApp
//
//  Created by ARMBP
//

import UIKit

class TextField: UITextField {
    let padding: CGFloat = 5
    let titleLabel       = Label(textAlignment: .left, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(palceHolderText: String) {
        super.init(frame: .zero)
        titleLabel.text = palceHolderText
        configure()
        configureTitleLabel()
    }
    
    func configureTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.textColor = .systemGray
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .left
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        returnKeyType               = .go
        clearButtonMode             = .whileEditing
    }
    
    //MARK: -  Setting padding for text inside
    
    let paddingText = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 0);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingText)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingText)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingText)
    }
}
