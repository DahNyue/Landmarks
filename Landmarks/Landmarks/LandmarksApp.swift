//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import SwiftUI

@main
struct LandmarksApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
