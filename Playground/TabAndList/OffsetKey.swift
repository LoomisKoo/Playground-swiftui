//
//  OffsetKey.swift
//  Playground
//
//  Created by Loomis Koo on 2023/3/8.
//

import SwiftUI


// MARK: - OffsetKey

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
