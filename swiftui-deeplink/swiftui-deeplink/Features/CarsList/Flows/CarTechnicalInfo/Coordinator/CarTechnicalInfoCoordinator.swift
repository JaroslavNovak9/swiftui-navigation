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

    let viewAppeared = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

// MARK: - Init

    init(deepLink: DeepLink?) {
        self.deepLink = deepLink
        setupBinding()
    }

// MARK: - Bindings

    private func setupBinding() {
        viewAppeared
            .sink { [weak self] _ in
                self?.setupDeepLinking()
            }
            .store(in: &cancellables)
    }

// MARK: - Deep linking

    private func setupDeepLinking() {
        guard let deepLink = deepLink else {
            return
        }

        if case let .carAssistanceParametrized(deepLink) = deepLink {
            activeLink = .carAssistanceParametrized(deepLink: deepLink)
        } else if .carAssistance == deepLink.unparametrized {
            activeLink = .carAssistance
        }
    }

// MARK: - Coordinator view

    func provideCoordinatorView<T: View>(for content: @escaping () -> T) -> some View {
        CarTechnicalInfoCoordinatorView(
            coordinator: self,
            content: content
        )
    }

// MARK: - Providing views

    func provideCarAssistanceView() -> some View {
        var preselectedDeepLink: DeepLink?

        if
            case let .carAssistanceParametrized(deepLink) = activeLink
        {
            preselectedDeepLink = deepLink
        }

        return CarAssistanceView(
            viewModel: CarAssistanceVM(
                coordinator: CarAssistanceCoordinator(
                    deepLink: preselectedDeepLink
                )
            )
        )
    }
}
