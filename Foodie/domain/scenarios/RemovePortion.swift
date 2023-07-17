//
//  RemovePortion.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//

enum RemovePortion {
    case willRemovePortion(Recipe, dayIndex: Int, mealIndex: Int)
    case didRemovePortion(dayIndex: Int, mealIndex: Int)
}

