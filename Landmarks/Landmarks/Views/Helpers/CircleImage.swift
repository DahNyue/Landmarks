//
//  CircleImage.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import SwiftUI
import UIKit

struct CircleImage: View {
    
    var preferredViewType : Profile.ViewType = .slideGlass
    /// 0 ~ 4 ea
    var imageNames : [String] = ["son-guk-si_1", "hong-ro_2"]
    
    @State var currentPage: Int = 0
    
    var body: some View {
        let space : CGFloat = 3
        switch preferredViewType {
        case .stainedGlass:
            if imageNames.count == 4 {
                VStack(spacing: space) {
                    HStack(spacing: space) {
                        Image(self.imageNames[0]).resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(self.imageNames[1]).resizable()
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
        case .slideGlass:
            ZStack {
                PageView(pages: imageNames.map {
                    Image($0).resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .clipShape(Rectangle())
                }) { currentPage in
                    self.currentPage = currentPage
                }
                .listRowInsets(EdgeInsets())
                .frame(width: 250, height: 250)
                .aspectRatio(contentMode: .fit)
                .background(.white)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
                
                if imageNames.count > 1 {
                    PageControl(numberOfPages: imageNames.count, currentPage: $currentPage, isAccent: true)
                        .frame(width: CGFloat(imageNames.count * 18))
                        .padding(.bottom, 275)
                }
            }
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
