//
//  BeerDetailCell_1.swift
//  Beerverse
//
//  Created by Özgün Yildiz on 05.12.23.
//

import UIKit

class BeerDetailCell_1: UITableViewCell {
    
    let beerImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        styleUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(beerImageView)
    }
    
    private func styleUI() {
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.translatesAutoresizingMaskIntoConstraints = false
        beerImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        beerImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        beerImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        beerImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

