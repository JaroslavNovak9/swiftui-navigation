//
//  CarsListCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import Combine
import SwiftUI

final class CarsListCoordinator: ObservableObject {

    @Published var activeLink: CarsListCoordinator.ScreenLink?
    private let deepLinkManager: DeepLinkManager

    let activeLinkSubject = PassthroughSubject<CarsListCoordinator.ScreenLink?, Never>()
    private var cancellables = Set<AnyCancellable>()

// MARK: - Init

    init(deepLinkManager: DeepLinkManager) {
        self.deepLinkManager = deepLinkManager
        // Setup
        setupBindings()
        setupDeepLinking()
    }

// MARK: - Bindings

    private func setupBindings() {
        activeLinkSubject
            .sink { [weak self] requestedLink in
                self?.activeLink = requestedLink
            }
            .store(in: &cancellables)
    }

    private func setupDeepLinking() {
        deepLinkManager
            .outDeepLink
            .sink { [weak self] deepLink in
                guard let deepLink = deepLink else { return }

                if case let .carDetailParametrized(carBrand, carModel, deepLink) = deepLink {
                    self?.activeLink = .carDetailParametrized(
                        carBrand: carBrand,
                        carModel: carModel,
                        deepLink: deepLink
                    )
                } else if case let .carTechnicalInfoParametrized(deepLink) = deepLink {
                    self?.activeLink = .carTechnicalInfoParametrized(
                        deepLink: deepLink
                    )
                } else if case let .carAssistanceParametrized(deepLink) = deepLink {
                    self?.activeLink = .carAssistanceParametrized(
                        deepLink: deepLink
                    )
                } else if .carAssistance == deepLink {
                    self?.activeLink = .carAssistance
                }
            }
            .store(in: &cancellables)
    }

// MARK: - Making coordinators

    private func makeCarDetailCoordinator(
        deepLink: DeepLink?
    ) -> CarDetailCoordinator {
        .init(deepLink: deepLink)
    }

    private func makeCarTechnicalInfoCoordinator(
        deepLink: DeepLink?
    ) -> CarTechnicalInfoCoordinator {
        .init(deepLink: deepLink)
    }

// MARK: - Making views

    func provideCoordinatorView<T: View>(for content: @escaping () -> T) -> some View {
        CarsListCoordinatorView(
            coordinator: self,
            content: content
        )
    }

    func provideAssistanceView() -> some View {
        var preselectedDeepLink: DeepLink?

        if
            case let .carAssistanceParametrized(deepLink) = activeLink
        {
            preselectedDeepLink = deepLink
        }

        let view: CarAssistanceView = .init(
            viewModel: CarAssistanceVM(
                coordinator: CarAssistanceCoordinator(
                    deepLink: preselectedDeepLink
                )
            )
        )

        return view
    }

    func provideTechnicalInfoView() -> some View {
        var preselectedDeepLink: DeepLink?

        if
            case let .carTechnicalInfoParametrized(deepLink: deepLink) = activeLink
        {
            preselectedDeepLink = deepLink
        }

        return CarTechnicalInfoView(
            viewModel: CarTechnicalInfoVM(
                coordinator: self.makeCarTechnicalInfoCoordinator(deepLink: preselectedDeepLink)
            )
        )
    }

    func provideDetailView() -> some View {
        var carBrandString: String?
        var carModelString: String?
        var preselectedDeepLink: DeepLink?

        if
            case let .carDetailParametrized(carBrand, carModel, deepLink) = activeLink
        {
            carBrandString = carBrand
            carModelString = carModel
            preselectedDeepLink = deepLink
        }

        let viewModel: CarDetailVM = .init(
            carBrandString: carBrandString ?? "",
            carModelString: carModelString ?? "",
            coordinator: makeCarDetailCoordinator(
                deepLink: preselectedDeepLink
            )
        )
        let view: CarDetailView = .init(viewModel: viewModel)
        return view
    }
}
