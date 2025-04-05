//
//  TodoItem.swift
//  subtraction-life
//
//  Created by xing yin on 4/1/25.
//

import Foundation

// 待减项目模型
struct TodoItem: Identifiable {
    var id: Int
    var title: String
    var isCompleted: Bool
    var category: String
} 