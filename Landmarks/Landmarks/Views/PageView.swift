//
//  PageView.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/10.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    var returnCurrentPage: ((Int) -> Void)?

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if pages.count > 0 {
                PageViewController(pages: pages, currentPage: $currentPage) { page in
                    returnCurrentPage?(page)
                }
                
                PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                    .frame(width: CGFloat(pages.count * 18))
                    .padding(.trailing)
            }
        }
    }
}


struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
            .aspectRatio(contentMode: .fit)
    }
}
