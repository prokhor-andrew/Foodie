//
//  Combine+ScanWithOutput.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 22.07.2023.
//

import Combine

extension Publisher {
    
    func scanWithOutput<T>(_ initial: T, function: @escaping (T, Output) -> T?) -> AnyPublisher<Output, Failure> {
        let initial: (T, Output?) = (initial, nil)
        
        return scan(initial) { state, event in
            let (state, _) = state
            
            if let newState = function(state, event) {
                return (newState, event)
            } else {
                return (state, nil)
            }
        }
        .compactMap { $0.1 }
        .eraseToAnyPublisher()
    }
}
