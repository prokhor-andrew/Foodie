//
//  Meal.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//

enum Meal: Hashable {
    case expected(nutrientsToConsume: Nutrients)
    case planned(nutrientsToConsume: Nutrients, portions: [Recipe])
    case prepared(nutrientsToConsume: Nutrients, portions: [Recipe])
}
