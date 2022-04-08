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

    private var selectedLink: Binding<DeepLink?> {
        Binding {
            coordinator.selectedLink?.unparametrized
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

    private var navigationLinks: some View {
        NavigationLink(
            tag: .carDetail,
            selection: selectedLink,
            destination: coordinator.provideDetailView
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
