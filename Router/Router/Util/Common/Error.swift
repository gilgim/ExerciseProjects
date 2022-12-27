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
}
