//
//  Landmark.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import Foundation
import SwiftUI
import CoreLocation

/// Landmark 모델
struct Landmark: Hashable, Codable, Identifiable {    
    var id: Int
    var name: String
    
    /// 이미지에서 임의로 스포이팅한 컬러, Landmark 모델의 주 색으로 정의해 제목 등에 사용함
    var primeColorHexStr: String // #123456
    
    /// primeColorHexStr를 Color로 리턴
    var color :Color? { // #123456 to Color
        return Color(primeColorHexStr)
    }
    
    /// 서울
    var city: String
    /// 강남구
    var state: String
    /// 학동로2길 29 B1F
    var address: String
    var description: String
    
    var isFavorite: Bool
    /// 피쳐스타일 메인에 걸릴 모델 여부
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case 일반음식점 = "일반음식점"
        case 일반주점 = "일반주점"
    }
    
    /// 쉼표(,)로 구분된 이미지들, 파일서버 사용하지 않고 아직은 Assets에 저장해둠
    private var imageName: String
    /*
     /// imageName을 스플릿해 [Image]로 만들어 리턴하는 변수였는데, 뷰로 만드는 과정이 어려워 [String]로 만들어 리턴하게 됨
    var images: [Image] {
        let imageSplits = imageName.split(separator: ",")
        if imageSplits.count > 1 {
            return imageSplits.map { Image(String($0)) }
        } else {
            return [Image(imageName)]
        }
    }
     */
    /// imageName을 스플릿해 [String]로 만들어 리턴
    var imageNames: [String] {
        imageName.split(separator: ",").map { String($0) }
    }
    
   /// featureImage를 따로 두지 않고 imageName에서 발견된 첫번쨰 이미지를 사용
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
