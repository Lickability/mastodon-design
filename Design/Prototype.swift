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
    case linkPreview = "Link Preview Card"
    case groupedNotifs = "Grouped Notifications"
    case loosePostCell = "Just a loose post cell view"
    case userRows = "User Row Styles"
    
    @ViewBuilder @MainActor var view: some View {
        switch self {
        case .profile:
            ProfileView()
        case .timelineNavBar:
            TimelineNavBar()
        case .linkPreview:
            LinkPreviewCard()
        case .groupedNotifs:
            GroupedNotifications()
        case .loosePostCell:
            TimelinePostCell(showMediaGrid: true)
        case .userRows:
            UserList()
        }
    }
        
    var displayStyle: DisplayStyle {
        switch self {
        case .profile, .timelineNavBar, .linkPreview:
            return .fullScreenCover
        case .groupedNotifs, .loosePostCell, .userRows:
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
