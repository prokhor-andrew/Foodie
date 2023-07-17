//
//  AppEvent.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//

enum AppEvent {
    case createPlan(CreatePlan)
    case deletePlan(DeletePlan)
    case getPlan(GetPlan)
    case addPortion(AddPortion)
    case removePortion(RemovePortion)
}
