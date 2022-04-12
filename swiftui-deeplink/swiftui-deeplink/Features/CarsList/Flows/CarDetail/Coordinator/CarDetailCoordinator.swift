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
            activeLink = .carTechnicalInfoParametrized(
                deepLink: deepLink
            )
        } else if case let .carDetailParametrized(_, _, deepLink) = deepLink {
            activeLink = .carDetailParametrized(
                deepLink: deepLink
            )
        } else if case let .carAssistanceParametrized(deepLink) = deepLink {
            activeLink = .carAssistanceParametrized(
                deepLink: deepLink
            )
        } else if .carAssistance == deepLink {
            activeLink = .carAssistance
        } else if .carDetail == deepLink {
            activeLink = .carDetail
        } else if .carTechnicalInfo == deepLink {
            activeLink = .carTechnicalInfo
        }
    }

// MARK: - Making coordinators

    private func makeCarTechnicalInfoCoordinator(
        deepLink: DeepLink?
    ) -> CarTechnicalInfoCoordinator {
        .init(deepLink: deepLink)
    }

// MARK: - Coordinator view

    func provideCoordinatorView<T: View>(for content: @escaping () -> T) -> some View {
        CarDetailCoordinatorView(
            coordinator: self,
            content: content
        )
    }

// MARK: - Providing views

    func provideCarDetailView() -> some View {
        var preselectedDeepLink: DeepLink?

        if case let .carDetailParametrized(deepLink) = activeLink {
            preselectedDeepLink = deepLink
        }

        return CarDetailView(
            viewModel: CarDetailVM(
                carBrandString: "",
                carModelString: "",
                coordinator: .init(deepLink: preselectedDeepLink)
            )
        )
    }

    func provideTechnicalInfoView() -> some View {
        var preselectedDeepLink: DeepLink?

        if case let .carTechnicalInfoParametrized(deepLink) = activeLink {
            preselectedDeepLink = deepLink
        }

        return CarTechnicalInfoView(
            viewModel: .init(
                coordinator: self.makeCarTechnicalInfoCoordinator(
                    deepLink: preselectedDeepLink
                )
            )
        )
    }

    func provideCarAssistanceView() -> some View {
        var preselectedDeepLink: DeepLink?

        if case let .carAssistanceParametrized(deepLink) = activeLink {
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
