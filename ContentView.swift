//
//  ContentView.swift
//  subtraction-life
//
//  Created by xing yin on 4/1/25.
//

import SwiftUI

// 减法项目模型
struct SubtractionItem: Identifiable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var progress: Double
}

// 习惯项目模型
struct HabitItem: Identifiable {
    var id: Int
    var title: String
    var description: String
    var time: String
    var isCompleted: Bool
}

// 情绪模型
struct EmotionItem: Identifiable {
    var id: Int
    var name: String
    var emoji: String
    var isSelected: Bool
}

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
            
            SubtractionListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("减法清单")
                }
                .tag(1)
            
            HabitView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("习惯培养")
                }
                .tag(2)
            
            MindSpaceView()
                .tabItem {
                    Image(systemName: "brain")
                    Text("心灵空间")
                }
                .tag(3)
        }
        .accentColor(.black)
    }
}

// 减法清单视图
struct SubtractionListView: View {
    // 分类筛选状态
    @State private var selectedCategory: String? = nil
    
    // 添加项目的状态
    @State private var isAddingItem = false
    @State private var newItemTitle = ""
    @State private var newItemDescription = ""
    @State private var newItemCategory = "物质"
    
    // 减法项目列表
    @State private var subtractionItems: [SubtractionItem] = [
        SubtractionItem(
            id: 1,
            title: "衣橱减法计划",
            description: "整理衣物，捐赠或出售不再穿着的物品",
            category: "物质",
            progress: 0.7
        ),
        SubtractionItem(
            id: 2,
            title: "电子邮件整理",
            description: "取消订阅无用邮件，归档重要信息",
            category: "数字",
            progress: 0.45
        ),
        SubtractionItem(
            id: 3,
            title: "减少会议时间",
            description: "优化会议流程，缩短无效会议时间",
            category: "时间",
            progress: 0.3
        ),
        SubtractionItem(
            id: 4,
            title: "厨房物品精简",
            description: "移除重复或不常用的厨具，保留核心物品",
            category: "物质",
            progress: 0.85
        )
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // 顶部标题区域
                ZStack {
                    // 半透明背景图
                    Image("glass_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180)
                        .clipped()
                        .overlay(Color.black.opacity(0.2))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("减法清单")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("通过持续减法，让生活回归本质")
                            .font(.system(size: 16))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // 分类筛选区域
                HStack(spacing: 10) {
                    Text("分类：")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            CategoryButton(title: "物质", selectedCategory: $selectedCategory)
                            CategoryButton(title: "数字", selectedCategory: $selectedCategory)
                            CategoryButton(title: "时间", selectedCategory: $selectedCategory)
                        }
                        .padding(.horizontal, 5)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // 过滤按钮逻辑
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 22))
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                }
                .padding(.vertical, 10)
                .background(Color.white)
                
