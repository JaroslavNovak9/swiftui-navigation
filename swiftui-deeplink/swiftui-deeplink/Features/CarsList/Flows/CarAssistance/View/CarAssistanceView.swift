//
//  CarAssistanceView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 08.04.2022.
//

import SwiftUI

struct CarAssistanceView: View {

    @ObservedObject var viewModel: CarAssistanceVM

    var body: some View {
        viewModel.coordinator.provideCoordinatorView(for: content)
    }

    private func content() -> some View {
        Text("Car assistance")
            .navigationTitle("Assistance")
    }
}

struct CarAssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        CarAssistanceView(
            viewModel: CarAssistanceVM(
                coordinator: CarAssistanceCoordinator(
                    deepLink: nil
                )
            )
        )
    }
}
