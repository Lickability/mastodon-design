//
//  TimelineNavBar.swift
//  Design
//
//  Created by Sam on 2024-03-27.
//

import SwiftUI

struct TimelineNavBar: View {
    enum TimelineMode: String, CaseIterable, Identifiable {
        case following, local
        var id: Self { self }
    }
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedTimelineMode: TimelineMode = .following
    @State private var isShowingPill = false

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                List {
                    ForEach(UIFont.familyNames, id: \.self) { font in
                        Text(font)
                            .id(font.hashValue)
                    }
                }
                .overlay(alignment: .top, content: {
                    TimelinePill(isPresented: $isShowingPill, reason: .newPosts, action: {
                        withAnimation(.bouncy) {
                            proxy.scrollTo(UIFont.familyNames.first?.hashValue)
                            isShowingPill = false
                        }
                    })
                })
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Timeline View", selection: $selectedTimelineMode) {
                            Text("Following").tag(TimelineMode.following)
                            Text("Local").tag(TimelineMode.local)
                        }
                    } label: {
                        HStack {
                            Text(selectedTimelineMode.rawValue.capitalized)
                                .font(.headline)
                                .foregroundStyle(Color(uiColor: .label))
                            Image(systemName: "chevron.down.circle.fill")
                                .foregroundStyle(Color(uiColor: .secondaryLabel), Color(uiColor: .secondarySystemFill))
                                .font(.subheadline)
                        }
                    }
                    .animation(.default.speed(2), value: selectedTimelineMode)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings", systemImage: "gear") {
                        withAnimation(.bouncy) {
                            isShowingPill.toggle()
                        }
                    }
                    .tint(.accent)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    TimelineNavBar()
}
