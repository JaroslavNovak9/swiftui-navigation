//
//  swiftui_deeplinkApp.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import SwiftUI

@main
struct swiftui_deeplinkApp: App {

    @StateObject private var deepLinkManager: DeepLinkManager = .init()

    var body: some Scene {
        WindowGroup {
            TabView(
                selection: $deepLinkManager.currentTab
            ) {
                Text("Home")
                    .environmentObject(deepLinkManager)
                    .tag(DeepLinkManager.Tab.home)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }

                CarsListView(
                    viewModel: .init(
                        carsListCoordinator: .init(deepLinkManager: deepLinkManager)
                    )
                )
                .tag(DeepLinkManager.Tab.list)
                .tabItem {
                    Image(systemName: "car")
                }
            }
            .environmentObject(deepLinkManager)
            .onOpenURL { url in
                // DEBUG
                if deepLinkManager.evaluateDeepLink(url: url) {
                    print("From deep link")
                } else {
                    print("Fall back")
                }
            }
        }
    }
}
