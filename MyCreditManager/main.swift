//
//  main.swift
//  MyCreditManager
//
//  Created by Hong jeongmin on 2022/11/19.
//

import Foundation

while true {
    print("원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적상제, 5: 평점보기, X: 종료")
    let input = readLine()
    guard let input = input else { break }
    
    if input == "X" { print("프로그램을 종료합니다..."); break }
    
    switch input {
    case "1":
        print("학생추가 로직")
    case "2":
        print("학생삭제 로직")
    case "3":
        print("성적추가(변경) 로직")
    case "4":
        print("성적삭제 로직")
    case "5":
        print("평점보기 로직")
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    
}
