//
//  PokemonListView.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/22.
//

import SwiftUI

//struct PokemonListView: View {
//    var pokemons: [Pokemon] = [
//        Pokemon(
//            id: 10113,
//            name: "muk-alola",
//            height: 10,
//            weight: 520,
//            locationAreaEncountersURL: "https://pokeapi.co/api/v2/pokemon/10113/encounters",
//            spriteURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10113.png",
//            cryURL: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/10113.ogg",
//            abilityNames: [
//                "poison-touch",
//                "gluttony",
//                "power-of-alchemy"
//            ],
//            moveNames: [
//                "a",
//                "b",
//                "c",
//                "d"
//            ],
//            typeNames: [
//                "poison",
//                "dark"
//            ],
//            pokemonStat: PokemonStats(
//                baseHp: 100,
//                baseAttack: 100,
//                baseDefense: 100,
//                baseSpecialAttack: 100,
//                baseSpecialDefense: 100,
//                baseSpeed: 100
//            )
//        ),
//        Pokemon(
//            id: 1,
//            name: "aa",
//            height: 11,
//            weight: 111,
//            locationAreaEncountersURL: "",
//            spriteURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
//            cryURL: "",
//            abilityNames: [],
//            moveNames: [],
//            typeNames: [],
//            pokemonStat: PokemonStats(
//                baseHp: 100,
//                baseAttack: 100,
//                baseDefense: 100,
//                baseSpecialAttack: 100,
//                baseSpecialDefense: 100,
//                baseSpeed: 100
//            )
//        ),
//        Pokemon(
//            id: 2,
//            name: "bb",
//            height: 22,
//            weight: 222,
//            locationAreaEncountersURL: "",
//            spriteURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png",
//            cryURL: "",
//            abilityNames: [],
//            moveNames: [],
//            typeNames: [],
//            pokemonStat: PokemonStats(
//                baseHp: 100,
//                baseAttack: 100,
//                baseDefense: 100,
//                baseSpecialAttack: 100,
//                baseSpecialDefense: 100,
//                baseSpeed: 100
//            )
//        ),
//    
//    ]
//    
//    var body: some View {
//        List(pokemons) { pokemon in
//            PokemonRow(pokemon: .constant(pokemon))
//        }
//    }
//}

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        List(viewModel.pokemons) { pokemon in
            PokemonRow(pokemon: .constant(pokemon))
        }
        .onAppear() {
            Task {
                await viewModel.fetchPokemonInfos()
            }
        }
    }
}


#Preview {
    PokemonListView()
}
