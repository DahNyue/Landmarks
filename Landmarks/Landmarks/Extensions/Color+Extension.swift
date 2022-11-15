//
//  Color+Extension.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/03.
//

import Foundation
import SwiftUI

extension Color {
    init(_ hex: Int, alpha: CGFloat = 1.0) {
        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF
        
        self.init(uiColor: UIColor(red: CGFloat(red) / 0xFF, green: CGFloat(green) / 0xFF, blue: CGFloat(blue) / 0xFF, alpha: alpha))
    }
    
    //string input을 이용해서 직접적으로 변환을 시켜주는 코드.
    init?(_ hex: String, _ alpha: CGFloat = 1.0) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy:1)
            let hexColor = String (hex[start...])
            if hexColor.count == 6 {
                let scanner = Scanner (string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64 (&hexNumber) {
                    r = CGFloat ( (hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat ( (hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat ( (hexNumber & 0x0000ff)) / 255
                    a = alpha
                    self.init(uiColor: UIColor(red: r, green: g, blue: b, alpha: a))
                    return
                }
            }
        }
        return nil
    }
    
    func complementaryColor() -> Color {
        
        let uiColor = UIColor(self)
        let ciColor = CIColor(color: uiColor)
        
        let compR: CGFloat = 1.0 - ciColor.red
        let compG: CGFloat = 1.0 - ciColor.green
        let compB: CGFloat = 1.0 - ciColor.blue
        
        let color = Color(CGColor(red: compR, green: compG, blue: compB, alpha: ciColor.alpha))
        
        return color
    }
}
