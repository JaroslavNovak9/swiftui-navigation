//
//  IdentificationView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 11.04.2022.
//

import SwiftUI

struct IdentificationView: View {

    @StateObject var viewModel: IdentificationVM

    var body: some View {
        viewModel.coordinator.provideCoordinatorView(for: content)
    }

    private func content() -> some View {
        VStack {
            Text("Identify yourself!")

            Button {
                viewModel.identifyTapped.send()
            } label: {
                Text("Identify")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct IdentificationView_Previews: PreviewProvider {
    static var previews: some View {
        IdentificationView(
            viewModel: .init(
                identified: .constant(false),
                coordinator: .init(
                    deepLinkManager: .init()
                )
            )
        )
    }
}
