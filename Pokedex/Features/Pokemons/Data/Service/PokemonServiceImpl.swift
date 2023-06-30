//
//  PokemonsService.swift
//  Pokedex
//
//  Created by Mustafa Ali Dikcinar on 28.06.2023.
//

import Foundation

class PokemonServiceImpl: PokemonService {
    func fetchPokemons(completion: @escaping (PokemonsAPIResponse)) {
        NetworkManager.instance.graphQL(requestQuery: PokemonsQuery.query, model: PokemonsResponse.self) { response in
            switch response {
            case .success(let model):
                completion(.success((model as? PokemonsResponse)?.pokemons))
            case .failure(let error):
                completion(.failure(.networkingError(error.localizedDescription)))
            }
        }
    }

    func fetchPokemonDetails() {}
}
