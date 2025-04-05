//
//  HomeView.swift
//  subtraction-life
//
//  Created by xing yin on 4/1/25.
//

import SwiftUI

struct HomeView: View {
    // 待减项目列表
    let todoItems: [TodoItem] = [
        TodoItem(id: 1, title: "整理书架，捐出不再阅读的书籍", isCompleted: true, category: "物质"),
        TodoItem(id: 2, title: "整理电子邮件，取消不必要的订阅", isCompleted: true, category: "数字"),
        TodoItem(id: 3, title: "减少社交媒体使用时间", isCompleted: true, category: "时间"),
        TodoItem(id: 4, title: "清理手机应用，移除不常用软件", isCompleted: false, category: "数字")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 进度环
                ProgressRingView(progress: 0.75)
                    .frame(width: 200, height: 200)
                    .padding(.top, 40)
                
                // 今日格言卡片
                QuoteCardView(quote: "万物皆有时，减法亦有度。", source: "《减法人生》")
                    .padding(.horizontal)
                
                // 待减项目卡片
                TodoListCardView(items: todoItems)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
            }
        }
        .background(Color.white)
    }
}

// 进度环视图
struct ProgressRingView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            // 背景圆环
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 15)
            
            // 进度圆环
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(Color.black, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            // 中间文字
            Text("\(Int(progress * 100))%")
                .font(.system(size: 40, weight: .medium))
                .foregroundColor(.black)
        }
    }
}

// 格言卡片视图
struct QuoteCardView: View {
    var quote: String
    var source: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("今日格言")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
            
            Text("\"\(quote)\"")
                .font(.system(size: 18, weight: .regular))
                .italic()
                .foregroundColor(.black.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 5)
            
            Text("——  \(source)")
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

#Preview {
    HomeView()
} 