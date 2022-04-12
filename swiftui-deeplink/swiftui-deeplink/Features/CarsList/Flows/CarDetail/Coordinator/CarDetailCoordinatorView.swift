//
//  CarDetailCoordinatorView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

struct CarDetailCoordinatorView<Content: View>: View {

    @StateObject var coordinator: CarDetailCoordinator
    let content: () -> Content

    private var activeLink: Binding<CarDetailCoordinator.ScreenLink?> {
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
        Group {
            NavigationLink(
                tag: .carTechnicalInfo,
                selection: activeLink,
                destination: coordinator.provideTechnicalInfoView
            ) { EmptyView() }

            NavigationLink(
                tag: .carAssistance,
                selection: activeLink,
                destination: coordinator.provideCarAssistanceView
            ) { EmptyView() }

            NavigationLink(
                tag: .carDetail,
                selection: activeLink,
                destination: coordinator.provideCarDetailView
            ) { EmptyView() }
        }
    }
}

struct CarDetailCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailCoordinatorView(
            coordinator: .init(
                deepLink: nil
            ),
            content: { EmptyView() }
        )
    }
}
