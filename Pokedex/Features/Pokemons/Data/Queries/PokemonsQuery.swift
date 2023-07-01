//
//  Pokemons.swift
//  Pokedex
//
//  Created by Mustafa Ali Dikcinar on 30.06.2023.
//

import Foundation

enum PokemonsQuery {
    static let query: String = """
    query pokemons {
      pokemon_v2_pokemon(limit: 15) {
        id
        name
            pokemon_v2_pokemonsprites {
                sprites
            }
        }
    }
    """
}
