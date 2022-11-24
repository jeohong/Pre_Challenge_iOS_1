//
//  Score.swift
//  MyCreditManager
//
//  Created by Hong jeongmin on 2022/11/24.
//

import Foundation

enum Grade: String {
    case Aplus = "A+"
    case A = "A"
    case Bplus = "B+"
    case B
    case Cplus = "C+"
    case C
    case Dplus = "D+"
    case D
    case F
    
    var score: Double {
        switch self {
        case .Aplus:
            return 4.5
        case .A:
            return 4
        case .Bplus:
            return 3.5
        case .B:
            return 3
        case .Cplus:
            return 2.5
        case .C:
            return 2
        case .Dplus:
            return 1.5
        case .D:
            return 1
        case .F:
            return 0
        }
    }
}
