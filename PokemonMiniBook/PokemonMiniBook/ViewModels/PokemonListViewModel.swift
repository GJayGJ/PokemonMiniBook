//
//  PokemonListViewModel.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/23.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var filterText: String = ""
    
    var filteredPokemons: [Pokemon] {
        if filterText.isEmpty {
            return pokemons
        } else {
            return pokemons.filter { $0.name.lowercased().contains(filterText.lowercased()) }
        }
    }
    
    /// Fetch all the urls for each pokemon and then fetch the datailed info of the pokemon through the url
    func fetchPokemonInfos() async {
        guard pokemons.isEmpty else { return }
        
        guard let pokemonUrls = await RestfulAPIService.shared.httpGetFetchData(
            url: API.pokeApiUrl(for: .pokemon),
            responseType: PokemonUrlsResponse.self
        )?.pokemonUrls else {
            return
        }
        
        await withTaskGroup(of: Pokemon?.self) { group in
            for pokemonUrl in pokemonUrls {
                group.addTask {
                    return await self.fetchPokemonInfo(url: pokemonUrl)
                }
            }
            
            var fetchedPokemons: [Pokemon] = []
            for await fetchedPokemon in group {
                if let fetchedPokemon = fetchedPokemon {
                    fetchedPokemons.append(fetchedPokemon)
                }
            }
            
            // Must capture `fetchedPokemons` to ensure data consistency
            await MainActor.run { [fetchedPokemons] in
                self.pokemons = fetchedPokemons
            }
        }
    }
    
    // TODO: Sort by other ways
    func reorder() {
        pokemons.sort(by: { $0.id < $1.id } )
    }
    
    /// Fetch detailed info of an individual pokemon through a url
    private func fetchPokemonInfo(url: String) async -> Pokemon? {
        let pokemon = await RestfulAPIService.shared.httpGetFetchData(url: url, responseType: Pokemon.self)
        return pokemon
    }
}
