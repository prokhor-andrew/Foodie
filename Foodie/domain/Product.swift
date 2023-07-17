//
//  Product.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//

struct Product: Hashable {
    let name: String
    let nutrientsPerHundredGrams: Nutrients
    let storesToBuy: [Store]
}
