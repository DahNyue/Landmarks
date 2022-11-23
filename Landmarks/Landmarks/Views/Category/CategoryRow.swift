//
//  CategoryRow.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/04.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            /// 리스트와 스크롤의 차이점. 리스트는 요소 하나하나에 치중 (요소 접근, 식별 등), 스크롤은 컨텐츠의 스크롤링에 치중 (축, 인디게이터 등)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark in
                        /// 네비게이션 링크
                        NavigationLink {
                            /// 상세
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            /// View 로써, 버튼이나 라벨 등이 들어갈 수 있다.
                            CategoryItem(landmark: landmark)
                        }
                    }
                }
                .padding(.trailing, 15)
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var landmarks = ModelData().landmarks
    
    static var previews: some View {
        CategoryRow(
            categoryName: landmarks.last!.category.rawValue,
            items: Array(landmarks.prefix(4))
        )
    }
}
