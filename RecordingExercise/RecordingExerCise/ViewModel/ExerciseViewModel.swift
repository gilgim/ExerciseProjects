//
//  ExerciseViewModel.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/14.
//
//   운동 항목에 관한 데이터를 들고 있고 그 데이터를 뷰의 이벤트에 따라 가공하여 제공함.

import Foundation
import RealmSwift

/**
 운동명, 운동 설명, 링크, 운동부위, 운동 세부부위, 기구에 대한 데이터를 가지고 있고, 변환하는 함수를 가진 구조체
 */
struct ExerciseViewModel{
    let realm = try! Realm()
}
