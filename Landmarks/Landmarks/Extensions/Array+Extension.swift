//
//  Array+Extension.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/11.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
