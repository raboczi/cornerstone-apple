//
//  HostingController.swift
//  Cornerstone for Watch WatchKit Extension
//
//  Created by Simon Raboczi on 17/5/20.
//  Copyright © 2020 Simon Raboczi. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI
import CornerstoneClient

class HostingController: WKHostingController<IndexView> {
    override var body: IndexView {
        return IndexView()
    }
}
