//
//  BookmarkView.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/25.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var bookmarkViewModel: BookmarkViewModel
    var pokemonID: Int

    var body: some View {
        Button {
            bookmarkViewModel.toggleBookmark(id: pokemonID)
        } label: {
            Image(bookmarkViewModel.isBookmarked(id: pokemonID) ? .occupiedPokeball : .emptyPokeball)
                .resizable()
                .scaledToFit()
                .frame(height: 30)
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    BookmarkView(pokemonID: 10113)
        .environmentObject(BookmarkViewModel())
}
