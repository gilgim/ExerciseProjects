//
//  Error.swift
//  Router
//
//  Created by KimWooJin on 2022/12/26.
//

import Foundation

/// Throw 처리를 위한 Error 입니다.
enum ErrorType: Error {
    /// 기댓값이 정확한 초기화 시 기댓값과 맞지 않을 때 발생하는 초기화 에러입니다. 
    case InitailizeError(String)
    
    /// Realm 데이터가 nil 일 때 발생하는 에러입니다.
    case RealmDataLookUpError
    
    /// Struct Value를 Json String으로 올바르게 변환하지 못할 때 발생하는 에러입니다.
    case StructValueConvertError
    
    /// Json Value를 Json String으로 올바르게 변환하지 못할 때 발생하는 에러입니다.
    case JsonValueConvertError(String)
    
    /// Realm 객체를 Struct로 올바르게 변환하지 못할 때 발생하는 에러입니다.
    case RealmValueConvertError
    
    /// Realm에서 데이터를 불러왔을 때의 갱신 에러입니다.
    case RealmReadError
	
	///	Enum 값을 찾을 수 없을 때의 에러 입니다.
	case NotFindEnumError(String)
}