                // 减法项目列表
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(filteredItems) { item in
                            SubtractionItemCardView(item: item)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                
                Spacer()
                
                // 添加新项目按钮
                VStack {
                    Button(action: {
                        isAddingItem = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 60, height: 60)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .edgesIgnoringSafeArea(.top)
            .background(Color(UIColor.systemGray6))
            
            // 添加新项目的表单
            if isAddingItem {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isAddingItem = false
                    }
                
                VStack(spacing: 20) {
                    Text("添加新减法项目")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 5)
                    
                    // 项目标题输入框
                    VStack(alignment: .leading, spacing: 5) {
                        Text("标题")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        
                        TextField("测试项目", text: $newItemTitle)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    // 项目描述输入框
                    VStack(alignment: .leading, spacing: 5) {
                        Text("描述")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        
                        TextField("", text: $newItemDescription)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    // 类别选择器
                    HStack {
                        Button(action: {
                            newItemCategory = "物质"
                        }) {
                            Text("物质")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(newItemCategory == "物质" ? Color.blue.opacity(0.1) : Color(UIColor.systemGray6))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(newItemCategory == "物质" ? Color.blue : Color.clear, lineWidth: 1)
                                        )
                                )
                                .foregroundColor(newItemCategory == "物质" ? .blue : .black)
                        }
                        
                        Button(action: {
                            newItemCategory = "数字"
                        }) {
                            Text("数字")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(newItemCategory == "数字" ? Color.blue.opacity(0.1) : Color(UIColor.systemGray6))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(newItemCategory == "数字" ? Color.blue : Color.clear, lineWidth: 1)
                                        )
                                )
                                .foregroundColor(newItemCategory == "数字" ? .blue : .black)
                        }
                        
                        Button(action: {
                            newItemCategory = "时间"
                        }) {
                            Text("时间")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(newItemCategory == "时间" ? Color.blue.opacity(0.1) : Color(UIColor.systemGray6))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(newItemCategory == "时间" ? Color.blue : Color.clear, lineWidth: 1)
                                        )
                                )
                                .foregroundColor(newItemCategory == "时间" ? .blue : .black)
                        }
                    }
                    
                    Spacer()
                    
                    // 按钮区域
                    HStack {
                        Button(action: {
                            isAddingItem = false
                        }) {
                            Text("取消")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(8)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            addNewItem()
                        }) {
                            Text("添加")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(Color.black)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }
                        .disabled(newItemTitle.isEmpty)
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
                .frame(maxHeight: 500)
            }
        }
    }
    
    // 根据选中的分类筛选项目
    var filteredItems: [SubtractionItem] {
        if let category = selectedCategory {
            return subtractionItems.filter { $0.category == category }
        } else {
            return subtractionItems
        }
    }
    
    // 添加新项目
    func addNewItem() {
        // 检查输入是否有效
        guard !newItemTitle.isEmpty, !newItemDescription.isEmpty else {
            return
        }
        
        // 创建新项目
        let newItem = SubtractionItem(
            id: (subtractionItems.map { $0.id }.max() ?? 0) + 1,
            title: newItemTitle,
            description: newItemDescription,
            category: newItemCategory,
            progress: 0.0
        )
        
        // 添加到数组中
        subtractionItems.append(newItem)
        
        // 输出调试信息
        print("添加新项目: \(newItem.title), 当前列表数量: \(subtractionItems.count)")
        
        // 重置表单
        newItemTitle = ""
        newItemDescription = ""
        newItemCategory = "物质"
        isAddingItem = false
    }
}

// 分类按钮
struct CategoryButton: View {
    var title: String
    @Binding var selectedCategory: String?
    
    var isSelected: Bool {
        selectedCategory == title
    }
    
    var body: some View {
        Button(action: {
            if isSelected {
                selectedCategory = nil
            } else {
                selectedCategory = title
            }
        }) {
            Text(title)
                .font(.system(size: 15))
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.blue.opacity(0.15) : Color.gray.opacity(0.1))
                )
                .foregroundColor(isSelected ? .blue : .black)
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.blue.opacity(0.5) : Color.clear, lineWidth: 1)
                )
        }
    }
}

// 减法项目卡片视图
struct SubtractionItemCardView: View {
    var item: SubtractionItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(item.title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(item.category)
                    .font(.system(size: 14))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(categoryColor(item.category).opacity(0.1))
                    )
                    .foregroundColor(categoryColor(item.category))
            }
            
            Text(item.description)
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .lineLimit(2)
            
            HStack {
                Text("进度")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("\(Int(item.progress * 100))%")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            // 进度条
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 8)
                    .cornerRadius(4)
                
                GeometryReader { geometry in
                    Rectangle()
                        .fill(categoryColor(item.category))
                        .frame(width: geometry.size.width * CGFloat(item.progress), height: 8)
                        .cornerRadius(4)
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
    
    // 根据分类返回对应的颜色
    func categoryColor(_ category: String) -> Color {
        switch category {
        case "物质":
            return .green
        case "数字":
            return .blue
        case "时间":
            return .orange
        default:
            return .gray
        }
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
                if item.isCompleted {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 24, height: 24)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 24, height: 24)
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                .frame(width: 24, height: 24)
                        )
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

