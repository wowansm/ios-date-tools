//
//  Calendar+DateTools.swift
//  DateTools
//
// Copyright 2015 Codewise sp. z o.o. Sp. K.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

// Deprecate?
public let allCalendarComponentFlags: [Calendar.Component] = [
    Calendar.Component.year, Calendar.Component.quarter, Calendar.Component.month, Calendar.Component.day,
    Calendar.Component.hour, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal,
    Calendar.Component.weekOfMonth, Calendar.Component.weekOfYear, Calendar.Component.yearForWeekOfYear
]


public extension Calendar {
    public func date(year: Int = 1970, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var components = DateComponents()
        
        components.year   = year
        components.month  = month
        components.day    = day
        components.hour   = hour
        components.minute = minute
        components.second = second
        
        return self.date(from: components)!
    }
    
    // MARK: - Adding components to dates
    public func dateByAdding(years: Int, to date: Date) -> Date {
        var components = DateComponents()
        components.year = years
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateByAdding(months: Int, to date: Date) -> Date {
        var components = DateComponents()
        components.month = months
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateByAdding(weeks: Int, to date: Date) -> Date {
        var components = DateComponents()
        components.weekOfYear = weeks
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateByAdding(days: Int, to date: Date) -> Date {
        var components = DateComponents()
        components.day = days
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateByAdding(hours: Int, to date: Date) -> Date {
        var components = DateComponents()
        components.hour = hours
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateByAdding(minutes: Int, to date: Date) -> Date {
        var components = DateComponents()
        components.minute = minutes
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateByAdding(seconds: Int, to date: Date) -> Date {
        var components = DateComponents()
        components.second = seconds
        return self.date(byAdding: components, to: date)!
    }
    
    // MARK: - Subtracting components from dates
    public func dateBySubtracting(years: Int, from date: Date) -> Date {
        var components = DateComponents()
        components.year = -years
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateBySubtracting(months: Int, from date: Date) -> Date {
        var components = DateComponents()
        components.month = -months
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateBySubtracting(weeks: Int, from date: Date) -> Date {
        var components = DateComponents()
        components.weekOfYear = -weeks
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateBySubtracting(days: Int, from date: Date) -> Date {
        var components = DateComponents()
        components.day = -days
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateBySubtracting(hours: Int, from date: Date) -> Date {
        var components = DateComponents()
        components.hour = -hours
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateBySubtracting(minutes: Int, from date: Date) -> Date {
        var components = DateComponents()
        components.minute = -minutes
        return self.date(byAdding: components, to: date)!
    }
    
    public func dateBySubtracting(seconds: Int, from date: Date) -> Date {
        var components = DateComponents()
        components.second = -seconds
        return self.date(byAdding: components, to: date)!
    }
    
    // MARK: - Counting components between dates
    public func years(from firstDate: Date, to secondDate: Date) -> Int {
        let earliest = (firstDate < secondDate) ? firstDate : secondDate
        let latest = (firstDate < secondDate) ? secondDate : firstDate
        
        let multiplier = (earliest == firstDate) ? -1 : 1
        let components = self.dateComponents([Calendar.Component.year], from: earliest, to: latest)
        
        return multiplier * components.year!
    }
    
    public func months(from firstDate: Date, to secondDate: Date) -> Int {
        let earliest = (firstDate < secondDate) ? firstDate : secondDate
        let latest = (firstDate < secondDate) ? secondDate : firstDate
        
        let multiplier = (earliest == firstDate) ? -1 : 1
        // Does this still work?
        let components = self.dateComponents([Calendar.Component.month], from: earliest, to: latest)
        
        return multiplier * (components.month! + 12 * components.year!)
    }
    
    public func weeks(from firstDate: Date, to secondDate: Date) -> Int {
        let earliest = (firstDate < secondDate) ? firstDate : secondDate
        let latest = (firstDate < secondDate) ? secondDate : firstDate
        
        let multiplier = (earliest == firstDate) ? -1 : 1
        let components = self.dateComponents([Calendar.Component.weekOfYear], from: earliest, to: latest)
        
        return multiplier * components.weekOfYear!
    }
    
    public func days(from firstDate: Date, to secondDate: Date) -> Int {
        let earliest = (firstDate < secondDate) ? firstDate : secondDate
        let latest = (firstDate < secondDate) ? secondDate : firstDate
        
        let multiplier = (earliest == firstDate) ? -1 : 1
        let components = self.dateComponents([Calendar.Component.day], from: earliest, to: latest)
        
        return multiplier * components.day!
    }
    
    //MARK: - Counting how much earlier one date is than another
    public func yearsEarlier(for firstDate: Date, than secondDate: Date) -> Int {
        return abs(min(self.years(from: firstDate, to: secondDate), 0))
    }
    
    public func monthsEarlier(for firstDate: Date, than secondDate: Date) -> Int {
        return abs(min(self.months(from: firstDate, to: secondDate), 0))
    }
    
    public func weeksEarlier(for firstDate: Date, than secondDate: Date) -> Int {
        return abs(min(self.weeks(from: firstDate, to: secondDate), 0))
    }
    
    public func daysEarlier(for firstDate: Date, than secondDate: Date) -> Int {
        return abs(min(self.days(from: firstDate, to: secondDate), 0))
    }
    
    public func hoursEarlier(for firstDate: Date, than secondDate: Date) -> Double {
        return abs(min(firstDate.hoursFrom(date: secondDate), 0))
    }
    
    public func minutesEarlier(for firstDate: Date, than secondDate: Date) -> Double {
        return abs(min(firstDate.minutesFrom(date: secondDate), 0))
    }
    
    public func secondsEarlier(for firstDate: Date, than secondDate: Date) -> Double {
        return abs(min(firstDate.secondsFrom(date: secondDate), 0))
    }
    
    public static func isLeapYear(year: Int) -> Bool {
        return (year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0))
    }
}
