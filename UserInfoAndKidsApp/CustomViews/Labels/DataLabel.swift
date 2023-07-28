//
//  DataLabel.swift
//  UserInfoAndKidsApp
//
//  Created by ARMBP
//

import UIKit

class DataLabel: UILabel {
    
    let customPadding: CGFloat = 5
    let titleLabel       = Label(textAlignment: .left, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat, palceHolderText: String) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
        configureTitleLabel()
        titleLabel.text = palceHolderText
    }
    
    func configureTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.textColor = .systemGray
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: customPadding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -customPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func configure() {
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        contentMode = .scaleAspectFit
        
        
    }
    
    
    //MARK: -  Setting padding for text inside
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 0)
                super.drawText(in: rect.inset(by: insets))
    }
}

