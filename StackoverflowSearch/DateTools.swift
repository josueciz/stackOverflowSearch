//
//  DateTools.swift
//  StackoverflowSearch
//
//  Created by Josue on 2018/10/12.
//  Copyright © 2018 Private. All rights reserved.
//

import Foundation

class DateTools: NSObject
{
    override init()
    {
        super.init()
    }
    
    func convertDateToString(date: Date) -> String
    {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        let day: Int = Int(dayFormatter.string(from: date)) ?? 0
        var dayString: String = ""
        switch day {
        case 1:
            dayString = String(format: "%dst", day)
            break
        case 2:
            dayString = String(format: "%dnd", day)
            break
        case 3:
            dayString = String(format: "%drd", day)
            break
        default:
            dayString = String(format: "%dth", day)
            break
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy-HH:mm"
        
        let dateLabelText = String(format: "asked %@ %@", dayString, formatter.string(from: date)).replacingOccurrences(of: "-", with: " at ")
        
        return dateLabelText
    }
}