// 习惯培养视图
struct HabitView: View {
    // 习惯项目列表
    @State private var habitItems: [HabitItem] = [
        HabitItem(
            id: 1,
            title: "冥想15分钟",
            description: "清晨冥想，专注当下",
            time: "07:00",
            isCompleted: true
        ),
        HabitItem(
            id: 2,
            title: "整理工作区域",
            description: "保持桌面整洁，每天出门前整理",
            time: "08:30",
            isCompleted: true
        ),
        HabitItem(
            id: 3,
            title: "午餐后短散步",
            description: "饭后轻松散步15分钟",
            time: "12:30",
            isCompleted: true
        ),
        HabitItem(
            id: 4,
            title: "阅读30分钟",
            description: "每日阅读，培养思考习惯",
            time: "18:00",
            isCompleted: false
        ),
        HabitItem(
            id: 5,
            title: "每日反思",
            description: "记录今日的减法收获",
            time: "22:00",
            isCompleted: false
        )
    ]
    
    // 添加习惯的状态
    @State private var isAddingHabit = false
    @State private var newHabitTitle = ""
    @State private var newHabitDescription = ""
    @State private var newHabitTime = Date()
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(habitItems) { item in
                        HabitItemRow(item: item)
                    }
                }
                .background(Color(UIColor.systemGray6))
            }
            .overlay(
                VStack {
                    Spacer()
                    Button(action: {
                        isAddingHabit = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.1, green: 0.15, blue: 0.25))
                                .frame(width: 60, height: 60)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, 20)
                }
            )
            .background(Color(UIColor.systemGray6))
            .edgesIgnoringSafeArea(.bottom)
            
            // 添加新习惯的表单
            if isAddingHabit {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isAddingHabit = false
                    }
                
                VStack(spacing: 20) {
                    Text("添加新习惯")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 5)
                    
                    // 习惯名称输入框
                    VStack(alignment: .leading, spacing: 5) {
                        Text("习惯名称")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        
                        TextField("例如：晨跑", text: $newHabitTitle)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    // 习惯描述输入框
                    VStack(alignment: .leading, spacing: 5) {
                        Text("描述")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        
                        TextField("可选：简短描述这个习惯", text: $newHabitDescription)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    // 时间选择器
                    VStack(alignment: .leading, spacing: 5) {
                        Text("时间")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                        
                        DatePicker("", selection: $newHabitTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .frame(maxHeight: 120)
                            .labelsHidden()
                    }
                    
                    Spacer()
                    
                    // 按钮区域
                    HStack {
                        Button(action: {
                            isAddingHabit = false
                        }) {
                            Text("取消")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(8)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            addNewHabit()
                        }) {
                            Text("添加")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(Color(red: 0.1, green: 0.15, blue: 0.25))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }
                        .disabled(newHabitTitle.isEmpty)
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
                .frame(maxHeight: 550)
            }
        }
    }
    
    // 添加新习惯
    func addNewHabit() {
        // 检查输入是否有效
        guard !newHabitTitle.isEmpty else {
            return
        }
        
        // 生成时间字符串
        let timeString = timeFormatter.string(from: newHabitTime)
        
        // 创建新习惯
        let newHabit = HabitItem(
            id: (habitItems.map { $0.id }.max() ?? 0) + 1,
            title: newHabitTitle,
            description: newHabitDescription.isEmpty ? "新习惯" : newHabitDescription,
            time: timeString,
            isCompleted: false
        )
        
        // 输出调试信息
        print("添加新习惯: \(newHabit.title), 时间: \(timeString), 当前列表数量: \(habitItems.count)")
        
        // 按时间顺序插入
        var insertIndex = habitItems.count
        for (index, item) in habitItems.enumerated() {
            if let itemTime = timeFormatter.date(from: item.time),
               let newTime = timeFormatter.date(from: timeString),
               itemTime > newTime {
                insertIndex = index
                break
            }
        }
        
        // 添加到数组中
        habitItems.insert(newHabit, at: insertIndex)
        
        // 重置表单
        newHabitTitle = ""
        newHabitDescription = ""
        newHabitTime = Date()
        isAddingHabit = false
    }
}

