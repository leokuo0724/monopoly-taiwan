//
//  BuildingInfoData.swift
//  monopoly-taiwan
//
//  Created by 郭家銘 on 2020/11/29.
//

import Foundation

struct BuildingInfoData: Decodable {
    let index: Int
    let name: String
    let levelCostInfo: Array<Int>
    let roadTollInfo: Array<Int>
    let questions: Array<question>
}
