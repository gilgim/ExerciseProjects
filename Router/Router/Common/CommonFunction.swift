//
//  CommonFunction.swift
//  Router
//
//  Created by KimWooJin on 2022/12/18.
//

import Foundation
import SwiftUI
class CommonFunction {
    ///    - Korean : Json String을 반환하는 함수. Realm으로 저장할 때 쓰인다.
    ///    - English :
    static func makeJsonString<T: Encodable>(jsonType: T) -> String? {
        CommonFunction.printTitle(title: "Encoding \(jsonType.self)")
        
        let data = try? JSONEncoder().encode(jsonType.self)
        guard let data else {print("Data를 올바르게 인코딩 할 수 없습니다.");return nil}
        
        let result = String(data: data, encoding: .utf8)
        print("인코딩을 완료하였습니다. ")
        return result
    }
    ///    - Korean : Realm에 저장되어 있는 Data를 디코딩 하기 위한 함수.
    ///    - English :
    static func decodingJson<T: Decodable>(jsonString: String, type: T) -> T? {
        CommonFunction.printTitle(title: "Decoding \(type.self)")
        let data = Data(jsonString.utf8)
        let jsonObject = try? JSONDecoder().decode(T.self, from: data)
        
        guard let jsonObject else {print("String을 올바르게 디코딩 할 수 없습니다.");return nil}
        print("디코딩을 완료하였습니다.")
        
        return jsonObject
    }
    ///    - Korean : 가독성이 좋게 타이틀을 포함하는 커스텀 프린트
    ///    - English :
    static func printTitle(title: String) {
        print("\n========== < \(title) > ==========")
    }
    ///    - Korean : 옵셔널 바인딩 값을 바인딩으로 치환해주는 함수
    ///    - English :
    static func bindingOptionalRemove<T>(_ value: Binding<Optional<T>>) -> Binding<T>? {
        guard let value = value.wrappedValue else {return nil}
        return Binding.constant(value)
    }
}
