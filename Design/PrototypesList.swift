//
//  ContentView.swift
//  Design
//
//  Created by mb on 3/27/24.
//

import SwiftUI


struct PrototypesList: View {
    @State var fullScreenPrototype: Prototype?
    @State var sheetPrototype: Prototype?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Prototype.allCases) { prototype in
                    switch prototype.displayStyle {
                    case .navigationLink:
                        NavigationLink(prototype.description) {
                            prototype.view
                        }
                    case .fullScreenCover:
                        Button(action: {
                            fullScreenPrototype = prototype
                        }, label: {
                            Text(prototype.description)
                        })

                    case .sheet:
                        Button(action: {
                            sheetPrototype = prototype
                        }, label: {
                            Text(prototype.description)
                        })
                    }
                }
            }
            .navigationTitle("Prototypes")
            .navigationBarTitleDisplayMode(.inline)
        }
        .fullScreenCover(item: $fullScreenPrototype, content: { prototype in
            prototype.view
        })
        .sheet(item: $sheetPrototype, content: { prototype in
            prototype.view
        })
    }
}

#Preview {
    PrototypesList()
}
