//
//  CarDetailCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import Combine
import SwiftUI

final class CarDetailCoordinator: ObservableObject {

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

        if case let .carTechnicalInfoParametrized(deepLink) = deepLink {
            activeLink = .carTechnicalInfoParametrized(
                deepLink: deepLink
            )
        } else if .carTechnicalInfo == deepLink {
            activeLink = .carTechnicalInfo
        }
    }

// MARK: - Making coordinators

    private func makeCarTechnicalInfoCoordinator() -> CarTechnicalInfoCoordinator {
        .init(
            deepLink: deepLink
        )
    }

// MARK: - Making views

    func provideCoordinatorView<T: View>(for content: @escaping () -> T) -> some View {
        CarDetailCoordinatorView(
            coordinator: self,
            content: content
        )
    }

    func provideTechnicalInfoView() -> some View {
        CarTechnicalInfoView(
            viewModel: .init(
                coordinator: self.makeCarTechnicalInfoCoordinator()
            )
        )
    }
}
