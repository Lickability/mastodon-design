//
//  UsernameLockup.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import SwiftUI
import UniformTypeIdentifiers

struct UsernameLockup: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("sam henri gold")
                .font(.title2)
            HStack(alignment: .firstTextBaseline) {
                Button(action: {
                    UIPasteboard.general.setValue("@samhenrigold@hachyderm.io", forPasteboardType: UTType.plainText.identifier)
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }, label: {
                    Text("samhenrigold")
                        .font(.subheadline)
                })
                Button(action: {}, label: {
                    Text("example.social")
                        .font(.caption2)
                })
                .controlSize(.mini)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .buttonStyle(.bordered)
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    UsernameLockup()
}
