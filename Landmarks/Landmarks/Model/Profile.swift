//
//  Profile.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/04.
//

import SwiftUI

/// Profile 모델
struct Profile {
    var username: String
    /// 노티를 받을건지 여부, 워치 브랜치에서 사용하나, 테스트하지 못함
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()
    
    /// LandmarkDetail의 썸네일 화면을 표시할 방식
    var preferredViewType = ViewType.slideGlass
    
    static let `default` = Profile(username: "DahNyue")

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
    
    enum ViewType: String, CaseIterable, Identifiable {
        case stainedGlass = "🧩"
        case slideGlass = "📃"
        
        var id: String { rawValue }
    }
}
