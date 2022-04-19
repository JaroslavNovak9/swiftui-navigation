//
//  CarDealershipVM.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 19.04.2022.
//

import Combine
import Foundation

final class CarDealershipVM: ObservableObject {

    @Published var selectedRoute: CarDealershipCoordinatorRoute?

    init(
        preselectedRoute: CarDealershipCoordinatorRoute? = nil
    ) {
        self.selectedRoute = preselectedRoute
    }

    func openInfo() {
        selectedRoute = .dealershipInfo
    }
}
