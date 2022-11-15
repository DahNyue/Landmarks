//
//  ModelData.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import Foundation
import Combine
import Alamofire

/// ObservableObject, 관측가능한 객체. 객체가 변경되기 전에 내보내는 퍼블리셔가 있는 객체. 즉 Published 변수들을 포함하며, 해당 변수들은 수정 시 객체가 다시 생성됨
final class ModelData: ObservableObject {
    
    /// 서버에서 받아오긴 하는데, 피쳐이미지를 단번에 못 가져와서 일단 기본적으로 JSON으로 꺼내놓음. 수정 필요
    @Published var landmarks: [Landmark] = [] // load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
    
    init() {
        getLandmarks()
    }
    private func selectLandmarkList<T: Decodable>(modelType: T.Type, completion: @escaping (Result<T?,CommonAPIError>) -> Void) -> DataRequest? {
        let url = URL(string: "http://115.68.184.90:8080/swiftUi/landmark/selectLandmarkList")!
        return APIService.shared.requestApi(requestURL:url, requestType: .post, completion: completion)
    }
    
    func getLandmarks() {
        /// modelData를 불러오기 전에 서버를 태우기 위해 여기서 넣어줬음.
        /// 수신에 텀이 있어서 객체가 변경되며 뷰가 다시 그려지는 모션이 보이긴 함
        _ = selectLandmarkList(modelType: [Landmark].self) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let landmarks):
                self.landmarks = landmarks ?? []
                print("i. self.landmarks init.")
            case .failure(let error):
                print("e. \(error.localizedDescription)")
                self.landmarks = []
            }
        }
    }
    
    private func updateFavoriteToggle<T: Decodable>(id: Int, isOn: Bool, modelType: T.Type, completion: @escaping (Result<T?,CommonAPIError>) -> Void) -> DataRequest? {
        let url = URL(string: "http://115.68.184.90:8080/swiftUi/landmark/updateFavoriteToggle")!
        let parameters: Parameters = [
            "id" : id,
            "isFavorite" : isOn
        ]
        return APIService.shared.requestApi(requestURL: url, requestType: .post, parameter: parameters, completion: completion)
    }
    
    func updateFavorite(id: Int, isOn: Bool) {
        _ = updateFavoriteToggle(id: id, isOn: isOn, modelType: EmptyModel.self, completion: { [weak self] result in
            guard let _ = self else { return }
            switch result {
            case .success(_):
                print("i. isFavorite update.")
            case .failure(let error):
                print("e. \(error.localizedDescription)")
            }
        })
    }
}

/// JSON 파일을 로드
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("다음 파일을 찾을 수 없음 \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("다음 파일을 로드할 수 없음 \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("다음 파일을 파싱할 수 없음 \(filename) as \(T.self):\n\(error)")
    }
}
