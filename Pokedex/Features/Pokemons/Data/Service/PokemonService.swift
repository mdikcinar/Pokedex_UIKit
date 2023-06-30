//
//  PokemonService.swift
//  Pokedex
//
//  Created by Mustafa Ali Dikcinar on 28.06.2023.
//

import Foundation

typealias PokemonsAPIResponse = (Swift.Result<[Pokemon]?, DataError>) -> Void

protocol PokemonService {
    func fetchPokemons(completion: @escaping (PokemonsAPIResponse))
    func fetchPokemonDetails()
}
