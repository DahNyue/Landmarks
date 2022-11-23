//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//
//  가장 상위의 메인이 되는 구조체, App을 상속, body도 Scene을 상속한다.

import SwiftUI

@main
struct LandmarksApp: App {
    
    @StateObject private var modelData = ModelData()
    
    /// Scene: 시스템에서 관리하는 수명 주기가 있는 앱 사용자 인터페이스의 일부
    var body: some Scene {
        /// WindowGroup: Scene 상속 시 필요한 'View'의 시작
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
