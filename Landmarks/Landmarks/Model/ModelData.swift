//
//  ModelData.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import Foundation

var landmarks: [Landmark] = load("landmarkData.json")

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