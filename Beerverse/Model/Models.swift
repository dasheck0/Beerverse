//
//  Models.swift
//  Beerverse
//
//  Created by Özgün Yildiz on 05.12.23.
//

import Foundation

struct Beer: Codable {
    let id: Int
    let name: String
    let tagline: String?
    let firstBrewed: String?
    let description: String?
    let imageUrl: String?
    let abv: Double?
    let ibu: Double?
    let targetFg: Double?
    let targetOg: Double?
    let ebc: Double?
    let srm: Double?
    let ph: Double?
    let attenuationLevel: Double?
    let volume: Volume?
    let boilVolume: Volume?
    let method: BrewingMethod?
    let ingredients: Ingredients?
    let foodPairing: [String]?
    let brewersTips: String?
    let contributedBy: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case firstBrewed = "first_brewed"
        case description
        case imageUrl = "image_url"
        case abv
        case ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc
        case srm
        case ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method
        case ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
    
    struct Volume: Codable {
        let value: Double?
        let unit: String?
    }
    
    struct BrewingMethod: Codable {
        let mashTemp: [MashTemp]?
        let fermentation: Fermentation?
        let twist: String?
        
        enum CodingKeys: String, CodingKey {
            case mashTemp = "mash_temp"
            case fermentation
            case twist
        }
        
        struct MashTemp: Codable {
            let temp: Temperature?
            let duration: Int?
            
            struct Temperature: Codable {
                let value: Double?
                let unit: String?
            }
        }
        
        struct Fermentation: Codable {
            let temp: Temperature?
            
            struct Temperature: Codable {
                let value: Double?
                let unit: String?
            }
        }
    }
    
    struct Ingredients: Codable {
        let malt: [Malt]?
        let hops: [Hop]?
        let yeast: String?
        
        struct Malt: Codable {
            let name: String?
            let amount: Measurement?
            
            struct Measurement: Codable {
                let value: Double?
                let unit: String?
            }
        }
        
        struct Hop: Codable {
            let name: String?
            let amount: Measurement?
            let add: String?
            let attribute: String?
            
            struct Measurement: Codable {
                let value: Double?
                let unit: String?
            }
        }
    }
}
