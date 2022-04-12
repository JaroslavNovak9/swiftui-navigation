//
//  CarAssistanceCoordinatorView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 12.04.2022.
//

import SwiftUI

struct CarAssistanceCoordinatorView<Content: View>: View {

    @StateObject var coordinator: CarAssistanceCoordinator
    let content: () -> Content

    private var activeLink: Binding<CarAssistanceCoordinator.ScreenLink?> {
        Binding {
            coordinator.activeLink?.unparametrized
        } set: {
            coordinator.activeLink = $0
        }
    }

    var body: some View {
        ZStack {
            content()

            navigationLinks
        }
        .onAppear(perform: coordinator.viewAppeared.send)
    }

    private var navigationLinks: some View {
        NavigationLink(
            tag: .carTechnicalInfo,
            selection: activeLink,
            destination: coordinator.provideTechnicalInfoView
        ) { EmptyView() }
    }
}

struct CarAssistanceCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CarAssistanceCoordinatorView(
            coordinator: .init(deepLink: nil),
            content: { EmptyView() }
        )
    }
}
