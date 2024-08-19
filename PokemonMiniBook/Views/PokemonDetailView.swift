//
//  PokemonDetailView.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/22.
//

import SwiftUI

struct PokemonDetailView: View {
    @Binding var pokemon: Pokemon

    var body: some View {
        ScrollView {
            VStack {
                // The image of the pokemon
                AsyncImage(url: URL(string: pokemon.spriteURL)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, alignment: .center)
                
                HStack(alignment: .center, spacing: 15) {
                    // Pokeball button
                    BookmarkView(pokemonID: pokemon.id)
                    
                    // The id and the name of the pokemon
                    VStack(alignment: .leading) {
                        Text("#\(pokemon.id)")
                            .font(.title2)
                        TextField("HIHI", text: $pokemon.name)
//                        Text(pokemon.name)
//                            .font(.title)
//                            .fontWeight(.bold)
                    }
                }
                
                
                
                // Height and Weight of the pokemon
                VStack(alignment: .leading) {
                    Text("Height: \(pokemon.height) decimetres")
                        .font(.footnote)
                    Text("Weight: \(pokemon.weight) hectograms")
                        .font(.footnote)
                }

                // Abilities and Types of the pokemon in two columns
                HStack(alignment: .top) {
                    // Abilities of the pokemon
                    VStack(alignment: .leading) {
                        Text("Abilities:")
                            .font(.title3)
                            .fontWeight(.bold)
                        ForEach(pokemon.abilityNames, id: \.self) { ability in
                            Text("• \(ability)")
                        }
                    }
                    .padding(.leading, 35)
                    
                    Spacer()

                    // The types of the pokemon
                    VStack {
                        Text("Types:")
                            .font(.title3)
                            .fontWeight(.bold)
                        ForEach(pokemon.typeNames, id: \.self) { type in
                            Image(type)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                        }
                    }
                    .padding(.trailing, 35)
                }
                .padding(.vertical, 30)

                
                
                
                // The Radar Chart of the pokemon's stats
                PokemonStatsView(pokemonStats: pokemon.pokemonStat)
                    .padding(.bottom, 120)
                
            }
        }
        .navigationTitle(pokemon.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("mock-muk-alola") {
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
            "punch",
            "fart",
            "kick",
            "sleep"
        ],
        typeNames: [
            "poison",
            "dark"
        ],
        pokemonStat: PokemonStats(
            baseHp: 123,
            baseAttack: 111,
            baseDefense: 98,
            baseSpecialAttack: 38,
            baseSpecialDefense: 5,
            baseSpeed: 1
        )
    )
    
    return StatefulPreviewWrapper(mukAlola) { pokemon in
        PokemonDetailView(pokemon: pokemon)
            .environmentObject(BookmarkViewModel())
    }
}
