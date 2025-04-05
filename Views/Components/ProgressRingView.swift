//
//  ProgressRingView.swift
//  subtraction-life
//
//  Created by xing yin on 4/1/25.
//

import SwiftUI

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

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingView(progress: 0.75)
            .frame(width: 200, height: 200)
            .previewLayout(.sizeThatFits)
            .padding()
    }
} 