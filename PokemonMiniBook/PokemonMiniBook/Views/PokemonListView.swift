//
//  PokemonListView.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/22.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredPokemons) { pokemon in
                    // Create a binding of pokemon to interact with rows
                    let pokemonBinding = Binding(
                        get: {
                            viewModel.pokemons.first(where: { $0.id == pokemon.id })!
                        },
                        set: { newValue in
                            let index = viewModel.pokemons.firstIndex(where: { $0.id == pokemon.id })!
                            viewModel.pokemons[index] = newValue
                        }
                    )
                    
                    NavigationLink(value: pokemon) {
                        PokemonRow(pokemon: pokemonBinding)
                    }
                }
            }
            .searchable(text: $viewModel.filterText, prompt: "Search Pokemon")
            .navigationTitle("Pokemon List")
            .navigationDestination(for: Pokemon.self) { pokemon in
                
                // TODO: Refactor binding
                
                // Create a binding of pokemon to interact with rows
                let pokemonBinding = Binding(
                    get: {
                        viewModel.pokemons.first(where: { $0.id == pokemon.id })!
                    },
                    set: { newValue in
                        let index = viewModel.pokemons.firstIndex(where: { $0.id == pokemon.id })!
                        viewModel.pokemons[index] = newValue
                    }
                )
                PokemonDetailView(pokemon: pokemonBinding)
            }
        }
        .onAppear() {
            Task {
                await viewModel.fetchPokemonInfos()
                viewModel.reorder()
            }
        }
    }
}


#Preview {
    PokemonListView()
}
