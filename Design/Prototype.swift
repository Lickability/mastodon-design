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
    case groupedNotifs = "Grouped Notifications"
    
    @ViewBuilder @MainActor var view: some View {
        switch self {
        case .profile:
            ProfileView()
        case .timelineNavBar:
            TimelineNavBar()
        case .groupedNotifs:
            GroupedNotifications()
        }
    }
        
    var displayStyle: DisplayStyle {
        switch self {
        case .profile, .timelineNavBar, .groupedNotifs:
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
