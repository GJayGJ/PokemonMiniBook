//
//  PokemonBriefInfos.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/22.
//

import Foundation

struct PokemonCollection: Decodable {
    private(set) var infos: [PokemonBriefInfo]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        infos = []
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let resultsContainer = try container.decode([Result].self, forKey: .results)
        resultsContainer.forEach { result in
            let name = result.name
            let detailInfoURL = result.url
            guard let idSubstring = result.url.split(separator: "/").last, let id = Int(String(idSubstring)) else { fatalError() }
            let spriteImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
            infos.append(PokemonBriefInfo(id: id, name: name, detailInfoURL: detailInfoURL, spriteImageURL: spriteImageURL))
        }
    }
    
    // MARK: Private structs for flatten attributes
    
    private struct Result: Decodable {
        let name: String
        let url: String
    }
}
