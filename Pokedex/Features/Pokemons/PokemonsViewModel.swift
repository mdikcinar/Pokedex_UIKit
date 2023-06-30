//
//  PokemonsViewModel.swift
//  Pokedex
//
//  Created by Mustafa Ali Dikcinar on 28.06.2023.
//

import Combine
import Foundation

class PokemonsViewModel {
    @Published private(set) var pokemons: [Pokemon] = []
    @Published private(set) var error: DataError? = nil

    private let apiService: PokemonService

    init(apiService: PokemonService = PokemonServiceImpl()) {
        self.apiService = apiService
    }

    func fetchPokemons() {
        apiService.fetchPokemons { [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemons = pokemons ?? []
            case .failure(let error):
                self?.error = error
            }
        }
    }
}
