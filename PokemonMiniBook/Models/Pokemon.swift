//
//  Pokemon.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/20.
//

import Foundation

// MARK: Struct properties
struct Pokemon: Identifiable {
    let id: Int
    var name: String
    let height: Int
    let weight: Int
    let locationAreaEncountersURL: String
    let spriteURL: String
    let cryURL: String
    let abilityNames: [String]
    let moveNames: [String]
    let typeNames: [String]
    let pokemonStat: PokemonStats
}

// MARK: Flattened struct from the original complex nested JSON
extension Pokemon: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, sprites, cries, abilities, moves, types, stats
        case locationAreaEncounters = "location_area_encounters"
    }

    // Custom init from Decoder to handle the flattening
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Directly decode simple types
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)
        locationAreaEncountersURL = try container.decode(String.self, forKey: .locationAreaEncounters)
        
        // Flatten sprites
        let spritesContainer = try container.decode(Sprites.self, forKey: .sprites)
        spriteURL = spritesContainer.other.officialArtwork.frontDefault
        
        // Flatten cries
        let criesContainer = try container.decode(Cries.self, forKey: .cries)
        cryURL = criesContainer.latest
        
        // Flatten abilities
        let abilityContainer = try container.decode([AbilityEntry].self, forKey: .abilities)
        abilityNames = abilityContainer.map { $0.ability.name }
        
        // Flatten moves
        let moveContainer = try container.decode([MoveEntry].self, forKey: .moves)
        moveNames = moveContainer.map { $0.move.name }
        
        // Flatten types
        let typeContainer = try container.decode([TypeEntry].self, forKey: .types)
        typeNames = typeContainer.map { $0.type.name }
        
        // Flatten stats
        let statContainer = try container.decode([StatEntry].self, forKey: .stats)
        guard let hp = statContainer.first(where: { $0.stat.name == "hp" })?.baseStat,
              let attack = statContainer.first(where: { $0.stat.name == "attack" })?.baseStat,
              let defense = statContainer.first(where: { $0.stat.name == "defense" })?.baseStat,
              let specialAttack = statContainer.first(where: { $0.stat.name == "special-attack" })?.baseStat,
              let specialDefense = statContainer.first(where: { $0.stat.name == "special-defense" })?.baseStat,
              let speed = statContainer.first(where: { $0.stat.name == "speed" })?.baseStat
            else { fatalError() }
        
        self.pokemonStat = .init(
            baseHp: hp,
            baseAttack: attack,
            baseDefense: defense,
            baseSpecialAttack: specialAttack,
            baseSpecialDefense: specialDefense,
            baseSpeed: speed
        )
    }
    
    
    // MARK: Private structs for flatten attributes
    
    private struct Sprites: Decodable {
        let other: OtherSprites
    }
    
    private struct OtherSprites: Decodable {
        let officialArtwork: OfficialArtwork

        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }

    private struct OfficialArtwork: Decodable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    private struct Cries: Decodable {
        let latest: String
    }
    
    private struct AbilityEntry: Decodable {
        let ability: Ability

        enum CodingKeys: String, CodingKey {
            case ability
        }
    }

    private struct Ability: Decodable {
        let name: String
    }
    
    private struct MoveEntry: Decodable {
        let move: Move
    }

    private struct Move: Decodable {
        let name: String
    }
    
    private struct TypeEntry: Decodable {
        let type: TypeBody
    }

    private struct TypeBody: Decodable {
        let name: String
    }

    private struct StatEntry: Decodable {
        let baseStat: Int
        let stat: Stat

        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case stat
        }
    }

    private struct Stat: Decodable {
        let name: String
    }
}

// MARK: Conforms to Hashable and Equatable
extension Pokemon: Hashable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
