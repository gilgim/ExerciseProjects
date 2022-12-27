//
//  CommonFunction.swift
//  Router
//
//  Created by KimWooJin on 2022/12/18.
//

import Foundation
import SwiftUI
/// Exercise, Routine, Graph 등 공통적으로 쓰이는 함수를 정리해둔 클래스 입니다.
class CommonFunction {
    /**
     Json String을 반환하는 함수이자 Realm에 저장되는 String을 위한 함수입니다.
     
     -  parameters:
        -   jsonType: json string으로 전환할 값 입니다.
        -   T: Encodable 을 할당하는 타입으로 보통 운동, 세부 부위, 루틴 타입이 사용됩니다.
     */
    static func makeJsonString<T: Encodable>(jsonType: T) -> String? {
        CommonFunction.printTitle(title: "Encoding \(jsonType.self)")
        let data = try? JSONEncoder().encode(jsonType.self)
        guard let data else {print("Data를 올바르게 인코딩 할 수 없습니다.");return nil}
        let result = String(data: data, encoding: .utf8)
        print("인코딩을 완료하였습니다. ")
        return result
    }
    /// Realm에 저장되어 있는 Data를 디코딩 하기 위한 함수입니다..
    static func decodingJson<T: Decodable>(jsonString: String, type: T) -> T? {
        CommonFunction.printTitle(title: "Decoding \(type.self)")
        let data = Data(jsonString.utf8)
        let jsonObject = try? JSONDecoder().decode(T.self, from: data)
        guard let jsonObject else {print("String을 올바르게 디코딩 할 수 없습니다.");return nil}
        print("디코딩을 완료하였습니다.")
        
        return jsonObject
    }
    /// 사용자 이벤트를 쉽게 확인하기 위한 print 함수 입니다.
    static func printTitle(title: String) {
        print("\n========== < \(title) > ==========")
    }
}
