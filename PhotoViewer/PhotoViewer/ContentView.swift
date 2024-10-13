//
//  ContentView.swift
//  PhotoViewer
//
//  Created by Isabel Quijada on 30.09.24.
//
//
//  ContentView.swift
//  PhotoViewer
//
//  Created by Isabel Quijada on 30.09.24.
//

import SwiftUI

struct ContentView: View {
    @GestureState private var gestureOffset: CGSize = .zero
    @GestureState private var gestureScale: CGFloat = 1
    @GestureState private var gestureRotation: Angle = .degrees(0)
    
    @State private var offset: CGSize = .zero
    @State private var scale: CGFloat = 1
    @State private var rotation: Angle = .degrees(0)

    var body: some View {
        VStack {
            Image(.igel)
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .scaleEffect(scale * gestureScale)
                .rotationEffect(rotation + gestureRotation)
                .offset(
                    x: offset.width + gestureOffset.width,
                    y: offset.height + gestureOffset.height
                )
                .gesture(
                    dragGesture
                        .simultaneously(with: magnifyGesture)
                        .simultaneously(with: rotationGesture)
                )
        }
    }
    
    // Definimos los gestos fuera de body para mayor claridad
    var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                offset.width += value.translation.width
                offset.height += value.translation.height
            }
    }

    var magnifyGesture: some Gesture {
        MagnificationGesture()
            .updating($gestureScale) { value, state, _ in
                state = value
            }
            .onEnded { value in
                scale *= value
            }
    }

    var rotationGesture: some Gesture {
        RotationGesture()
            .updating($gestureRotation) { value, state, _ in
                state = value
            }
            .onEnded { value in
                rotation += value
            }
    }
}

#Preview {
    ContentView()
}
