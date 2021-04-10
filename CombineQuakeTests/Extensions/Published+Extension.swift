//
//  Published+Extension.swift
//  CombineQuakeTests
//
//  Created by Adrian Bolinger on 4/9/21.
//

import Combine

extension Published.Publisher {
    func collectNext(_ count: Int) -> AnyPublisher<[Output], Never> {
        self.dropFirst()
            .collect(count)
            .first()
            .eraseToAnyPublisher()
    }
}
