//
//  CarTechnicalInfoCoordinatorView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 08.04.2022.
//

import SwiftUI

struct CarTechnicalInfoCoordinatorView<Content: View>: View {

    @ObservedObject var coordinator: CarTechnicalInfoCoordinator
    let content: () -> Content

    private var selectedLink: Binding<DeepLink?> {
        Binding {
            coordinator.selectedLink?.unparametrized
        } set: {
            coordinator.selectedLink = $0
        }
    }

    var body: some View {
        ZStack {
            content()

            navigationLinks
        }
    }

    private var navigationLinks: some View {
        NavigationLink(
            tag: .carAssistance,
            selection: selectedLink,
            destination: coordinator.provideCarAssistanceView
        ) {
            EmptyView()
        }
    }
}

struct CarTechnicalInfoCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CarTechnicalInfoCoordinatorView(
            coordinator: .init(
                deepLinkManager: .init()
            ),
            content: { EmptyView() }
        )
    }
}
