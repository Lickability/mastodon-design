//
//  TimelinePillView.swift
//  MastodonNavBar
//
//  Created by Sam on 2024-03-27.
//

import SwiftUI

enum TimelinePillReason: String, CaseIterable, Identifiable {
    case newPosts, postSuccess, offline
    
    var id: Self { self }
    
    var display: (text: String, systemImage: String, color: Color) {
        switch self {
        case .newPosts:
            return ("New Posts", "chevron.up", .accent)
        case .postSuccess:
            return ("Post Sent", "checkmark", .green)
        case .offline:
            return ("Offline", "bolt.horizontal.fill", .gray)
        }
    }
}

struct TimelinePillButtonStyle: ButtonStyle {
    let reason: TimelinePillReason
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .bold()
            .padding(.horizontal)
            .padding(.vertical, 8)
            .foregroundStyle(configuration.isPressed ? .white.opacity(0.5) : .white)
            .background(reason.display.color)
            .clipShape(Capsule())
            .shadow(color: reason.display.color.opacity(0.15), radius: 8, x: 0, y: 8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.default.speed(2.5), value: configuration.isPressed)
    }
}

struct TimelinePill: View {
    @Binding var isPresented: Bool
    var reason: TimelinePillReason
    var action: (() -> Void)?
    
    var body: some View {
        if isPresented {
            withAnimation(.bouncy) {
                Button(action: {
                    action?()
                }) {
                    Label(reason.display.text, systemImage: reason.display.systemImage)
                }
                .buttonStyle(TimelinePillButtonStyle(reason: reason))
                .padding(.top)
                .transition(.asymmetric(
                    insertion: .push(from: .top),
                    removal: .push(from: .bottom)
                ))
            }
        }
    }
}

#Preview {
    TimelinePill(isPresented: .constant(true), reason: .newPosts, action: {})
}
