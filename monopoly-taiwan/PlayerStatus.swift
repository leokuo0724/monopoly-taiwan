//
//  PlayerStatus.swift
//  monopoly-taiwan
//
//  Created by 郭家銘 on 2020/11/29.
//

import Foundation

class PlayerStatus {
    let name: String
    var currentPosition: Int = 0
    var money: Int = 1000
    var actioned: Bool = false
    var answered: Bool = false
    
    init(name: String) {
        self.name = name
    }
}
