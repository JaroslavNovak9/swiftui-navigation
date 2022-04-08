//
//  CarsListCoordinatorView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

struct CarsListCoordinatorView<Content: View>: View {

    @ObservedObject var coordinator: CarsListCoordinator
    let content: () -> Content

    private var selectedLink: Binding<CarsListCoordinator.Flow?> {
        Binding {
            coordinator.selectedLink?.navigationLink
        } set: {
            coordinator.selectedLink = $0
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                content()

                navigationLinks
            }
        }
    }

    private func detailDestination() -> some View {
        var carBrandString: String?
        var carModelString: String?
        var nestedLink: CarDetailCoordinator.Flow?

        if
            case let .detailParametrized(carBrand, carModel, deepLink) = coordinator.selectedLink
        {
            carBrandString = carBrand
            carModelString = carModel

            // TODO: - Add mapping
            switch deepLink {
            case .technicalInfo:
                nestedLink = .technicalInfo
            default:
                break
            }
        }

        let viewModel: CarDetailVM = .init(
            carBrandString: carBrandString ?? "",
            carModelString: carModelString ?? "",
            carDetailCoordinator: .init(
                deepLinkManager: .init(),
                preselectedLink: nestedLink
            )
        )
        let view: CarDetailView = .init(viewModel: viewModel)

        return view
    }

    private var navigationLinks: some View {
        NavigationLink(
            tag: .detail,
            selection: selectedLink,
            destination: detailDestination
        ) {
            EmptyView()
        }
    }
}

struct CarsListCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CarsListCoordinatorView(
            coordinator: .init(
                deepLinkManager: .init()
            ),
            content: { EmptyView() }
        )
    }
}
