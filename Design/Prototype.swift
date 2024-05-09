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
    case loosePostCell = "Just a loose post cell view"
    
    @ViewBuilder @MainActor var view: some View {
        switch self {
        case .profile:
            ProfileView()
        case .timelineNavBar:
            TimelineNavBar()
        case .groupedNotifs:
            GroupedNotifications()
        case .loosePostCell:
            TimelinePostCell(showMediaGrid: true)
        }
    }
        
    var displayStyle: DisplayStyle {
        switch self {
        case .profile, .timelineNavBar:
            return .fullScreenCover
        case .groupedNotifs, .loosePostCell:
            return .navigationLink
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
