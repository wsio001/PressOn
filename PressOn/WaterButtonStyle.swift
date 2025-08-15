//
//  WaterButtonStyle.swift
//  test
//
//  Created by William Sio on 7/23/25.
//

import SwiftUI

struct WaterDropButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .background(
                Circle()
                    .fill(.blue.opacity(0.2))
                    .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
                    .opacity(configuration.isPressed ? 1.0 : 0.0)
                    .animation(.easeOut(duration: 0.4), value: configuration.isPressed)
            )
    }
}
