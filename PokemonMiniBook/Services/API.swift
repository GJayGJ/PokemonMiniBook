//
//  API.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/22.
//

import Foundation

struct API {
    
    // MARK: Base URL
    
    static let pokeApiBaseURL = "https://pokeapi.co/api/v2/"
    static let gitHubBaseURL = "https://raw.githubusercontent.com/PokeAPI/"
    
    
    // MARK: Endpoints

    enum PokeApiEndpoint: String {
        case pokemon = "pokemon/"
    }
    
    enum GitHubEndpoint: String {
        case officialArtwork = "sprites/master/sprites/pokemon/other/official-artwork/"
        case latestCry = "cries/main/cries/pokemon/latest/"
    }

    
    // MARK: Complete endpoint URL string
    
    static func pokeApiUrl(for endpoint: PokeApiEndpoint, id: Int? = nil) -> String {
        let endpointURL = pokeApiBaseURL + endpoint.rawValue
        if let id = id {
            return "\(endpointURL)\(id)/"
        } else {
            let limit = "?limit=\(Int.max)"
            return "\(endpointURL)\(limit)"
        }
    }
    
    static func gitHubUrl(for endpoint: GitHubEndpoint, id: Int) -> String {
        let fileExtension: String
        switch endpoint {
        case .officialArtwork:
            fileExtension = ".png"
        case .latestCry:
            fileExtension = ".ogg"
        }
        
        let endpointURL = "\(gitHubBaseURL)\(endpoint.rawValue)"
        return "\(endpointURL)\(id)\(fileExtension)"
    }
}
