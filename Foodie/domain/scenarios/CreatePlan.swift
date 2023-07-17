//
//  CreatePlan.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//

enum CreatePlan {
    case willCreatePlan(currentWeightInKgs: Double, goalWeightInKgs: Double)
    case didCreatePlan(Plan?) // nil means we failed to create plan
}
