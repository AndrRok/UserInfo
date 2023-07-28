//
//  Button.swift
//  UserInfoAndKidsApp
//
//  Created by ARMBP 
//

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    convenience init(backgroundcolor: UIColor, title: String, fontSize: CGFloat){
        self.init(frame: .zero)
        self.backgroundColor    = backgroundcolor
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
    }
    private func configure(){
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.label, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(title: String){
        setTitle(title, for: .normal)
    }
}
