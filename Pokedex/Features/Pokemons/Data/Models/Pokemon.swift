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
    let sprites: Sprites

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sprites = "pokemon_v2_pokemonsprites"
    }

    struct PokemonSpritesContainer: Codable {
        let sprites: String
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let pokemonSpritesContainers = try container.decode([PokemonSpritesContainer].self, forKey: .sprites)

        guard let firstSpriteContainer = pokemonSpritesContainers.first else {
            throw DecodingError.dataCorruptedError(forKey: .sprites,
                                                   in: container,
                                                   debugDescription: "Expected at least one element in pokemon_v2_pokemonsprites array")
        }

        let spriteData = firstSpriteContainer.sprites.data(using: .utf8)!
        sprites = try JSONDecoder().decode(Sprites.self, from: spriteData)
    }
}
