//
//  DomainPublisher.swift
//  Foodie
//
//  Created by Andriy Prokhorenko on 17.07.2023.
//

import Combine


typealias DomainPublisher = any ConnectablePublisher<(AppEvent, (AppEvent) -> Void), Never>

func domain() -> DomainPublisher {
    let subject = PassthroughSubject<AppEvent, Never>()
    
    return subject
        .scanWithOutput(initial()) { $0.function($1) }
        .map { ($0, { subject.send($0) }) }
        .multicast(PassthroughSubject.init)
}

