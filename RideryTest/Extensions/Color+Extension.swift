//
//  Color+Extension.swift
//  RideryTest
//
//  Created by Luis Guerra on 15/6/23.
//

import Foundation
import SwiftUI

extension Color {
    static func random() -> Color{
        return Color(UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0))
    }
}
