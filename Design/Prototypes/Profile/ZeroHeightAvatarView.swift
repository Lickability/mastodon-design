//
//  ZeroHeightAvatarView.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import SwiftUI

struct ZeroHeightAvatarView: View {
    var image: Image
    
    init(_ image: Image) {
        self.image = image
    }
    
    var body: some View {
        Rectangle()
            .frame(width: 96)
            .foregroundStyle(.clear)
            .overlay(alignment: .bottom) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
    }
}
