//
//  BeerDetailsVC.swift
//  Beerverse
//
//  Created by Özgün Yildiz on 05.12.23.
//

import UIKit

class BeerDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setUpConstraints()
        setUpTableView()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setUpConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpTableView() {
        tableView.register(BeerDetailCell_1.self, forCellReuseIdentifier: Constants.CELLS.BEER_DETAILCELL_1)
        tableView.register(BeerDetailCell_2.self, forCellReuseIdentifier: Constants.CELLS.BEER_DETAILCELL_2)
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELLS.BEER_DETAILCELL_1, for: indexPath) as! BeerDetailCell_1
            if let beerURL = beer.imageUrl, !beerURL.isEmpty {
                let url = URL(string: beerURL)
                cell.beerImageView.kf.setImage(with: url)
            } else {
                cell.beerImageView.image = UIImage(named: "Unavailable")
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELLS.BEER_DETAILCELL_2, for: indexPath) as! BeerDetailCell_2
            cell.nameLbl.text = "\(beer.name)  #\(beer.id)"
            cell.taglineLbl.text = beer.tagline
            cell.abvIbuOgLbl.text = "ABV \(beer.abv ?? 0) | IBU \(beer.ibu ?? 0) | OG \(beer.targetOg ?? 0)"
            cell.descriptionLbl.attributedText = modifyString(headline: "THIS BEER IS", beerProperty: beer.description)
            cell.foodPairingLbl.attributedText = modifyString(headline: "FOOD PAIRING", beerProperty: beer.foodPairing)
            cell.brewerstipLbl.attributedText = modifyString(headline: "BREWER'S TIPS", beerProperty: beer.brewersTips)
            return cell
        }
        
    }
    
    private func modifyString(headline: String, beerProperty: Any?) -> NSMutableAttributedString {
        let fontSize: CGFloat = (AppDelegate.screenHeight + AppDelegate.screenWidth) / 90
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: Constants.FONTS.COURIER_BOLD, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize),
        ]
        
        let regularAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: Constants.FONTS.COURIER, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
        ]
        
        let attributedString = NSMutableAttributedString(string: "\(headline) \n\n", attributes: boldAttributes)
        
        if let propertyStrings = beerProperty as? [String], !propertyStrings.isEmpty {
            let joinedString = propertyStrings.joined(separator: "\n")
            let propertyAttributedString = NSAttributedString(string: joinedString, attributes: regularAttributes)
            attributedString.append(propertyAttributedString)
        } else if let propertyString = beerProperty as? String, !propertyString.isEmpty {
            let propertyAttributedString = NSAttributedString(string: propertyString, attributes: regularAttributes)
            attributedString.append(propertyAttributedString)
        } else {
            let noDescriptionAttributedString = NSAttributedString(string: "No data available.", attributes: regularAttributes)
            attributedString.append(noDescriptionAttributedString)
        }
        return attributedString
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return AppDelegate.screenHeight * 0.3
        } else {
            return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

