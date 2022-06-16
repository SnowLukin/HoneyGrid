//
//  Home.swift
//  HoneyGrid
//
//  Created by Snow Lukin on 16.06.2022.
//

import SwiftUI

struct HomeView: View {
    
    @State var data: [String] = Array(repeating: "_", count: 0)
    @State var rows: [[String]] = []
    
    // padding = 30
    let width = UIScreen.main.bounds.width - 30
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: -10) {
                    ForEach(rows.indices, id: \.self) { index in
                        HStack(spacing: 12) {
                            ForEach(rows[index], id: \.self) { value in
                                Hexagon()
                                    .fill(.red)
                                    .frame(width: (width - 20) / 3.2, height: 110)
                                    .offset(x: getOffset(index: index))
                                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                            }
                        }
                    }
                }
                .padding()
                .frame(width: width)
            }
            .onAppear {
                generateHoney()
            }
            .navigationTitle("Honey Grid")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring()) {
                            rows.removeAll()
                            data.append("_")
                            generateHoney()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring()) {
                            rows.removeAll()
                            data.removeLast()
                            generateHoney()
                        }
                    } label: {
                        Image(systemName: "minus")
                    }
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    
    private func getOffset(index: Int) -> CGFloat {
        let current = rows[index].count
        
        let offset = ((width - 20) / 3) / 2
        
        if index != 0 {
            let previous = rows[index - 1].count
            
            if current == 1 && previous == 3 {
                return -offset
            }
            
            if current == previous {
                return -offset
            }
        }
        return 0
    }
    
    private func generateHoney() {
        var count = 0
        
        var generated: [String] = []
        for index in data {
            generated.append(index)
            
            if generated.count == 2 {
                if let last = rows.last {
                    if last.count == 3 {
                        rows.append(generated)
                        generated.removeAll()
                    }
                }
                
                if rows.isEmpty {
                    rows.append(generated)
                    generated.removeAll()
                }
            }
            if generated.count == 3 {
                if let last = rows.last {
                    if last.count == 2 {
                        rows.append(generated)
                        generated.removeAll()
                    }
                }
            }
            
            count += 1
            // for exhaust data or single data
            if count == data.count && !generated.isEmpty {
                rows.append(generated)
            }
        }
    }
    
}
