//
//  Recipe.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//

struct Recipe: Hashable {
    let name: String
    let instructions: String
    let ingridient: [Product: Double] // product and amount of it in grams
}
