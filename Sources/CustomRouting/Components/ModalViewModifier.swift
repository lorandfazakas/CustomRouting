//
//  ModalViewModifier.swift
//  ArchitectureBootcamp
//
//  Created by Loránd Fazakas on 2025. 05. 04..
//

import SwiftUI

struct ModalSupportView<Content: View>: View {
    
    var backgroundColor: Color
    var transition: AnyTransition
    @Binding var showModal: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            if showModal {
                backgroundColor
                    .ignoresSafeArea()
                    .transition(AnyTransition.opacity.animation(.smooth))
                    .onTapGesture {
                        showModal = false
                    }
                    .zIndex(1)
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Without this the modal, came in and exited before the edge of the device. Try it with preview
                    .ignoresSafeArea()
                    .transition(transition)
                    .zIndex(2)
            }
        }
        .zIndex(9999)
        .animation(.bouncy, value: showModal)
    }
}

extension View {
    func modalViewModifier(backgroundColor: Color, transition: AnyTransition, screen: Binding<AnyDestination?>) -> some View {
        self
            .overlay(
                ModalSupportView(backgroundColor: backgroundColor, transition: transition, showModal: Binding(ifNotNil: screen)) {
                    ZStack {
                        if let screen = screen.wrappedValue {
                            screen.destination
                        }
                    }
                }
            )
    }
}
