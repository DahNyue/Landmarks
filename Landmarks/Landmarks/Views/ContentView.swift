//
//  ContentView.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(_ hex: Int, alpha: CGFloat = 1.0) {
        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF
        
        self.init(uiColor: UIColor(red: CGFloat(red) / 0xFF, green: CGFloat(green) / 0xFF, blue: CGFloat(blue) / 0xFF, alpha: alpha))
    }
}
