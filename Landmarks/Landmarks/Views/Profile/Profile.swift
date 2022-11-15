//
//  Profile.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/04.
//

import SwiftUI

struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()
    
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