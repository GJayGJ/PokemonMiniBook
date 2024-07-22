//
//  ContentView.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/20.
//

import SwiftUI

struct ContentView: View {
    @State private var pokemon: Pokemon?
    @State private var pokemonCollection: PokemonCollection?
    
    
    var body: some View {
        VStack {
            if let pokemonCollection = pokemonCollection {
                Text(pokemonCollection.infos.debugDescription)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            RestfulAPIService.shared.httpGetFetchData(url: API.pokeApiUrl(for: .pokemon), responseType: PokemonCollection.self) { result in
                switch result {
                case .success(let collection):
                    DispatchQueue.main.async {
                        self.pokemonCollection = collection
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .padding()
    }
    
//    var body: some View {
//        VStack {
//            if let pokemon = pokemon {
//                Text("Pokemon Name: \(pokemon.name)")
//            } else {
//                Text("Loading...")
//            }
//        }
//        .onAppear {
//            RestfulAPIService.shared.httpGetFetchData(url: API.pokeApiUrl(for: .pokemon, id: 9), responseType: Pokemon.self) { result in
//                switch result {
//                case .success(let fetchedPokemon):
//                    DispatchQueue.main.async {
//                        self.pokemon = fetchedPokemon
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        .padding()
//    }
}

#Preview {
    ContentView()
}
