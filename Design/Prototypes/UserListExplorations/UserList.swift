//
//  UserList.swift
//  Design
//
//  Created by Sam on 2024-05-29.
//

import SwiftUI

struct UserList: View {
    var body: some View {
        List {
            UserRowCell(elements: [.inlinePostPreview, .followButton(.regular)])
            UserRowCell(elements: [.mutualFollowers, .followButton(.iconOnly)])
            UserRowCell(elements: [.socialProofOverline, .followButton(.regular), .inlinePostPreview, .mutualFollowers])
            UserRowCell(elements: [.socialProofOverline, .followButton(.regular), .bio])
            UserRowCell(elements: [.socialProofOverline, .followButton(.regular), .followerCount])
        }
        .listStyle(.plain)
        .font(.callout)
    }
}

fileprivate struct CellAccessoryAtoms {
    private var avatarSize = Design.Grid.minTapTarget
    var horizontalSpacing = Design.Grid.s1_5
    
    @ViewBuilder
    func MutualFollowers() -> some View {
        VStack(alignment: .leading) {
            AvatarGroupRow(count: 3)
            Text("Followed by Fullname One, Fullname Two, and 1.4K others")
        }
    }
    
    @ViewBuilder
    func Avatar() -> some View {
        Image("avatar")
            .resizable()
            .scaledToFill()
            .frame(width: avatarSize, height: avatarSize)
            .clipShape(RoundedRectangle(cornerRadius: Design.Grid.s1_5))
    }
    
    @ViewBuilder
    func FollowButton(style: FollowButtonStyle) -> some View {
        switch style {
        case .regular:
            Button(action: {}, label: {
                Text("Follow back")
                    .font(.subheadline)
                    .bold()
            })
            .buttonStyle(.borderedProminent)
            .controlSize(.small)
            
        case .iconOnly:
            Button(action: {}, label: {
//                We're doing this clear circle thing so the icon retains somewhat of a square shape
                Image(systemName: "ellipsis.circle")
                    .font(.title3)
                    .imageScale(.large)
                    .foregroundStyle(.tint, .clear)
            })
        }
    }
    
    @ViewBuilder
    func UsernameFollowLockup() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Sam Henri Gold")
                    .bold()
                Text(verbatim: "@samhenrigold@example.social")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .lineLimit(1)
        }
    }
    
    @ViewBuilder
    func SocialProofOverline() -> some View {
        HStack(spacing: horizontalSpacing) {
            Spacer()
                .frame(width: avatarSize)
            Text("Popular among people you follow")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

enum UIElement: Hashable {
    case mutualFollowers
    case followButton(FollowButtonStyle)
    case socialProofOverline
    case inlinePostPreview
    case followerCount
    case bio
}

enum FollowButtonStyle {
    case regular
    case iconOnly
}


fileprivate func UserRowCell(elements: Set<UIElement>) -> some View {
    let atoms = CellAccessoryAtoms()
    
    return VStack(alignment: .leading, spacing: Design.Grid.s_5) {
        
        if elements.contains(.socialProofOverline) {
            atoms.SocialProofOverline()
        }
        
        HStack(alignment: .top, spacing: atoms.horizontalSpacing) {
            
            atoms.Avatar()
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    atoms.UsernameFollowLockup()
                    if elements.contains(where: { if case .followButton = $0 { return true } else { return false } }) {
                        if case let .followButton(buttonStyle) = elements.first(where: { if case .followButton = $0 { return true } else { return false } }) {
                            Spacer()
                            atoms.FollowButton(style: buttonStyle)
                        }
                    }
                    
                }
                
                if elements.contains(.mutualFollowers) {
                    atoms.MutualFollowers()
                }
                
                if elements.contains(.inlinePostPreview) {
                    InlinePostPreview(post: SampleData.samplePost, needsUserAttribution: false, isPinned: true)
                }
                
                if elements.contains(.bio) {
                    Text("Consectetur esse incididunt elit proident sit est. Nostrud et Lorem occaecat consequat deserunt elit esse ipsum eu.")
                        .lineLimit(2)
                }
                
                if elements.contains(.followerCount) {
                    Text("11.4K followers")
                }
            }
        }
        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
            return -viewDimensions.width
        }
    }
}

#Preview {
    UserList()
}
