//
//  ButtonStyle.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import SwiftUI



struct GreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 1.0, green: 1.0, blue: 100.0 / 255.0))
            .foregroundStyle(.black)
            .clipShape(Capsule())
    }
}
