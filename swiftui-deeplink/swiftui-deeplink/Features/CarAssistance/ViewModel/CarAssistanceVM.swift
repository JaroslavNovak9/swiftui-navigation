//
//  CarAssistanceVM.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 12.04.2022.
//

import Foundation

final class CarAssistanceVM: ObservableObject {

    let coordinator: CarAssistanceCoordinator

    init(
        coordinator: CarAssistanceCoordinator
    ) {
        self.coordinator = coordinator
    }
}
