//
//  FilterOptions.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 26.09.2025.
//

import Foundation

struct FilterOptions {
    var selectedTimes: Set<String> = []
    var difficulties: Set<RecipeDifficulty> = []
    var hotLevels: Set<Hot> = []
    
    var isActive: Bool {
        !selectedTimes.isEmpty || !difficulties.isEmpty || !hotLevels.isEmpty
    }
    
    mutating func reset() {
        selectedTimes.removeAll()
        difficulties.removeAll()
        hotLevels.removeAll()
    }
}

let availableTimes = ["10 min", "20 min", "30 min", "60 min", "120 min", "240 min"]

func roundCookingTime(_ timeString: String) -> String {
    guard let minutes = extractMinutes(from: timeString) else { return "30 min" }
    
    let timeValues = [10, 20, 30, 60, 120, 240]
    
    let closest = timeValues.min(by: { abs($0 - minutes) < abs($1 - minutes) }) ?? 30
    
    return "\(closest) min"
}

private func extractMinutes(from timeString: String) -> Int? {
    let cleanString = timeString.replacingOccurrences(of: "min", with: "")
                               .trimmingCharacters(in: .whitespaces)
    
    let components = cleanString.components(separatedBy: ":")
    
    if components.count == 2 {
        if let hours = Int(components[0]), let minutes = Int(components[1]) {
            return hours * 60 + minutes
        }
    } else if let totalMinutes = Int(components[0]) {
        return totalMinutes
    }
    
    return nil
}
