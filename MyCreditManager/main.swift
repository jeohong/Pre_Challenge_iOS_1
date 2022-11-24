//
//  main.swift
//  MyCreditManager
//
//  Created by Hong jeongmin on 2022/11/19.
//

import Foundation

var student: [Student] = []

while true {
    print("원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    let input = readLine()
    guard let input = input else { break }
    
    if input == "X" { print("프로그램을 종료합니다..."); break }
    
    switch input {
    case "1":
        addStudent()
        
    case "2":
        deleteStudent()
        
    case "3":
        addScore()
        
    case "4":
        deleteScore()
        
    case "5":
        viewRatings()
        
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}

// MARK: 학생 추가 로직
private func addStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    let inputStudent = readLine()
    guard let inputStudent = inputStudent else { return }
    
    if inputStudent == "" { print("입력이 잘못되었습니다. 다시 확인해주세요."); return }
    
    if student.contains(where: { $0.name.lowercased() == inputStudent.lowercased() }) {
        print("\(inputStudent)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        return
    }
    
    student.append(Student(name: inputStudent, subjectScore: [:]))
    print("\(inputStudent) 학생을 추가했습니다.")
    return
}

// MARK: 학생 삭제 로직
private func deleteStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    let inputStudent = readLine()
    guard let inputStudent = inputStudent else { return }
    
    if inputStudent == "" { print("입력이 잘못되었습니다. 다시 확인해주세요."); return }
    
    guard let studentIndex = student.firstIndex(where: { $0.name.lowercased() == inputStudent.lowercased() }) else {
        print("\(inputStudent) 학생을 찾지 못했습니다.")
        return
    }
    
    student.remove(at: studentIndex)
    print("\(inputStudent) 학생을 삭제하였습니다.")
    return
}

// MARK: 성적추가(변경) 로직
private func addScore() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    let inputSubjectScore = readLine()?.components(separatedBy: " ")
    guard let inputSubjectScore = inputSubjectScore else { return }
        
    // 예외처리 1. 비어있는 입력값, 2. 이름, 과목, 성적 세개의 입력이 들어오지 않음, 3. 성적이 A+ ~ F 사이에 없음
    if inputSubjectScore == [] ||
        inputSubjectScore.count != 3 ||
        Grade(rawValue: inputSubjectScore[2]) == nil {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    // 각 인덱스를 상수에 할당
    let studentName = inputSubjectScore[0]
    let subjectName = inputSubjectScore[1]
    let score = inputSubjectScore[2]
    
    guard let studentIndex = student.firstIndex(where: { $0.name.lowercased() == studentName.lowercased() }) else {
        print("\(studentName) 학생을 찾지 못했습니다.")
        return
    }
    
    if student[studentIndex].subjectScore.keys.contains(where: { $0 == subjectName}) {
        student[studentIndex].subjectScore.updateValue(score, forKey: subjectName)
    } else {
        student[studentIndex].subjectScore[subjectName] = score
    }
    
    print("\(studentName) 학생의 \(subjectName) 과목이 \(score)로 추가(변경)되었습니다.")
    return
}

// MARK: 성적삭제 로직
private func deleteScore() {
    print("성적을 삭제할 학생의 이름. 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    
    let inputSubject = readLine()?.components(separatedBy: " ")
    guard let inputSubject = inputSubject else { return }
    
    // 예외처리 1. 비어있는 입력값, 2. 이름, 과목 2개의 입력이 들어오지 않음
    if inputSubject == [] ||
        inputSubject.count != 2 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    // 각 인덱스를 상수에 할당
    let studentName = inputSubject[0]
    let subjectName = inputSubject[1]
    
    guard let studentIndex = student.firstIndex(where: { $0.name.lowercased() == studentName.lowercased() }) else {
        print("\(studentName) 학생을 찾지 못했습니다.")
        return
    }
    
    if !student[studentIndex].subjectScore.keys.contains(where: { $0 == subjectName}) {
        print("\(studentName) 학생은 \(subjectName)과목을 수강하지 않았습니다.")
        return
    } else {
        student[studentIndex].subjectScore.removeValue(forKey: subjectName)
        
        print("\(studentName) 학생의 \(subjectName) 과목의 성적이 삭제되었습니다.")
        return
    }
}

// MARK: 평점보기 로직
private func viewRatings() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    
    let inputName = readLine()
    guard let inputName = inputName else { return }
    
    // 예외처리 1. 비어있는 입력값, 2. 이름, 과목 2개의 입력이 들어오지 않음
    if inputName == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    guard let studentIndex = student.firstIndex(where: { $0.name.lowercased() == inputName.lowercased() }) else {
        print("\(inputName) 학생을 찾지 못했습니다.")
        return
    }
    
    var sumScore: Double = 0.0
    let subjectCount = student[studentIndex].subjectScore.count
    
    for (subject, score) in student[studentIndex].subjectScore {
        print("\(subject): \(score)")
        
        guard let grade = Grade(rawValue: score) else { return }
        sumScore += grade.score
    }
    
    if sumScore == 0 { print("평점을 낼 점수가 없습니다."); return }
    
    let averageScore = sumScore / Double(subjectCount)
    print("평점 :", terminator: " ")
    
    // 소수점 아래자리 판단하여 각각 print
    // 정수로 떨어질 경우
    if averageScore - Double(Int(averageScore)) == 0 {
        print(Int(averageScore))
    } else if String(averageScore).count > 4 {
        // 소수점 아래 3자리 이상일 경우
        let numberFomatter = NumberFormatter()
        numberFomatter.roundingMode = .floor
        numberFomatter.maximumSignificantDigits = 3
        
        guard let floorScore = numberFomatter.string(for: averageScore) else { return }
        print(floorScore)
    } else {
        // 소수점 아래 1자리일 경우
        print(averageScore)
    }
    return
}
