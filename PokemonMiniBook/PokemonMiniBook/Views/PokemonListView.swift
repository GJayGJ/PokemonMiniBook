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
                    let pokemonBinding = Binding(
                        get: {
                            viewModel.pokemons.first(where: { $0.id == pokemon.id })!
                        },
                        set: { newValue in
                            let index = viewModel.pokemons.firstIndex(where: { $0.id == pokemon.id })!
                            viewModel.pokemons[index] = newValue
                        }
                    )
                    PokemonRow(pokemon: pokemonBinding)
                }
            }
            .searchable(text: $viewModel.filterText, prompt: "Search Pokemon")
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
