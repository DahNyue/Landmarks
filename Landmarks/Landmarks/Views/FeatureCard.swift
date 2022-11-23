//
//  FeatureCard.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/10.
//

import SwiftUI

struct FeatureCard: View {
    var landmark: Landmark

    var body: some View {
        /// 콘텐츠를 자체 크기 및 좌표 공간의 함수로 정의하는 컨테이너 뷰, UIKit의 frame/size 등 처럼 사용 가능
        /// proxy: Reader가 생성된 View의 대리자
        /// 필요할 떄 속성처럼 생성해도 되고, 전역적으로 사용하려면 지금처럼 뷰 바깥에 생성
        GeometryReader { superView in
            NavigationLink {
                LandmarkDetail(landmark: landmark)
            } label: {
                landmark.featureImage?
                /// Image를 공간에 맞게 조절되도록 설정, ConstraintLayout 느낌
                    .resizable()
                    .scaledToFill()
                    .frame(width: superView.size.width, height: superView.size.width * 2 / 3)
                /// 찍어내서 뒤를 버림, clipToBounds
                    .clipped()
                    // .frame(width: superView.size.width, height: superView.size.height)
                /// 위에 레이어를 씌움
                    .overlay {
                        TextOverlay(landmark: landmark)
                    }
            }
        }
    }
}

struct TextOverlay: View {
    var landmark: Landmark

    var gradient: LinearGradient {
        /// TextOverlay의 배경을 담당하는 LinearGradient (Layer 느낌)
        .linearGradient( /// 최대 테두리에 맞춰 커짐
//            Gradient(colors: [Color(landmark.primeColorHexStr).opacity(0.6), Color(landmark.primeColorHexStr).opacity(0)]),
            Gradient(colors: [Color.black.opacity(0.6), (Color(landmark.primeColorHexStr) ?? Color.black).opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                    .bold()
                    .shadow(color: Color(landmark.primeColorHexStr) ?? .black, radius: 6, x: 0, y: 3)
                Text(landmark.state)
                    .shadow(color: Color(landmark.primeColorHexStr) ?? .black, radius: 3, x: 0, y: 1.5)
            }
            .shadow(color: .black.opacity(0.6), radius: 6, x: 0, y: 3)
            .padding()
        }
        .foregroundColor(Color(landmark.primeColorHexStr))
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(landmark: ModelData().features[0])
    }
}
