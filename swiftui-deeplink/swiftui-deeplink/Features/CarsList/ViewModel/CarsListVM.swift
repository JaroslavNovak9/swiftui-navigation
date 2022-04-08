//
//  CarsListVM.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import Foundation

final class CarsListVM {

    let carsListCoordinator: CarsListCoordinator

    init(carsListCoordinator: CarsListCoordinator) {
        self.carsListCoordinator = carsListCoordinator
    }

    func openDetail(
        carBrand: String,
        carModel: String
    ) {
        // TODO: - Add published subject that sends signal for navigation with parameters
        carsListCoordinator.selectedLink = .carDetailParametrized(
            carBrand: carBrand,
            carModel: carModel
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
