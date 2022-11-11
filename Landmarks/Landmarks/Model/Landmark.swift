//
//  Landmark.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {    
    var id: Int
    var name: String
    var primeColorHexStr: String
    var color :Color? {
        return Color(primeColorHexStr)
    }
    var city: String
    var state: String
    var address: String
    var description: String
    
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case 일반음식점 = "일반음식점"
        case 일반주점 = "일반주점"
    }
    
    private var imageName: String
    /*
    var images: [Image] {
        let imageSplits = imageName.split(separator: ",")
        if imageSplits.count > 1 {
            return imageSplits.map { Image(String($0)) }
        } else {
            return [Image(imageName)]
        }
    }
     */
    var imageNames: [String] {
        imageName.split(separator: ",").map { String($0) }
    }
    
    var featureImage: Image? {
        isFeatured ? Image(imageName.split(separator: ",").map { String($0) }.first ?? "") : nil
    }
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