// 习惯项目行视图
struct HabitItemRow: View {
    var item: HabitItem
    
    var body: some View {
        HStack(spacing: 0) {
            // 时间线
            VStack(spacing: 0) {
                ZStack {
                    if item.isCompleted {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 12, height: 12)
                    } else {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 12, height: 12)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 12, height: 12)
                            )
                    }
                }
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 2)
            }
            .frame(width: 50)
            .padding(.top, 20)
            
            // 习惯卡片
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(item.time)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(.bottom, 5)
                
                HabitCard(item: item)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 20)
        }
    }
}

// 习惯卡片视图
struct HabitCard: View {
    var item: HabitItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(item.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                if item.isCompleted {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 28, height: 28)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                    }
                } else {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                                .frame(width: 28, height: 28)
                        )
                }
            }
            
            Text(item.description)
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
    }
}

// 心灵空间视图
struct MindSpaceView: View {
    @State private var emotions: [EmotionItem] = [
        EmotionItem(id: 1, name: "平静", emoji: "😌", isSelected: false),
        EmotionItem(id: 2, name: "愉悦", emoji: "😊", isSelected: true),
        EmotionItem(id: 3, name: "低落", emoji: "😔", isSelected: false)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 顶部标题区域
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.9, green: 0.95, blue: 1.0))
                        .frame(height: 140)
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("心灵空间")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("静心，减负，内在的减法之旅")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // 今日情绪卡片
                EmotionCardView(emotions: $emotions)
                    .padding(.horizontal, 20)
                
                // 今日冥想卡片
                MeditationCardView()
                    .padding(.horizontal, 20)
                
                // 今日反思卡片
                ReflectionCardView()
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
            }
        }
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.top)
    }
}

// 情绪卡片视图
struct EmotionCardView: View {
    @Binding var emotions: [EmotionItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("今日情绪")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
            
            Text("选择你当前的情绪状态，记录情绪变化")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            HStack(spacing: 30) {
                ForEach(0..<emotions.count) { index in
                    EmotionButton(emotion: $emotions[index], allEmotions: $emotions)
                }
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

// 情绪按钮视图
struct EmotionButton: View {
    @Binding var emotion: EmotionItem
    @Binding var allEmotions: [EmotionItem]
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 70, height: 70)
                    .overlay(
                        Circle()
                            .stroke(emotion.isSelected ? Color.blue : Color.clear, lineWidth: 2)
                    )
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                
                Text(emotion.emoji)
                    .font(.system(size: 32))
            }
            .contentShape(Circle())
            .onTapGesture {
                for i in 0..<allEmotions.count {
                    allEmotions[i].isSelected = (allEmotions[i].id == emotion.id)
                }
            }
            
            Text(emotion.name)
                .font(.system(size: 16))
                .foregroundColor(.black)
        }
    }
}

// 冥想卡片视图
struct MeditationCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("今日冥想")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("15分钟")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            
            Text("专注呼吸，让心灵回归简单")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            // 播放按钮
            Button(action: {
                // 播放冥想音频逻辑
            }) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    Image(systemName: "play.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 10)
            
            // 冥想类型按钮
            HStack(spacing: 20) {
                MeditationTypeButton(title: "减压")
                
                MeditationTypeButton(title: "专注")
                
                MeditationTypeButton(title: "放松")
            }
            .padding(.top, 5)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.9, green: 0.95, blue: 1.0))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

// 冥想类型按钮
struct MeditationTypeButton: View {
    var title: String
    
    var body: some View {
        Button(action: {
            // 选择冥想类型逻辑
        }) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                )
        }
    }
}

// 反思卡片视图
struct ReflectionCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("今日反思")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
            
            Text("记录你今天的减法收获和感悟")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            Divider()
                .padding(.vertical, 5)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

#Preview {
    ContentView()
}
