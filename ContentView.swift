//
//  ContentView.swift
//  subtraction-life
//
//  Created by xing yin on 4/1/25.
//

import SwiftUI

struct ContentView: View {
    // 标记当前选中的标签页
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首页")
                }
                .tag(0)
            
            Text("减法清单")
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("减法清单")
                }
                .tag(1)
            
            Text("习惯培养")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("习惯培养")
                }
                .tag(2)
            
            Text("心灵空间")
                .tabItem {
                    Image(systemName: "brain")
                    Text("心灵空间")
                }
                .tag(3)
        }
        .accentColor(.black)
    }
}

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
    
    var body: some View {
        HStack(spacing: 15) {
            // 完成状态图标
            ZStack {
                Circle()
                    .fill(item.isCompleted ? Color.green : Color.white)
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

// 待减项目模型
struct TodoItem: Identifiable {
    var id: Int
    var title: String
    var isCompleted: Bool
    var category: String
}

#Preview {
    ContentView()
}
