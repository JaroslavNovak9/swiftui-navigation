//
//  CarsListVM.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import Foundation

final class CarsListVM: ObservableObject {

    let coordinator: CarsListCoordinator

    init(coordinator: CarsListCoordinator) {
        self.coordinator = coordinator
    }

    func openDetail(
        carBrand: String,
        carModel: String
    ) {
        coordinator
            .activeLinkSubject
            .send(
                .carDetailParametrized(
                    carBrand: carBrand,
                    carModel: carModel
                )
            )
    }

    func openAssistance() {
        coordinator
            .activeLinkSubject
            .send(
                .carAssistance
            )
    }
}

extension CarsListVM {
    var list: [Car] {
        [
            .init(id: "CAR1", brand: .bmw, model: "e46"),
            .init(id: "CAR2", brand: .nissan, model: "Patrol"),
            .init(id: "CAR3", brand: .audi, model: "A5"),
            .init(id: "CAR4", brand: .toyota, model: "Corolla")
        ]
    }
}
