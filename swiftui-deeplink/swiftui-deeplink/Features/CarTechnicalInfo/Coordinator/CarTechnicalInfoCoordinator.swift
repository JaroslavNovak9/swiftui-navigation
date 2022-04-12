//
//  CarTechnicalInfoCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 08.04.2022.
//

import Combine
import SwiftUI

final class CarTechnicalInfoCoordinator: ObservableObject {

    private var deepLink: DeepLink?
    @Published var activeLink: ScreenLink?

// MARK: - Init

    init(deepLink: DeepLink?) {
        self.deepLink = deepLink
        // Setup
        setupDeepLinking()
    }

// MARK: - Bindings

    private func setupDeepLinking() {
        guard let deepLink = deepLink else {
            return
        }

        print("ZDE \(deepLink.unparametrized)")

        if deepLink.unparametrized == .carAssistance {
            print("Setting up active link")
            activeLink = .carAssistance
        }
    }

// MARK: - Making Views

    func provideCoordinatorView<T: View>(for content: @escaping () -> T) -> some View {
        CarTechnicalInfoCoordinatorView(
            coordinator: self,
            content: content
        )
    }

    func provideCarAssistanceView() -> some View {
        CarAssistanceView()
    }
}
