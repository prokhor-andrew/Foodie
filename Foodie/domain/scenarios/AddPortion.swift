//
//  AddPortion.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//

enum AddPortion {
    case willAddPortion(Recipe, dayIndex: Int, mealIndex: Int)
    case didAddPortion
}
