//
//  BeerDetailCell_2.swift
//  Beerverse
//
//  Created by Özgün Yildiz on 05.12.23.
//

import UIKit

class BeerDetailCell_2: UITableViewCell {
    
    let nameLbl = UILabel()
    let taglineLbl = UILabel()
    let abvIbuOgLbl = UILabel()
    let descriptionLbl = UILabel()
    let foodPairingLbl = UILabel()
    let brewerstipLbl = UILabel()
    let verticalStack = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        styleUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(nameLbl)
        verticalStack.addArrangedSubview(taglineLbl)
        verticalStack.addArrangedSubview(abvIbuOgLbl)
        verticalStack.addArrangedSubview(descriptionLbl)
        verticalStack.addArrangedSubview(foodPairingLbl)
        verticalStack.addArrangedSubview(brewerstipLbl)
    }
    
    private func styleUI() {
        
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        taglineLbl.translatesAutoresizingMaskIntoConstraints = false
        abvIbuOgLbl.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStack.spacing = AppDelegate.screenHeight / 25
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        
        nameLbl.textColor                                 = .black
        nameLbl.font = UIFont(name: Constants.FONTS.COURIER, size: (AppDelegate.screenHeight + AppDelegate.screenWidth) / 90)
        nameLbl.numberOfLines = 0
        
        taglineLbl.tintColor                                 = .black
        taglineLbl.font = UIFont(name: Constants.FONTS.COURIER_BOLD, size: (AppDelegate.screenHeight + AppDelegate.screenWidth) / 90)
        taglineLbl.numberOfLines = 0
        
        abvIbuOgLbl.tintColor                                 = .black
        abvIbuOgLbl.font = UIFont(name: Constants.FONTS.COURIER, size: (AppDelegate.screenHeight + AppDelegate.screenWidth) / 90)
        abvIbuOgLbl.numberOfLines = 0
        
        
        descriptionLbl.textColor                                 = .black
        descriptionLbl.font = UIFont(name: Constants.FONTS.COURIER, size: (AppDelegate.screenHeight + AppDelegate.screenWidth) / 90)
        descriptionLbl.numberOfLines = 0
        
        foodPairingLbl.textColor                                 = .black
        foodPairingLbl.font = UIFont(name: Constants.FONTS.COURIER, size: (AppDelegate.screenHeight + AppDelegate.screenWidth) / 90)
        foodPairingLbl.numberOfLines = 0
        
        brewerstipLbl.textColor                                 = .black
        brewerstipLbl.font = UIFont(name: Constants.FONTS.COURIER, size: (AppDelegate.screenHeight + AppDelegate.screenWidth) / 90)
        brewerstipLbl.numberOfLines = 0
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: AppDelegate.screenHeight / 30),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppDelegate.screenWidth / 25),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppDelegate.screenWidth / 25),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -AppDelegate.screenHeight / 30),
        ])
    }
}

