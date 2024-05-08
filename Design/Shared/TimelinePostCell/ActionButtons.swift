//
//  ActionButtons.swift
//  Design
//
//  Created by Sam on 2024-03-28.
//

import SwiftUI
import Pow

extension TimelinePostCell {
    struct ActionButtons: View {
        @State private var viewModel = SampleData.samplePost
        
        var body: some View {
            HStack(alignment: .center) {
                HStack(spacing: 24) {
                    PostActionButton(actionType: .reply(count: viewModel.repliesCount)) {
                        viewModel.addReply()
                    }
                    PostActionButton(actionType: .boost(count: viewModel.boosts, isSelected: viewModel.isBoosted)) {
                        viewModel.toggleBoost()
                    }
                    PostActionButton(actionType: .favorite(count: viewModel.favorites, isSelected: viewModel.isFavorited)) {
                        viewModel.toggleFavorite()
                    }
                }
                Spacer()
                PostActionButton(actionType: .share, action: nil)
            }
            .labelStyle(.iconOnly)
            .foregroundStyle(.secondary)
        }
    }
}

enum PostActionType {
    case reply(count: Int)
    case boost(count: Int, isSelected: Bool)
    case favorite(count: Int, isSelected: Bool)
    case share
}

struct PostActionButton: View {
    let actionType: PostActionType
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.subheadline)
                // Adjusted to correctly display the count based on actionType
                switch actionType {
                case .reply(let count),
                     .boost(let count, _),
                     .favorite(let count, _):
                    ZStack(alignment: .leading) {
                        Text("0000")
                            .fontWeight(.semibold)
                            .hidden()
                        if count > 0 {
                            Text(compactNumber(count))
                                .contentTransition(.numericText(value: Double(count)))
                        }
                    }
                    .font(.footnote)
                case .share:
                    EmptyView()
                }
            }
            .fontWeight(weight)
            .foregroundStyle(color)
        }
    }
    
    private var iconName: String {
        switch actionType {
        case .reply:
            return "bubble.left"
        case .boost:
            return "arrow.2.squarepath"
        case .favorite(_, let isSelected):
            return isSelected ? "star.fill" : "star"
        case .share:
            return "square.and.arrow.up"
        }
    }
    
    private var weight: Font.Weight {
        switch actionType {
        case .reply:
            return .regular
        case .boost(_, let isSelected):
            return isSelected ? .semibold : .regular
        case .favorite(_, let isSelected):
            return isSelected ? .semibold : .regular
        case .share:
            return .regular
        }
    }
    
    private var color: Color {
        switch actionType {
        case .reply, .share:
            return .secondary
        case .boost(_, let isSelected):
            return isSelected ? .accent : .secondary
        case .favorite(_, let isSelected):
            return isSelected ? .orange : .secondary
        }
    }
}


#Preview {
    TimelinePostCell.ActionButtons()
}
