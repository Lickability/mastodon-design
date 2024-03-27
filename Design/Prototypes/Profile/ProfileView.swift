//
//  ProfileView.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import SwiftUI
import SwiftUIIntrospect

struct ProfileView: View {
    @StateObject var viewModel = ChipsViewModel(chips: chips)
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16, content: {
                    Image("banner")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 144)
                        .clipped()
                        .padding(.horizontal, -16)
                    HStack(alignment: .bottom, spacing: 16) {
                        ZeroHeightAvatarView(Image("Avatar23Still"))
                        UsernameLockup()
                    }
                    .padding(.horizontal)
                    Text("Officia minim irure minim consectetur reprehenderit. Fugiat anim enim laboris magna est dolore est sit qui ullamco est aute.\n\nElit nostrud aliqua et fugiat amet officia nostrud labore duis dolore.")
                        .padding(.horizontal)
                    HStack(spacing: 16) {
                        FollowersFollowingCount(count: 2603, text: "followers")
                        FollowersFollowingCount(count: 501, text: "following")
                    }
                    .foregroundStyle(.primary)
                    .padding(.horizontal)
                    HStack {
                        Button(action: {}, label: {
                            Label("Follow", systemImage: "pencil")
                                .labelStyle(.titleOnly)
                                .frame(maxWidth: .infinity)
                                .bold()
                                .padding(5)
                        })
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        Button(action: {}, label: {
                            Label("Scan QR Code", systemImage: "qrcode.viewfinder")
                                .labelStyle(.iconOnly)
                                .imageScale(.large)
                                .padding(3)
                        })
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.circle)
                    }
                    .padding(.horizontal)
                    ScrollView(.horizontal, content: {
                        HStack {
                            ForEach(viewModel.chips) { chip in
                                ChipView(chip: chip, viewModel: viewModel)
                            }
                        }
                    })
                    .foregroundStyle(.primary)
                    .scrollIndicators(.hidden)
                    .contentMargins(.horizontal, 16, for: .scrollContent)
                })
                .font(.subheadline)
                .frame(maxWidth: .infinity)
            }
            .toolbar(content: {
                Button("Close") {
                    dismiss()
                }
            })
            .navigationTitle("sam henri gold")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
