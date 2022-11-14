//
//  WatchLandmarksApp.swift
//  WatchLandmarks Watch App
//
//  Created by 김보겸 on 2022/11/11.
//

import SwiftUI

@main
struct WatchLandmarks_Watch_AppApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
