//
//  CarsListCoordinatorView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

struct CarsListCoordinatorView<Content: View>: View {

    @StateObject var coordinator: CarsListCoordinator
    let content: () -> Content

    private var activeLink: Binding<CarsListCoordinator.ScreenLink?> {
        Binding {
            coordinator.activeLink?.unparametrized
        } set: {
            coordinator.activeLink = $0
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

    private var navigationLinks: some View {
        Group {
            NavigationLink(
                tag: .carDetail,
                selection: activeLink,
                destination: coordinator.provideDetailView
            ) { EmptyView() }

            NavigationLink(
                tag: .carAssistance,
                selection: activeLink,
                destination: coordinator.provideAssistanceView
            ) { EmptyView() }

            NavigationLink(
                tag: .carTechnicalInfo,
                selection: activeLink,
                destination: coordinator.provideTechnicalInfoView
            ) { EmptyView() }
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
