//
//  LandingView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI

struct LandingView: View {
    var onDismiss: () -> Void

    @State private var animate = false
    @State private var completed = false

    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            if !completed {
                Image("logoImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .modifier(ShakeEffect(shakes: animate ? 2 : 0))
                    .onReceive(timer) { _ in
                        completed = true
                        onDismiss()
                    }
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5).repeatCount(5, autoreverses: true)) {
                            animate = true
                        }
                    }
            }
        }
    }
}

struct ShakeEffect: GeometryEffect {
    var shakes: CGFloat = 0

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translationX = sin(shakes * .pi * 6) * 10 // Shaking intensity
        return ProjectionTransform(CGAffineTransform(translationX: translationX, y: 0))
    }
}
