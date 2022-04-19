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
    @State private var isUserIdentified: Bool = false

    var body: some Scene {
        WindowGroup {
            Group {
                if isUserIdentified {
                    identifiedContent
                        .onAppear(perform: deepLinkManager.repeatDeepLinkCall)
                } else {
                    identification
                }
            }
            .onReceive(NotificationCenter.default.publisher(
                for: UIApplication.willEnterForegroundNotification
            )) { _ in
               isUserIdentified = false
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

    private var identifiedContent: some View {
            TabView(
                selection: $deepLinkManager.currentTab
            ) {
                Text("Home")
                    .environmentObject(deepLinkManager)
                    .tag(DeepLinkManager.Tab.home)
                    .navigationTitle("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }

                CarsListView(
                    viewModel: CarsListVM(
                        coordinator: CarsListCoordinator(
                            deepLinkManager: deepLinkManager
                        )
                    )
                )
                .tag(DeepLinkManager.Tab.list)
                .tabItem {
                    Image(systemName: "car")
                }

                CarDealershipView(
                    viewModel: CarDealershipVM(
                        // Deep link nesting will be done same as the line below
                        //preselectedRoute: .dealershipInfo
                    )
                )
                .tag(DeepLinkManager.Tab.dealership)
                .tabItem {
                    Image(systemName: "globe")
                }
        }
        .navigationViewStyle(.stack)
    }

    private var identification: some View {
        IdentificationView(
            viewModel: IdentificationVM(
                identified: $isUserIdentified,
                coordinator: IdentificationCoordinator(
                    deepLinkManager: deepLinkManager
                )
            )
        )
    }
}
