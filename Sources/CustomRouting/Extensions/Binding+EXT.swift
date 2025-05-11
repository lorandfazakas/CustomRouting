//
//  Binding+EXT.swift
//  ArchitectureBootcamp
//
//  Created by Loránd Fazakas on 2025. 05. 04..
//

import SwiftUI

extension Binding where Value == Bool {
    
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
    
}
