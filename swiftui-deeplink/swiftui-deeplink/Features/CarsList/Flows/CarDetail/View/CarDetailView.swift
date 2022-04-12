//
//  CarDetailView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import SwiftUI

struct CarDetailView: View {

    @Environment(\.presentationMode) private var presentationMode

    @StateObject var viewModel: CarDetailVM

    var body: some View {
        viewModel.coordinator.provideCoordinatorView(for: content)
    }

    private func content() -> some View {
        VStack(
            spacing: 8
        ) {
            Spacer()
            carDescription
            Spacer()
            technicalButton
            Spacer()
            backButton
            Spacer()
        }
        .navigationTitle("Detail vozidla")
    }

    private var carDescription: some View {
        VStack {
            DescriptionLine(
                description: "Výrobce",
                value: viewModel.carBrandString
            )
            DescriptionLine(
                description: "Model",
                value: viewModel.carModelString
            )
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 32)
        .background(
            LinearGradient(
              gradient: Gradient(
                colors: [
                    Color(red: 31/255, green: 17/255, blue: 206/255),
                    Color(red: 229/255, green: 43/255, blue: 43/255)
                ]
              ),
              startPoint: .init(x: 0.00, y: 0.50),
              endPoint: .init(x: 1.00, y: 0.50)
            )
        )
        .cornerRadius(32)
    }

    private var technicalButton: some View {
        button(
            action: {
                viewModel.openTechnicalInfo()
            },
            text: "Technické informace"
        )
    }

    private var backButton: some View {
        button(
            action: {
                presentationMode.wrappedValue.dismiss()
            },
            text: "Přejít zpět"
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

    private struct DescriptionLine: View {

        let description: String
        let value: String

        var body: some View {
            HStack(
                spacing: 4
            ) {
                Text("\(description): ")
                    .fontWeight(.light)
                    .foregroundColor(.white)
                Text(value)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}

struct CarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailView(
            viewModel: .init(
                carBrandString: "BMW",
                carModelString: "e46",
                coordinator: .init(
                    deepLink: nil
                )
            )
        )
    }
}
