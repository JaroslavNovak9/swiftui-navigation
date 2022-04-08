//
//  CarTechnicalInfoVM.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 08.04.2022.
//

import Foundation

final class CarTechnicalInfoVM {

    let coordinator: CarTechnicalInfoCoordinator

    init(coordinator: CarTechnicalInfoCoordinator) {
        self.coordinator = coordinator
    }

    func openCarAssistance() {
        coordinator.selectedLink = .carAssistance
    }
}
