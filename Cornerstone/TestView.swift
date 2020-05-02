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

     var body: some View {
        VStack {
            Text(value).padding()
            HStack {
                Button("Three") { setTestValue(to: "Three") }
                    .padding()
                Button("Four") { setTestValue(to: "Four") }
                    .padding()
            }
        }
    }
}
