//
//  AppState.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//


struct AppState {
    let function: (AppEvent) -> AppState?
}

func merge(_ states: @autoclosure @escaping () -> [AppState]) -> AppState {
    AppState { event in
        var isTransitioned = false
        let result = merge(states().map { state in
            if let result = state.function(event) {
                isTransitioned = true
                return result
            } else {
                return state
            }
        })
        
        if isTransitioned {
            return result
        } else {
            return nil
        }
    }
}

func initial() -> AppState {
    AppState { event in
        switch event {
        case.getPlan(.willGetPlan):
            return AppState { event in
                switch event {
                case .getPlan(.didGetPlan(let plan)):
                    if let plan {
                        return willDeletePlanState(state: updatePlanState(plan: plan))
                    } else {
                        return createPlanState()
                    }
                default:
                    return nil
                }
            }
        default:
            return nil
        }
    }
}


func createPlanState() -> AppState {
    AppState { event in
        switch event {
        case .createPlan(.willCreatePlan):
            return AppState { event in
                switch event {
                case .createPlan(.didCreatePlan(let plan)):
                    if let plan {
                        return willDeletePlanState(state: updatePlanState(plan: plan))
                    } else {
                        return createPlanState()
                    }
                default:
                    return nil
                }
            }
        default:
            return nil
        }
    }
}

func deletePlanState() -> AppState {
    AppState { event in
        switch event {
        case .deletePlan(.willDeletePlan):
            return AppState { event in
                switch event {
                case .deletePlan(.didDeletePlan):
                    return createPlanState()
                default:
                    return nil
                }
            }
        default:
            return nil
        }
    }
}

func addPortionState(dayIndex: Int, mealIndex: Int) -> AppState {
    AppState { event in
        switch event {
        case .addPortion(.willAddPortion(_, dayIndex: dayIndex, mealIndex: mealIndex)):
            return AppState { event in
                switch event {
                case .addPortion(.didAddPortion(dayIndex: dayIndex, mealIndex: mealIndex)):
                    return addPortionState(dayIndex: dayIndex, mealIndex: mealIndex)
                default:
                    return nil
                }
            }
        default:
            return nil
        }
    }
}

func removePortionState(dayIndex: Int, mealIndex: Int) -> AppState {
    AppState { event in
        switch event {
        case .removePortion(.willRemovePortion(_, dayIndex: dayIndex, mealIndex: mealIndex)):
            return AppState { event in
                switch event {
                case .removePortion(.didRemovePortion(dayIndex: dayIndex, mealIndex: mealIndex)):
                    return removePortionState(dayIndex: dayIndex, mealIndex: mealIndex)
                default:
                    return nil
                }
            }
        default:
            return nil
        }
    }
}


func updatePlanState(plan: Plan) -> AppState {
    merge(plan.days.enumerated().flatMap { dayN, day in
        day.meals.enumerated().map { mealN, meal in
            merge([
                addPortionState(dayIndex: dayN, mealIndex: mealN),
                removePortionState(dayIndex: dayN, mealIndex: mealN)
            ])
        }
    })
}

func willDeletePlanState(state: AppState) -> AppState {
    AppState { event in
        switch event {
        case .deletePlan(.willDeletePlan):
            if let newMerged = state.function(event) {
                return didDeletePlanState(state: newMerged)
            } else {
                return didDeletePlanState(state: state)
            }
        default:
            if let newMerged = state.function(event) {
                return willDeletePlanState(state: newMerged)
            } else {
                return nil
            }
        }
    }
}

func didDeletePlanState(state: AppState) -> AppState {
    AppState { event in
        switch event {
        case .deletePlan(.didDeletePlan):
            return createPlanState()
        default:
            if let newMerged = state.function(event) {
                return didDeletePlanState(state: newMerged)
            } else {
                return nil
            }
        }
    }
}
