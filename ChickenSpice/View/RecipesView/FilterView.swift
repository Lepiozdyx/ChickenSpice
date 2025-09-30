//
//  FilterView.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 26.09.2025.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var filterOptions: FilterOptions
    @State private var selectedHotLevel: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Filter")
                                .font(.custom(.MontserratBold, size: 20))
                            Text("Cook time")
                                .font(.custom(.MontserratSemiBold, size: 16))
                                .foregroundColor(.black)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
                                ForEach(availableTimes, id: \.self) { time in
                                    CustomCheckbox(
                                        title: time,
                                        isSelected: filterOptions.selectedTimes.contains(time)
                                    ) {
                                        if filterOptions.selectedTimes.contains(time) {
                                            filterOptions.selectedTimes.remove(time)
                                        } else {
                                            filterOptions.selectedTimes.insert(time)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Difficulty")
                                .font(.custom(.MontserratSemiBold, size: 16))
                                .foregroundColor(.black)
                            
                            HStack(spacing: 0) {
                                ForEach(RecipeDifficulty.allCases, id: \.self) { difficulty in
                                    CustomCheckbox(
                                        title: difficulty.rawValue,
                                        isSelected: filterOptions.difficulties.contains(difficulty)
                                    ) {
                                        if filterOptions.difficulties.contains(difficulty) {
                                            filterOptions.difficulties.remove(difficulty)
                                        } else {
                                            filterOptions.difficulties.insert(difficulty)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Spiciness")
                                .font(.custom(.MontserratSemiBold, size: 16))
                                .foregroundColor(.black)
                            
                            HStack(spacing: 0) {
                                Button(action: {
                                    if selectedHotLevel > 0 {
                                        selectedHotLevel -= 1
                                        updateHotLevels()
                                    }
                                }) {
                                    Image("minus")
                                        
                                }
                                .disabled(selectedHotLevel == 0)
                                
                                HStack(spacing: 4) {
                                    ForEach(1...3, id: \.self) { level in
                                        Image(level <= selectedHotLevel ? "Chilli" : "ChilliNone")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }
                                }
                                .padding(.horizontal, 8)
                                
                                Button(action: {
                                    if selectedHotLevel < 3 {
                                        selectedHotLevel += 1
                                        updateHotLevels()
                                    }
                                }) {
                                    Image("plus")
                                        
                                }
                                .disabled(selectedHotLevel == 3)
                                
                                Spacer()
                            
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            
                            
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.vertical, 20)
                }
                
            }
            
        }
    }
    
    private func hotLevelTitle(_ hot: Hot) -> String {
        switch hot {
        case .one: return "Mild"
        case .two: return "Medium"
        case .three: return "Hot"
        }
    }
    
    private var hotLevelText: String {
            switch selectedHotLevel {
            case 0: return "Not selected"
            case 1: return "Mild (1)"
            case 2: return "Medium (2)"
            case 3: return "Hot (3)"
            default: return "Not selected"
            }
        }
        
    private func updateHotLevels() {
        filterOptions.hotLevels.removeAll()
        
        if selectedHotLevel > 0 {
            if let hotLevel = Hot(rawValue: selectedHotLevel) {
                filterOptions.hotLevels.insert(hotLevel)
            }
        }
    }
        
        private func updateSelectedHotLevelFromFilter() {
            // Восстанавливаем уровень из фильтра
            if filterOptions.hotLevels.isEmpty {
                selectedHotLevel = 0
            } else {
                // Находим максимальный выбранный уровень
                let maxLevel = filterOptions.hotLevels.map { $0.rawValue }.max() ?? 0
                selectedHotLevel = maxLevel
            }
        }
}

struct CustomCheckbox: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(isSelected ? "selected" : "unselected")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.custom(.MontserratRegular, size: 14))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
        }
    }
}
#Preview {
    MainView()
}
