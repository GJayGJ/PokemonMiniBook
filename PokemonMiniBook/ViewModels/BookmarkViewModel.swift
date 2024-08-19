//
//  BookmarkViewModel.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/25.
//

import Foundation

/// Used for bookmarking pokemons in UserDefaults
class BookmarkViewModel: ObservableObject {
    /// IDs of bookmarked pokemons
    @Published var bookmarkedIds: Set<Int> = []

    init() {
        loadBookmarks()
    }
    
    /// Checks if a Pokemon with a specific ID is bookmarked
    func isBookmarked(id: Int) -> Bool {
        bookmarkedIds.contains(id)
    }

    func toggleBookmark(id: Int) {
        if bookmarkedIds.contains(id) {
            bookmarkedIds.remove(id)
        } else {
            bookmarkedIds.insert(id)
        }
        saveBookmarks()
    }

    private func loadBookmarks() {
        if let savedIds = UserDefaults.standard.object(forKey: "bookmarkedPokemonIDs") as? [Int] {
            bookmarkedIds = Set(savedIds)
        }
    }

    private func saveBookmarks() {
        UserDefaults.standard.set(Array(bookmarkedIds), forKey: "bookmarkedPokemonIDs")
    }
}
