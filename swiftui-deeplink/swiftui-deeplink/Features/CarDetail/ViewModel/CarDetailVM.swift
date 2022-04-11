//
//  CarDetailVM.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import Foundation

final class CarDetailVM: ObservableObject {

    let carBrandString: String
    let carModelString: String
    let coordinator: CarDetailCoordinator

    init(
        carBrandString: String,
        carModelString: String,
        coordinator: CarDetailCoordinator
    ) {
        self.carBrandString = carBrandString
        self.carModelString = carModelString
        self.coordinator = coordinator
    }

    func openTechnicalInfo() {
        coordinator.activeLink = .carTechnicalInfo
    }
}
