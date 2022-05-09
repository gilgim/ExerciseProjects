//
//  Color.swift
//  SWprojecte
//
//  Created by KimWooJin on 2022/02/07.
//

import Foundation
import SwiftUI
import UIKit

extension Color {
	init(hex : String){
		let scanner = Scanner(string: hex)
		_ = scanner.scanString("#")
		var rgb : UInt64 = 0
		scanner.scanHexInt64(&rgb)
		let r = Double((rgb >> 16) & 0xFF) / 255
		let g = Double((rgb >> 8) & 0xFF) / 255
		let b = Double((rgb >> 0) & 0xFF) / 255
		self.init(red: r, green: g, blue: b)
	}
	
	//기본 색상
	static let Color_01 = Color(hex: "FFFFFF") //화이트
	static let Color_02 = Color(hex: "000000") //검정
	static let Color_03 = Color(hex: "939496") //비활성화
	static let Color_04 = Color(hex: "BEBEBE") //완전 비활성화
	static let Color_05 = Color(hex: "0040DD") //파랑 볼드
	static let Color_06 = Color(hex: "007AFF") //파랑
	static let Color_07 = Color(hex: "D70015") //빨강 볼드
	static let Color_08 = Color(hex: "FF3B30") //빨강
	
	//배경 색상
	static let Color_09 = Color(hex: "E5E3EF").opacity(0.6) //상하단
	static let Color_10 = Color(hex: "EEEEFC") //토글
	static let Color_11 = Color(hex: "EAEAEB") //선택전
	static let Color_12 = Color(hex: "FAF9FF") //선택된
	static let Color_13 = Color(hex: "F2F1F6") //바탕
	static let Color_14 = Color(hex: "FBFBFF") //달력
	static let Color_15 = Color(hex: "767680").opacity(0.12) //검색창
	static let Color_16 = Color(hex: "F5F5F5").opacity(0.7) //액션시트
	static let Color_17 = Color(hex: "FAFAFA").opacity(0.9) //상황별메뉴
	static let Color_18 = Color(hex: "F4F4F5") //시간설정 선택
	
	//버튼 색상
	static let Color_19 = Color(hex: "A4A4D7") //메인
	static let Color_20 = Color(hex: "CDD1F0") //플로팅 루틴추가
	static let Color_21 = Color(hex: "C1C6EF") //플로팅 운동추가
	static let Color_22 = Color(hex: "A2AFDC") //쉬는시간 타이머
	static let Color_23 = Color(hex: "AEAEB2").opacity(0.66) //제거
	static let Color_24 = Color(hex: "C0C0C0").opacity(0.5) //비활성화
	static let Color_25 = Color(hex: "000000").opacity(0.3) //상하단 경계선
	static let Color_26 = Color(hex: "000000").opacity(0.7) //검색창 아이콘
	
	//폰트 색상
	static let Color_27 = Color(hex: "8484C2") //메인글씨
	static let Color_28 = Color(hex: "333232") //메뉴
	static let Color_29 = Color(hex: "5C5C68").opacity(0.9) //버튼 변환전
	static let Color_30 = Color(hex: "3C3C43").opacity(0.8) //달력 요일
	static let Color_31 = Color(hex: "3C3C43").opacity(0.6) //검색창 폰트
	static let Color_32 = Color(hex: "E11223").opacity(0.85) //쉬는시간 N초전
	
	//슬라이드 색상
	static let Color_33 = Color(hex: "65BE88").opacity(0.85) //편집
	static let Color_34 = Color(hex: "A2A2DC").opacity(0.85) //메모
	static let Color_35 = Color(hex: "D65D66").opacity(0.85) //제거
}

extension UIColor {
	convenience init(hex : String){
		let scanner = Scanner(string: hex)
		_ = scanner.scanString("#")
		var rgb : UInt64 = 0
		scanner.scanHexInt64(&rgb)
		let r = Double((rgb >> 16) & 0xFF) / 255
		let g = Double((rgb >> 8) & 0xFF) / 255
		let b = Double((rgb >> 0) & 0xFF) / 255
		self.init(red: r, green: g, blue: b, alpha: 1)
	}
	
	//기본 색상
	static let Color_01 = UIColor(hex: "FFFFFF") //화이트
	static let Color_02 = UIColor(hex: "000000") //검정
	static let Color_03 = UIColor(hex: "939496") //비활성화
	static let Color_04 = UIColor(hex: "BEBEBE") //완전 비활성화
	static let Color_05 = UIColor(hex: "0040DD") //파랑 볼드
	static let Color_06 = UIColor(hex: "007AFF") //파랑
	static let Color_07 = UIColor(hex: "D70015") //빨강 볼드
	static let Color_08 = UIColor(hex: "FF3B30") //빨강
	
	//배경 색상
	static let Color_09 = UIColor(hex: "E5E3EF").withAlphaComponent(0.6) //상하단
	static let Color_10 = UIColor(hex: "EEEEFC") //토글
	static let Color_11 = UIColor(hex: "EAEAEB") //선택전
	static let Color_12 = UIColor(hex: "FAF9FF") //선택된
	static let Color_13 = UIColor(hex: "F2F1F6") //바탕
	static let Color_14 = UIColor(hex: "FBFBFF") //달력
	static let Color_15 = UIColor(hex: "767680").withAlphaComponent(0.12) //검색창
	static let Color_16 = UIColor(hex: "F5F5F5").withAlphaComponent(0.7) //액션시트
	static let Color_17 = UIColor(hex: "FAFAFA").withAlphaComponent(0.9) //상황별메뉴
	static let Color_18 = UIColor(hex: "F4F4F5") //시간설정 선택
	
	//버튼 색상
	static let Color_19 = UIColor(hex: "A4A4D7") //메인
	static let Color_20 = UIColor(hex: "CDD1F0") //플로팅 루틴추가
	static let Color_21 = UIColor(hex: "C1C6EF") //플로팅 운동추가
	static let Color_22 = UIColor(hex: "A2AFDC") //쉬는시간 타이머
	static let Color_23 = UIColor(hex: "AEAEB2").withAlphaComponent(0.66) //제거
	static let Color_24 = UIColor(hex: "C0C0C0").withAlphaComponent(0.5) //비활성화
	static let Color_25 = UIColor(hex: "000000").withAlphaComponent(0.3) //상하단 경계선
	static let Color_26 = UIColor(hex: "000000").withAlphaComponent(0.7) //검색창 아이콘
	
	//폰트 색상
	static let Color_27 = UIColor(hex: "8484C2") //메인글씨
	static let Color_28 = UIColor(hex: "333232") //메뉴
	static let Color_29 = UIColor(hex: "5C5C68").withAlphaComponent(0.9) //버튼 변환전
	static let Color_30 = UIColor(hex: "3C3C43").withAlphaComponent(0.8) //달력 요일
	static let Color_31 = UIColor(hex: "3C3C43").withAlphaComponent(0.6) //검색창 폰트
	static let Color_32 = UIColor(hex: "E11223").withAlphaComponent(0.85) //쉬는시간 N초전
	
	//슬라이드 색상
	static let Color_33 = UIColor(hex: "65BE88").withAlphaComponent(0.85) //편집
	static let Color_34 = UIColor(hex: "A2A2DC").withAlphaComponent(0.85) //메모
	static let Color_35 = UIColor(hex: "D65D66").withAlphaComponent(0.85) //제거
}
