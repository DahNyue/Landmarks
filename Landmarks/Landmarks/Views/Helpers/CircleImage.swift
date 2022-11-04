//
//  CircleImage.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import SwiftUI
import UIKit

struct CircleImage: View {
    
    /// 0 ~ 4 ea
    var imageNames : [String] = []
    
    var body: some View {
        let space : CGFloat = 3
        if imageNames.count == 4 {
            VStack(spacing: space) {
                HStack(spacing: space) {
                    Image(imageNames[0]).resizable()
                        .aspectRatio(contentMode: .fit)
                    Image(imageNames[1]).resizable()
                        .aspectRatio(contentMode: .fit)
                }
                HStack(spacing: space) {
                    Image(imageNames[2]).resizable()
                        .aspectRatio(contentMode: .fit)
                    Image(imageNames[3]).resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .frame(width: 250, height: 250)
            .aspectRatio(contentMode: .fit)
            .background(.white)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
        } else {
            HStack(spacing: space) {
                if imageNames.count == 1 {
                    Image(imageNames.first ?? "").resizable()
                } else {
                    ForEach(imageNames, id: \.self) { imageName in
                        Rectangle()
                            .overlay {
                                Image(imageName).resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipShape(Rectangle())
                    }
                }
            }
            .frame(width: 250, height: 250)
            .aspectRatio(contentMode: .fit)
            .background(.white)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
