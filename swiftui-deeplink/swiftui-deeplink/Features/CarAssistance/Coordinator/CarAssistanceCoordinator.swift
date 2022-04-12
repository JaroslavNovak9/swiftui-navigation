//
//  CarAssistanceCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 12.04.2022.
//

import Combine
import SwiftUI

final class CarAssistanceCoordinator: ObservableObject {

    private var deepLink: DeepLink?
    @Published var activeLink: ScreenLink?

    let viewAppeared = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

// MARK: - Init

    init(deepLink: DeepLink?) {
        self.deepLink = deepLink
        // Setup
        setupBindings()
    }

// MARK: - Bindings

    private func setupBindings() {
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

        if case let .carTechnicalInfoParametrized(deepLink) = deepLink {
            activeLink = .carTechnicalInfoParametrized(deepLink: deepLink)
        } else if .carTechnicalInfo == deepLink {
            activeLink = .carTechnicalInfo
        }
    }

// MARK: - Coordinator view

    func provideCoordinatorView<T: View>(for content: @escaping () -> T) -> some View {
        CarAssistanceCoordinatorView(
            coordinator: .init(deepLink: self.deepLink),
            content: content
        )
    }

// MARK: - Providing views

    func provideTechnicalInfoView() -> some View {
        var preselectedDeepLink: DeepLink?

        if
            case let .carTechnicalInfoParametrized(deepLink) = activeLink
        {
            preselectedDeepLink = deepLink
        }

        return CarTechnicalInfoView(
            viewModel: CarTechnicalInfoVM(
                coordinator: CarTechnicalInfoCoordinator(deepLink: preselectedDeepLink)
            )
        )
    }
}
