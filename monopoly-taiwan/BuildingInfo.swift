//
//  BuildingInfo.swift
//  monopoly-taiwan
//
//  Created by 郭家銘 on 2020/11/29.
//

import Foundation

class BuildingInfo {
    let index: Int
    let name: String
    let levelCostInfo: Array<Int>
    let roadTollInfo: Array<Int>
    var owner: String
    var level: Int
    let questions: Array<question>
    
    init(index: Int,
         name: String,
         levelCostInfo: Array<Int>,
         roadTollInfo: Array<Int>,
         owner: String,
         level: Int,
         questions: Array<question>) {
        self.index = index
        self.name = name
        self.levelCostInfo = levelCostInfo
        self.roadTollInfo = roadTollInfo
        self.owner = owner
        self.level = level
        self.questions = questions
    }
}

struct question: Decodable {
    let title: String
    let options: Array<String>
    let answer: String
}
