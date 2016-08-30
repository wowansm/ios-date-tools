//
//  TimePeriodGroup.swift
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

protocol TimePeriodGroup: NSObjectProtocol {
    // MARK: - Date properties
    /**
      Number of time periods in group
    */
    var count: Int { get }
    
    /**
      Array containing TimePeriod objects
    */
    var periods: [TimePeriod] { get set }
    
    /**
      The start date of a group representing the earliest date of the time periods
    */
    var startDate: Date? { get }
    
    /**
      The end date of a group representing the latest date of the time periods
    */
    var endDate: Date? { get }
    
    /**
      Calendar used for date calculations
    */
    var calendar: Calendar { get }

    subscript(index: Int) -> TimePeriod { get set }
    
    // MARK: - Duration properties
    var durationInYears:   Int { get }
    var durationInMonths:  Int { get }
    var durationInWeeks:   Int { get }
    var durationInDays:    Int { get }
    var durationInHours:   Int { get }
    var durationInMinutes: Int { get }
    var durationInSeconds: Int { get }
    
    // MARK: - Methods
    /**
        Returns the duration of the receiver in given TimePeriodSize
    
        - parameter size: Desired period size
    
        - returns: duration of the receiver in given `TimePeriodSize`
    */
    func durationIn(size: TimePeriodSize) -> Int
    
    /**
        Shifts all TimePeriod objects later by a given size amount. Amount multiplies size.
    
        - parameter size: Desired shift size
        - parameter amount: Multiplier of size
    */
    func shiftLater(withSize: TimePeriodSize, amount: Int)
    
    /**
        Shifts all TimePeriod objects earlier by a given size amount. Amount multiplies size.
    
        - parameter size: Desired shift size
        - parameter amount: Multiplier of size
    */
    func shiftEarlier(withSize: TimePeriodSize, amount: Int)
    
    /**
        Checks whether given TimePeriodGroup has the same startDate, endDate and number of TimePeriod objects
    
        - parameter timePeriodGroup: `TimePeriodGroup` object to compare receiver to
    
        - returns: true if given `TimePeriodGroup` has the same characteristics as the receiver, false otherwise
    */
    func hasSameCharacteristicsAs(timePeriodGroup: TimePeriodGroup) -> Bool
}

extension TimePeriodGroup {
    // MARK: - Properties
    var count: Int { get { return self.periods.count } }
    
    subscript(index: Int) -> TimePeriod {
        get {
            return self.periods[index];
        }
        set (value) {
            self.periods[index] = value
        }
    }
    
    var durationInYears: Int {
        get {
            guard let startDate = self.startDate, let endDate = self.endDate else { return 0 }
            return self.calendar.yearsEarlier(for: startDate, than: endDate)
        }
    }
    
    var durationInMonths: Int {
        get {
            guard let startDate = self.startDate, let endDate = self.endDate else { return 0 }
            return self.calendar.monthsEarlier(for: startDate, than: endDate)
        }
    }
    
    var durationInWeeks: Int {
        get {
            guard let startDate = self.startDate, let endDate = self.endDate else { return 0 }
            return self.calendar.weeksEarlier(for: startDate, than: endDate)
        }
    }
    
    var durationInDays: Int {
        get {
            guard let startDate = self.startDate, let endDate = self.endDate else { return 0 }
            return self.calendar.daysEarlier(for: startDate, than: endDate)
        }
    }
    
    var durationInHours: Int {
        get {
            guard let startDate = self.startDate, let endDate = self.endDate else { return 0 }
            return Int(self.calendar.hoursEarlier(for: startDate, than: endDate))
        }
    }
    
    var durationInMinutes: Int {
        get {
            guard let startDate = self.startDate, let endDate = self.endDate else { return 0 }
            return Int(self.calendar.minutesEarlier(for: startDate, than: endDate))
        }
    }
    
    var durationInSeconds: Int {
        get {
            guard let startDate = self.startDate, let endDate = self.endDate else { return 0 }
            return Int(self.calendar.secondsEarlier(for: startDate, than: endDate))
        }
    }
    
    func durationIn(size: TimePeriodSize) -> Int {
        switch size {
        case .second:
            return self.durationInSeconds
        case .minute:
            return self.durationInMinutes
        case .hour:
            return self.durationInHours
        case .day:
            return self.durationInDays
        case .week:
            return self.durationInWeeks
        case .month:
            return self.durationInMonths
        case .year:
            return self.durationInYears
        }
    }
    
    func shiftLater(withSize size: TimePeriodSize, amount: Int = 1) {
        self.periods.forEach { elem in
            elem.shiftLater(withSize: size, amount: amount)
        }
    }
    
    func shiftEarlier(withSize size: TimePeriodSize, amount: Int) {
        self.periods.forEach { elem in
            elem.shiftEarlier(withSize: size, amount: amount)
        }
    }
    
    func hasSameCharacteristicsAs(timePeriodGroup: TimePeriodGroup) -> Bool {
        if timePeriodGroup.count != self.count {
            return false
        } else if timePeriodGroup.count == 0 {
            return true
        } else if timePeriodGroup.startDate != self.startDate || timePeriodGroup.endDate != self.endDate {
            return false
        }
        return true
    }
 
}

