//
//  TestView.swift
//  Cornerstone
//
//  Created by Simon Raboczi on 22/3/20.
//  Copyright © 2020 Simon Raboczi. All rights reserved.
//

import Combine
import SwiftUI

struct TestView: View {
    
    @Binding var value: String
    let networking = Networking()
    
    var body: some View {
        VStack {
            Text(value).padding()
            HStack {
                Button("Three") { self.networking.setTestValue(to: "Three") }
                    .padding()
                Button("Four") { self.networking.setTestValue(to: "Four") }
                    .padding()
            }
        }
    }
}
