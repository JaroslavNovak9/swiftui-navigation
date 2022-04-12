//
//  CarTechnicalInfoView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

struct CarTechnicalInfoView: View {

    @StateObject var viewModel: CarTechnicalInfoVM

    var body: some View {
        viewModel.coordinator.provideCoordinatorView(for: content)
    }

    private func content() -> some View {
        VStack {
            Text("Car technical info")

            assistanceButton
        }
    }

    private var assistanceButton: some View {
        button(
            action: viewModel.openCarAssistance,
            text: "Car assistance"
        )
    }

    private func button(
        action: @escaping () -> Void,
        text: String
    ) -> some View {
        Button {
            action()
        } label: {
            Text(text)
                .fontWeight(.bold)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(.black)
        .foregroundColor(.white)
        .cornerRadius(16)
    }
}

struct CarTechnicalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CarTechnicalInfoView(
            viewModel: .init(
                coordinator: .init(
                    deepLink: nil
                )
            )
        )
    }
}
