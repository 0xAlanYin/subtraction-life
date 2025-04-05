//
//  QuoteCardView.swift
//  subtraction-life
//
//  Created by xing yin on 4/1/25.
//

import SwiftUI

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

struct QuoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteCardView(quote: "万物皆有时，减法亦有度。", source: "《减法人生》")
            .previewLayout(.sizeThatFits)
            .padding()
    }
} 