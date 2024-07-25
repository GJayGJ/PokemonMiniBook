//
//  PokemonStatsView.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/24.
//

import SwiftUI
import DDSpiderChart

struct PokemonStatsView: View {
    var pokemonStats: PokemonStats
    
    var body: some View {
        DDSpiderChart(
            axes: [
                "HP - \(pokemonStats.baseHp)",
                "ATK - \(pokemonStats.baseAttack)" ,
                "DEF - \(pokemonStats.baseDefense)",
                "S.ATK - \(pokemonStats.baseSpecialAttack)",
                "S.DEF - \(pokemonStats.baseSpecialDefense)",
                "SPD - \(pokemonStats.baseSpeed)"
            ],
            values: [
                DDSpiderChartEntries(values: getPokemonStatsRatios(), color: .teal)
            ],
            fontTitle: .boldSystemFont(ofSize: 16),
            textColor: .primary
        )
        .frame(width: 300, height: 300)
    }
    
    /// Convert the stats of a pokemon to an array of Float, which can be used as one of the values in DDSpiderChart's init()
    private func getPokemonStatsRatios() -> [Float] {
        var ratios: [Float] = []
        
        let hpRatio = Float(pokemonStats.baseHp) / 150
        let attackRatio = Float(pokemonStats.baseAttack) / 150
        let defenseRatio = Float(pokemonStats.baseDefense) / 150
        let specialAttackRatio = Float(pokemonStats.baseSpecialAttack) / 150
        let specialDefenseRatio = Float(pokemonStats.baseSpecialDefense) / 150
        let speedRatio = Float(pokemonStats.baseSpeed) / 150
        
        // Ensure the ratio not greater than 1
        ratios.append(hpRatio > 1 ? 1 : hpRatio)
        ratios.append(attackRatio > 1 ? 1 : attackRatio)
        ratios.append(defenseRatio > 1 ? 1 : defenseRatio)
        ratios.append(specialAttackRatio > 1 ? 1 : specialAttackRatio)
        ratios.append(specialDefenseRatio > 1 ? 1 : specialDefenseRatio)
        ratios.append(speedRatio > 1 ? 1 : speedRatio)
        
        return ratios
    }
}


#Preview("mock-muk-alola-stats", traits: .fixedLayout(width: 300, height: 100)) {
    let muk = PokemonStats(
        baseHp: 270,
        baseAttack: 111,
        baseDefense: 98,
        baseSpecialAttack: 38,
        baseSpecialDefense: 50,
        baseSpeed: 50
    )
    
    return PokemonStatsView(pokemonStats: muk)
}
