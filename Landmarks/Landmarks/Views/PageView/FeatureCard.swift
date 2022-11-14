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
        GeometryReader { superView in
            landmark.featureImage?
                .resizable()
                .scaledToFill()
                .frame(width: superView.size.width, height: superView.size.width * 2 / 3)
                .clipped()
                // .frame(width: superView.size.width, height: superView.size.height)
                .overlay {
                    TextOverlay(landmark: landmark)
                }
        }
    }
}

struct TextOverlay: View {
    var landmark: Landmark

    var gradient: LinearGradient {
        .linearGradient( // 최대 테두리에 맞춰 커짐
//            Gradient(colors: [Color(landmark.primeColorHexStr).opacity(0.6), Color(landmark.primeColorHexStr).opacity(0)]),
            Gradient(colors: [Color.black.opacity(0.6), Color(landmark.primeColorHexStr).opacity(0)]),
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
                Text(landmark.state)
            }
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
