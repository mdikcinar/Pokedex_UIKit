//
//  ParserHelpers.swift
//  Pokedex
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Foundation

struct ResponseData<T: Decodable>: Decodable {
    let data: T

    enum CodingKeys: String, CodingKey {
        case data
    }
}
