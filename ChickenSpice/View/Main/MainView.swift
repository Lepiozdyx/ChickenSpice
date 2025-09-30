//
//  MainView.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 24.09.2025.
//

import SwiftUI

enum MainTab: CaseIterable, Hashable {
    case cat, fav, meal
    
    var title: String {
        switch self {
        case .cat: return "Category"
        case .fav: return "Favourites"
        case .meal: return "Week meal"
        }
    }
    
    var icon: String {
        switch self {
        case .cat: return "Category"
        case .fav: return "Favourites"
        case .meal: return "Meal"
        }
    }
}

struct MainView: View {
    @State private var selectedTab: MainTab = .cat
    @StateObject var favoriteManager = FavoriteManager()
    @StateObject var weekMealManager = WeekMealManager()
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Group {
                    switch selectedTab {
                    case .cat:
                        CategoryView()
                            .environmentObject(favoriteManager)
                            .environmentObject(weekMealManager)
                    case .fav:
                        FavView()
                            .environmentObject(favoriteManager)
                    case .meal:
                        MealView()
                            .environmentObject(weekMealManager)
                            .environmentObject(favoriteManager)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.back)
                
                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, 16)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    MainView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: MainTab
    private let cornerRadius: CGFloat = 20
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.tabBack)
            HStack(spacing: 0) {
                ForEach(MainTab.allCases, id: \.self) { tab in
                    TabButton(
                        tab: tab,
                        isSelected: tab == selectedTab,
                        action: {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                                selectedTab = tab
                            }
                        }
                    )
                    if tab != MainTab.allCases.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
        }
        .frame(width: UIScreen.main.bounds.width - 48, height: 80)
        .padding(.horizontal, 24)
    }
}

struct TabButton: View {
    let tab: MainTab
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(tab.icon)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(isSelected ? .red : .white)
                
                Text(tab.title)
                    .font(.custom(.MontserratRegular, size: 14))
                    .foregroundStyle(isSelected ? .tabSelect : .white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 6)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(tab.title)
    }
}
