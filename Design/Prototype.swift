//
//  Prototype.swift
//  Design
//
//  Created by mb on 3/27/24.
//

import Foundation
import SwiftUI

enum Prototype: String, CaseIterable, Identifiable, CustomStringConvertible {
    enum DisplayStyle {
        case sheet
        case fullScreenCover
        case navigationLink
    }
    
    case profile = "Profile"
    case timelineNavBar = "Timeline Nav Bar"
    
    @ViewBuilder @MainActor var view: some View {
        switch self {
        case .profile:
            ProfileView()
        case .timelineNavBar:
            TimelineNavBar()
        }
    }
        
    var displayStyle: DisplayStyle {
        switch self {
        case .profile:
            return .fullScreenCover
        case .timelineNavBar:
            return .fullScreenCover
        }
    }
    
    // MARK: - Identifiable
    
    var id: String {
        return rawValue
    }
    
    // MARK: - CustomStringConvertible
    var description: String {
        rawValue
    }
}
