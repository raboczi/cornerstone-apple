//
//  ContentView.swift
//  Cornerstone
//
//  Created by Simon Raboczi on 18/3/20.
//  Copyright © 2020 Simon Raboczi. All rights reserved.
//

import CornerstoneClient
import SwiftUI

struct IndexView: View {
    
    @State private var testValue = "Gloop"
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            UserView()
            TestView(value: $testValue)
        }.onReceive(OSGiEventPublisher) { self.testValue = $0 }
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IndexView()
            IndexView()
                .environment(\.colorScheme, .dark)
            IndexView()
                .environment(\.locale, Locale(identifier: "it"))
        }
    }
}
