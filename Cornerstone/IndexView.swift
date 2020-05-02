//
//  ContentView.swift
//  Cornerstone
//
//  Created by Simon Raboczi on 18/3/20.
//  Copyright © 2020 Simon Raboczi. All rights reserved.
//

import SwiftUI

let OSGiEventPublisher =
    NotificationCenter.default.publisher(for: TestServiceNotificationName)
        .map { $0.object as? String ?? "Error" }
        .receive(on: RunLoop.main)

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
