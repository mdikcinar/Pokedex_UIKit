//
//  PokemonDTO.swift
//  Pokedex
//
//  Created by Mustafa Ali Dikcinar on 29.06.2023.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
