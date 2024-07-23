//
//  PokemonUrlsResponse.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/22.
//

import Foundation

struct PokemonUrlsResponse: Decodable {
    private(set) var pokemonUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        pokemonUrls = []
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let resultsContainer = try container.decode([PokemonUrl].self, forKey: .results)
        resultsContainer.forEach { result in
            pokemonUrls.append(result.url)
        }
    }
    
    // MARK: Private structs for flatten attributes
    
    private struct PokemonUrl: Decodable {
        let url: String
    }
}
