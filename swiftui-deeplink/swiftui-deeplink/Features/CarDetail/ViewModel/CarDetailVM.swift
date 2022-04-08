//
//  CarDetailVM.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import Foundation

final class CarDetailVM {

    let carBrandString: String
    let carModelString: String
    let carDetailCoordinator: CarDetailCoordinator

    init(
        carBrandString: String,
        carModelString: String,
        carDetailCoordinator: CarDetailCoordinator
    ) {
        self.carBrandString = carBrandString
        self.carModelString = carModelString
        self.carDetailCoordinator = carDetailCoordinator
    }

    func openTechnicalInfo() {
        carDetailCoordinator.selectedLink = .carTechnicalInfo
    }
}
