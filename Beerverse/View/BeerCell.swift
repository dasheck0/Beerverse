//
//  BeerCell.swift
//  Beerverse
//
//  Created by Özgün Yildiz on 05.12.23.
//

import UIKit

class BeerCell: UICollectionViewCell {
    
    let beerImageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        addSubviews()
        setupConstraints()
        styleUIElements()
    }
    
    private func setupConstraints() {
        beerImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            beerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            beerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            beerImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            beerImageView.heightAnchor.constraint(equalTo: beerImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: beerImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    private func styleUIElements() {
        beerImageView.layer.cornerRadius = 20
        beerImageView.layer.masksToBounds = true
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = UIFont(name: Constants.FONTS.COURIER, size: 11)
        nameLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(beerImageView)
    }
}
