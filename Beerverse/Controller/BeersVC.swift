//
//  BeersVC.swift
//  Beerverse
//
//  Created by Özgün Yildiz on 05.12.23.
//

import UIKit
import SwiftyJSON
import Kingfisher

class BeersVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum BeerFetchingError: Error {
        case invalidURL
        case networkError(Error)
        case invalidHTTPResponse
        case noDataReceived
        case decodingError(Error)
    }
    
    private var beers: [Beer] = []
    private let itemsPerPage = 25
    private var currentPage = 1
    
    private let scrollToTopButton = UIButton(type: .system)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BeerCell.self, forCellWithReuseIdentifier: Constants.CELLS.BEER_CELL)
        collectionView.backgroundColor = #colorLiteral(red: 0.9266296029, green: 0.9266296029, blue: 0.9266296029, alpha: 1)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        collectionView.frame = view.bounds
        doFetch()
    }
    
    private func doFetch() {
        fetchBeers { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let beers):
                self.beers.append(contentsOf: beers)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                currentPage += 1
            case .failure(let error):
                self.handleFetchError(error)
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    
    private func handleFetchError(_ error: BeerFetchingError) {
        let errorMessage: String
        
        switch error {
        case .invalidURL:
            errorMessage = "Could not load more beers due to invalid URL."
        case .networkError(let networkError):
            errorMessage = "Could not load more beers due to network error: \(networkError.localizedDescription)"
        case .invalidHTTPResponse:
            errorMessage = "Could not load more beers due to invalid HTTP response."
        case .noDataReceived:
            errorMessage = "Could not load more beers due to no data received."
        case .decodingError(let decodingError):
            errorMessage = "Could not load more beers due to decoding error: \(decodingError.localizedDescription)"
        }
        
        createAndPresentAlert(errorMsg: errorMessage)
    }
    
    private func createAndPresentAlert(errorMsg: String) {
        let alertController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func fetchBeers(completion: @escaping (Result<[Beer], BeerFetchingError>) -> Void) {
        let endpoint = Constants.API.ENDPOINT
        
        var components = URLComponents(string: endpoint)!
        components.queryItems = [
            URLQueryItem(name: Constants.API.PAGE, value: "\(currentPage)"),
            URLQueryItem(name: Constants.API.PER_PAGE, value: "\(itemsPerPage)")
        ]
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard self != nil else { return }
            
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidHTTPResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let beers = try decoder.decode([Beer].self, from: data)
                completion(.success(beers))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == beers.count - 1 {
            
            fetchBeers { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let beers):
                    self.beers.append(contentsOf: beers)
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    self.handleFetchError(error)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CELLS.BEER_CELL, for: indexPath) as! BeerCell
        let beer = beers[indexPath.item]
        if let beerURL = beer.imageUrl, !beerURL.isEmpty {
            let url = URL(string: beerURL)
            cell.beerImageView.kf.setImage(with: url)
        } else {
            cell.beerImageView.image = UIImage(named: "Unavailable")
        }
        cell.nameLabel.text = beer.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBeer = beers[indexPath.item]
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = layout.minimumInteritemSpacing
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
        let width = (collectionView.bounds.width - totalSpacing - layout.sectionInset.left - layout.sectionInset.right) / numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
}


