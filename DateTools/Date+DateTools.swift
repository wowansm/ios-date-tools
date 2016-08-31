//
//  Date+DateTools.swift
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

public extension Date {
    
    public static func dateWith(year: Int = 1970, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var components = DateComponents()
        
        components.year   = year
        components.month  = month
        components.day    = day
        components.hour   = hour
        components.minute = minute
        components.second = second
        
        return Calendar.current.date(from: components)!
    }

    // MARK: - Adding components to date
    public func dateByAdding(years: Int) -> Date {
        return Calendar.current.dateByAdding(years: years, to: self)
    }
    
    public func dateByAdding(months: Int) -> Date {
        return Calendar.current.dateByAdding(months: months, to: self)
    }
    
    public func dateByAdding(weeks: Int) -> Date {
        return Calendar.current.dateByAdding(weeks: weeks, to: self)
    }
    
    public func dateByAdding(days: Int) -> Date {
        return Calendar.current.dateByAdding(days: days, to: self)
    }
    
    public func dateByAdding(hours: Int) -> Date {
        return Calendar.current.dateByAdding(hours: hours, to: self)
    }
    
    public func dateByAdding(minutes: Int) -> Date {
        return Calendar.current.dateByAdding(minutes: minutes, to: self)
    }
    
    public func dateByAdding(seconds: Int) -> Date {
        return Calendar.current.dateByAdding(seconds: seconds, to: self)
    }
    
    // MARK: - Subtracting components from date
    public func dateBySubtracting(years: Int) -> Date {
        return Calendar.current.dateBySubtracting(years: years, from: self)
    }
    
    public func dateBySubtracting(months: Int) -> Date {
        return Calendar.current.dateBySubtracting(months: months, from: self)
    }
    
    public func dateBySubtracting(weeks: Int) -> Date {
        return Calendar.current.dateBySubtracting(weeks: weeks, from: self)
    }
    
    public func dateBySubtracting(days: Int) -> Date {
        return Calendar.current.dateBySubtracting(days: days, from: self)
    }
    
    public func dateBySubtracting(hours: Int) -> Date {
        return Calendar.current.dateBySubtracting(hours: hours, from: self)
    }
    
    public func dateBySubtracting(minutes: Int) -> Date {
        return Calendar.current.dateBySubtracting(minutes: minutes, from: self)
    }
    
    public func dateBySubtracting(seconds: Int) -> Date {
        return Calendar.current.dateBySubtracting(seconds: seconds, from: self)
    }

    public func hoursFrom(date: Date) -> Double {
        return self.timeIntervalSince(date) / Double(SecondsIn.hour.rawValue)
    }
    
    public func minutesFrom(date: Date) -> Double {
        return self.timeIntervalSince(date) / Double(SecondsIn.minute.rawValue)
    }
    
    public func secondsFrom(date: Date) -> Double {
        return self.timeIntervalSince(date)
    }
}
