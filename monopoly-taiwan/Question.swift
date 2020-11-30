//
//  Question.swift
//  monopoly-taiwan
//
//  Created by 郭家銘 on 2020/11/29.
//

import Foundation

struct Question: Decodable {
    let title: String
    let options: Array<String>
    let answer: String
}
