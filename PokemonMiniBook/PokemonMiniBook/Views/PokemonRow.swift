//
//  PokemonRow.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/22.
//

import SwiftUI

struct PokemonRow: View {
    @Binding var pokemon: Pokemon
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("#\(pokemon.id)")
                    .font(.caption)
                Text(pokemon.name)
                    .font(.headline)
            }
            .frame(width: 100, alignment: .leading)
            
            AsyncImage(url: URL(string: pokemon.spriteURL)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, alignment: .center)
            
            Spacer()
        }
        .frame(height: 40)
        .padding()
    }
}

#Preview("mock-muk-alola", traits: .fixedLayout(width: 300, height: 100)) {
    let mukAlola = Pokemon(
        id: 10113,
        name: "muk-alola",
        height: 10,
        weight: 520,
        locationAreaEncountersURL: "https://pokeapi.co/api/v2/pokemon/10113/encounters",
        spriteURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10113.png",
        cryURL: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/10113.ogg",
        abilityNames: [
            "poison-touch",
            "gluttony",
            "power-of-alchemy"
        ],
        moveNames: [
            "a",
            "b",
            "c",
            "d"
        ],
        typeNames: [
            "poison",
            "dark"
        ],
        pokemonStat: PokemonStats(
            baseHp: 100,
            baseAttack: 100,
            baseDefense: 100,
            baseSpecialAttack: 100,
            baseSpecialDefense: 100,
            baseSpeed: 100
        )
    )
    
    return StatefulPreviewWrapper(mukAlola) { pokemon in
        PokemonRow(pokemon: pokemon)
    }
}
