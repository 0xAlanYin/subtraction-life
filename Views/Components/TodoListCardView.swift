//
//  TodoListCardView.swift
//  subtraction-life
//
//  Created by xing yin on 4/1/25.
//

import SwiftUI

// 待减项目卡片视图
struct TodoListCardView: View {
    var items: [TodoItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("今日待减项目")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("\(items.filter { $0.isCompleted }.count)/\(items.count) 已完成")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Divider()
                .padding(.vertical, 5)
            
            ForEach(items) { item in
                TodoItemRow(item: item)
                if item.id != items.last?.id {
                    Divider()
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

// 单个待减项目行
struct TodoItemRow: View {
    var item: TodoItem
    private let greenColor = Color(red: 0, green: 0.8, blue: 0.5) // 更准确的绿色
    
    var body: some View {
        HStack(spacing: 15) {
            // 完成状态图标
            ZStack {
                Circle()
                    .fill(item.isCompleted ? greenColor : Color.white)
                    .frame(width: 24, height: 24)
                
                if item.isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    Circle()
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        .frame(width: 24, height: 24)
                }
            }
            
            // 项目标题
            Text(item.title)
                .font(.system(size: 16))
                .foregroundColor(.black)
            
            Spacer()
            
            // 分类标签
            Text(item.category)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
    }
}

struct TodoListCardView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListCardView(items: [
            TodoItem(id: 1, title: "整理书架，捐出不再阅读的书籍", isCompleted: true, category: "物质"),
            TodoItem(id: 2, title: "整理电子邮件，取消不必要的订阅", isCompleted: true, category: "数字"),
            TodoItem(id: 3, title: "减少社交媒体使用时间", isCompleted: true, category: "时间"),
            TodoItem(id: 4, title: "清理手机应用，移除不常用软件", isCompleted: false, category: "数字")
        ])
        .previewLayout(.sizeThatFits)
        .padding()
    }
} 