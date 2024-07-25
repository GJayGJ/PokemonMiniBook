//
//  PokemonMiniBookApp.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/20.
//

import SwiftUI

@main
struct PokemonMiniBookApp: App {
    var bookmarkViewModel = BookmarkViewModel()
    
    var body: some Scene {
        WindowGroup {
            PokemonListView()
                .environmentObject(bookmarkViewModel)
        }
    }
}
