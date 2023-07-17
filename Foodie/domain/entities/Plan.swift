//
//  Plan.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//

import Foundation

struct Plan: Hashable {
    let startDate: Date
    let days: [Day]
}
