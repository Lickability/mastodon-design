//
//  PickerTest.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import SwiftUI

struct PickerTest: View {
    @State var selected: String = "1"
    var body: some View {
        VStack {
            Menu {
                Picker("heee", selection: $selected) {
                    Text("2")
                        .tag("2")
                    Text("1")
                        .tag("1")
                }
            } label: {
                Text("Hello")
            }
        }
    }
}

#Preview {
    PickerTest()
}
