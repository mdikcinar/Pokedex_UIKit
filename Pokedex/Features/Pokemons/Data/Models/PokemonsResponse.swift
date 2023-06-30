//
//  PokemonsResponse.swift
//  Pokedex
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Foundation

struct PokemonsResponse: Decodable {
    let pokemons: [Pokemon]

    enum CodingKeys: String, CodingKey {
        case pokemons = "pokemon_v2_pokemon"
    }
}
