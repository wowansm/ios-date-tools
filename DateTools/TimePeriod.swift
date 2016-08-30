//
//  TimePeriod.swift
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

public enum TimePeriodRelation : UInt {
    case after
    case startTouching
    case startInside
    case insideStartTouching
    case enclosingStartTouching
    case enclosing
    case enclosingEndTouching
    case exactMatch
    case inside
    case insideEndTouching
    case endInside
    case endTouching
    case before
    case none // One or more of the dates does not exist
}

public enum TimePeriodSize : UInt {
    case second
    case minute
    case hour
    case day
    case week
    case month
    case year
}

public enum TimePeriodInterval : UInt {
    case open
    case closed
}

public enum TimePeriodAnchor : UInt {
    case start
    case center
    case end
}

public class TimePeriod: NSObject {
    // MARK: - Properties
    /**
       The start date for a TimePeriod representing the starting boundary of the time period
     */
    public var startDate: Date
    
    /**
       The end date for a TimePeriod representing the ending boundary of the time period
     */
    public var endDate: Date
    
    /**
       Calendar used for date calculations
     */
    public let calendar: Calendar
    
    // MARK: - Initializers
    /**
      Initializes an instance of TimePeriod from a given start and end date
    
      - parameter startDate: Desired start date
      - parameter endDate: Desired end date
      - parameter calendar: Calendar used for date calculations, defaults to `Calendar.current`
    
      - returns: TimePeriod - new instance
     */
    public init(startDate: Date, endDate: Date, calendar: Calendar = Calendar.current) {
        self.startDate = startDate
        self.endDate = endDate
        self.calendar = calendar
        super.init()
    }
    
    /**
       Returns a new instance of TimePeriod that starts on the provided start date and is of the size provided. The amount represents a multipler to the size (e.g. "2 weeks" or "4 years")
    
       - parameter size: Desired size of the new time period
       - parameter amount: Desired multiplier of the size provided
       - parameter date: Desired start date of the new time period
       - parameter calendar: Calendar used for date calculations, defaults to `Calendar.current`
    
       - returns: TimePeriod - new instance
     */
    public convenience init(size: TimePeriodSize, amount: Int = 1, startingAt date: Date, calendar: Calendar = Calendar.current) {
        self.init(startDate: date, endDate: TimePeriod.dateWithAddedTime(size: size, amount: amount, baseDate: date, calendar: calendar), calendar: calendar)
    }
    
    
    /**
       Returns a new instance of TimePeriod that ends on the provided end date
       and is of the size provided. The amount represents a multipler to the size (e.g. "2 weeks" or "4 years")
    
       - parameter size: Desired size of the new time period
       - parameter amount: Desired multiplier of the size provided
       - parameter date: Desired end date of the new time period
       - parameter calendar: Calendar used for date calculations, defaults to `Calendar.current`
    
       - returns: TimePeriod - new instance
     */
    public convenience init(size: TimePeriodSize, amount: Int = 1, endingAt date: Date, calendar: Calendar = Calendar.current) {
        self.init(startDate: TimePeriod.dateWithSubtractedTime(size: size, amount: amount, baseDate: date, calendar: calendar), endDate: date, calendar: calendar)
    }
    
    // MARK: - TimePeriod methods
    /**
      Returns a new instance of TimePeriod that represents the largest time period available.
      The start date is in the distant past and the end date is in the distant future.
    
      - returns: TimePeriod - new instance
     */
    public class func timePeriodWithAllTime() -> TimePeriod {
        return TimePeriod(startDate: Date.distantPast, endDate: Date.distantFuture)
    }
    
    /**
      Returns a boolean representing whether the receiver is a "moment", that is the start and end dates are the same.
    
      - returns: true if receiver is a moment, otherwise false
     */
    public func isMoment() -> Bool {
        return self.startDate == self.endDate
    }
    
    // MARK: - Duration methods
    /**
       - returns: duration of the receiver in given `TimePeriodSize`
     */
    public func durationIn(size: TimePeriodSize) -> Int {
        switch size {
        case .second:
            return Int(self.durationInSeconds)
        case .minute:
            return Int(self.durationInMinutes)
        case .hour:
            return Int(self.durationInHours)
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
    
    /**
        - returns: duration of the receiver in years
     */
    public var durationInYears: Int {
        get { return self.calendar.yearsEarlier(for: self.startDate, than: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in months
    */
    public var durationInMonths: Int {
        get { return self.calendar.monthsEarlier(for: self.startDate, than: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in weeks
    */
    public var durationInWeeks: Int {
        get { return self.calendar.weeksEarlier(for: self.startDate, than: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in days
    */
    public var durationInDays: Int {
        get { return self.calendar.daysEarlier(for: self.startDate, than: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in hours
    */
    public var durationInHours: Double {
        get { return self.calendar.hoursEarlier(for: self.startDate, than: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in minutes
    */
    public var durationInMinutes: Double {
        get { return self.calendar.minutesEarlier(for: self.startDate, than: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in seconds
    */
    public var durationInSeconds: Double {
        get { return self.calendar.secondsEarlier(for: self.startDate, than: self.endDate) }
    }
    
    // MARK: - Relationship methods
    /**
       Returns a `Bool` representing whether the receiver's start and end dates exatcly match a given time period
    
       - parameter period: `TimePeriod` to compare to receiver
    
       - returns: `true` if the two periods are the same, otherwise `false`
     */
    public func equals(period: TimePeriod) -> Bool {
        return (self.startDate == period.startDate) && (self.endDate == period.endDate)
    }
    
    /**
       Returns a `Bool` representing whether the receiver's start and end dates exatcly match a given time period or is contained within them
    
       - parameter period: `TimePeriod` to compare to receiver
    
       - returns: `true` if the receiver is inside the given time period, otherwise `false`
     */
    public func isInside(period: TimePeriod) -> Bool {
        return (period.startDate <= self.startDate) && (period.endDate >= self.endDate)
    }
    
    /**
       Returns a `Bool` representing whether the given time period's start and end dates exatcly match the receivers' or is contained within them
    
    
       - parameter period: `TimePeriod` to compare to receiver
    
       -  BOOL
     */
    public func contains(period: TimePeriod) -> Bool {
        return (self.startDate <= period.startDate) && (self.endDate >= period.endDate)
    }
    
    /**
       Returns a `Bool` representing whether the receiver and the given time period overlap.
       This covers all space they share, minus instantaneous space (i.e. one's start date equals another's end date)
    
       - parameter period: `TimePeriod` to compare to receiver
    
       - returns: Returns `true` if they overlap, otherwise `false`
     */
    public func overlapsWith(period: TimePeriod) -> Bool {
        return (
            (period.startDate <  self.startDate && period.endDate >  self.startDate) ||
            (period.startDate >= self.startDate && period.endDate <= self.endDate) ||
            (period.startDate <  self.endDate   && period.endDate >  self.endDate)
        )
    }
    
    /**
       Returns a `Bool` representing whether the receiver and the given time period overlap.
       This covers all space they share, including instantaneous space (i.e. one's start date equals another's end date)
    
       - parameter period: `TimePeriod` to compare to receiver
    
       - returns: Returns `true` if they intersect, otherwise `false`
     */
    public func intersects(period: TimePeriod) -> Bool {
        return (
            (period.startDate <  self.startDate && period.endDate >= self.startDate) ||
            (period.startDate >= self.startDate && period.endDate <= self.endDate) ||
            (period.startDate <= self.endDate   && period.endDate >  self.endDate)
        )
    }
    
    /**
       - parameter period: `TimePeriod` to compare to receiver
    
       - returns: the relationship of the receiver to a given `TimePeriod`
     */
    public func relationTo(period: TimePeriod) -> TimePeriodRelation {
        guard self.startDate < self.endDate && period.startDate < period.endDate else {
            return .none
        }
        
        if period.endDate < self.startDate {
            return .after
        } else if period.endDate == self.startDate {
            return .startTouching
        } else if period.startDate <  self.startDate && period.endDate < self.endDate  {
            return .startInside
        } else if period.startDate == self.startDate && period.endDate > self.endDate {
            return .insideStartTouching
        } else if period.startDate == self.startDate && period.endDate < self.endDate {
            return .enclosingStartTouching
        } else if period.startDate > self.startDate  && period.endDate < self.endDate {
            return .enclosing
        } else if period.startDate > self.startDate  && period.endDate == self.endDate {
            return .enclosingEndTouching
        } else if period.startDate == self.startDate && period.endDate == self.endDate {
            return .exactMatch
        } else if period.startDate < self.startDate  && period.endDate > self.endDate {
            return .inside
        } else if period.startDate < self.startDate  && period.endDate == self.endDate {
            return .insideEndTouching
        } else if period.startDate < self.endDate    && period.endDate > self.endDate {
            return .endInside
        } else if period.startDate == self.endDate   && period.endDate > self.endDate {
            return .endTouching
        } else if period.startDate > self.endDate {
            return .before
        }
        return .none
    }
    
    /**
       - parameter period: `TimePeriod` to compute the gap
    
       - returns: the gap in seconds between the receiver and provided time period. Returns 0 if the time periods intersect, otherwise returns the gap between.
     */
    public func gapBetween(period: TimePeriod) -> TimeInterval {
        if self.endDate < period.startDate {
            return abs(self.endDate.timeIntervalSince(period.startDate))
        } else if period.endDate < self.startDate {
            return abs(period.endDate.timeIntervalSince(self.startDate))
        }
        return 0
    }
    
    /**
       - parameter date: Date to evaluate
       - parameter interval: TimePeriodInterval representing evaluation type (Closed includes StartDate and EndDate in evaluation, Open does not)
    
       - returns: `Bool` representing whether the provided date is contained in the receiver.
     */
    public func contains(date: Date, interval: TimePeriodInterval) -> Bool {
        switch interval {
        case .open:
            return self.startDate < date && self.endDate > date
        case .closed:
            return self.startDate <= date && self.endDate >= date
        }
    }
    
    // MARK: - Mutating methods
    /**
       Shifts the `startDate` and `endDate` earlier by a given size amount. Amount multiplies size.
    
       - parameter size: Desired shift size
       - parameter amount: Multiplier of size (i.e. "2 weeks" or "4 years")
     */
    public func shiftEarlier(withSize size: TimePeriodSize, amount: Int = 1) {
        self.startDate = TimePeriod.dateWithSubtractedTime(size: size, amount: amount, baseDate: self.startDate, calendar: self.calendar)
        self.endDate = TimePeriod.dateWithSubtractedTime(size: size, amount: amount, baseDate: self.endDate, calendar: self.calendar)
    }
    
    /**
       Shifts the `startDate` and `endDate` later by a given size amount. Amount multiplies size.
    
       - parameter size: Desired shift size
       - parameter amount: Multiplier of size (i.e. "2 weeks" or "4 years")
     */
    public func shiftLater(withSize size: TimePeriodSize, amount: Int = 1) {
        self.startDate = TimePeriod.dateWithAddedTime(size: size, amount: amount, baseDate: self.startDate, calendar: self.calendar)
        self.endDate = TimePeriod.dateWithAddedTime(size: size, amount: amount, baseDate: self.endDate, calendar: self.calendar)
    }
    
    /**
       Lengthens the receiver by a given amount, anchored by a provided point. Amount multiplies size.
    
       - parameter anchor: Anchor point for the lengthen (the date that stays the same)
       - parameter size: Desired lenghtening size
       - parameter amount: Multiplier of size (i.e. "2 weeks" or "4 years")
     */
    public func lengthen(withAnchor anchor: TimePeriodAnchor, size: TimePeriodSize, amount: Int = 1) {
        switch anchor {
        case .start:
            self.endDate = TimePeriod.dateWithAddedTime(size: size, amount: amount, baseDate: self.endDate, calendar: self.calendar)
        case .center:
            self.startDate = TimePeriod.dateWithSubtractedTime(size: size, amount: Int(Double(amount) * 0.5), baseDate: self.startDate, calendar: self.calendar)
            self.endDate = TimePeriod.dateWithAddedTime(size: size, amount: Int(Double(amount) * 0.5), baseDate: self.endDate, calendar: self.calendar)
        case .end:
            self.startDate = TimePeriod.dateWithSubtractedTime(size: size, amount: amount, baseDate: self.startDate, calendar: self.calendar)
        }
    }
    
    /**
       Shortens the receiver by a given amount, anchored by a provided point. Amount multiplies size.
    
       - parameter anchor: Anchor point for the shorten (the date that stays the same)
       - parameter size: Desired shortening size
       - parameter amount: Multiplier of size (i.e. "2 weeks" or "4 years")
     */
    public func shorten(withAnchor anchor: TimePeriodAnchor, size: TimePeriodSize, amount: Int = 1) {
        switch anchor {
        case .start:
            self.endDate = TimePeriod.dateWithSubtractedTime(size: size, amount: amount, baseDate: self.endDate, calendar: self.calendar)
        case .center:
            self.startDate = TimePeriod.dateWithAddedTime(size: size, amount: Int(Double(amount) * 0.5), baseDate: self.startDate, calendar: self.calendar)
            self.endDate = TimePeriod.dateWithSubtractedTime(size: size, amount: Int(Double(amount) * 0.5), baseDate: self.endDate, calendar: self.calendar)
        case .end:
            self.startDate = TimePeriod.dateWithAddedTime(size: size, amount: amount, baseDate: self.startDate, calendar: self.calendar)
        }
    }
    
    // public override func copy() -> AnyObject {
    //    return TimePeriod(startDate: Date(timeIntervalSince1970: self.startDate.timeIntervalSince1970), endDate: Date(timeIntervalSince1970: self.endDate.timeIntervalSince1970), calendar: self.calendar.copy() as! Calendar)
    // }
    
    // MARK: - Private helper methods
    private class func dateWithAddedTime(size: TimePeriodSize, amount: Int, baseDate date: Date, calendar: Calendar) -> Date {
        switch size {
        case .second:
            return calendar.dateByAdding(seconds: amount, to: date)
        case .minute:
            return calendar.dateByAdding(minutes: amount, to: date)
        case .hour:
            return calendar.dateByAdding(hours: amount, to: date)
        case .day:
            return calendar.dateByAdding(days: amount, to: date)
        case .week:
            return calendar.dateByAdding(weeks: amount, to: date)
        case .month:
            return calendar.dateByAdding(months: amount, to: date)
        case .year:
            return calendar.dateByAdding(years: amount, to: date)
        }
    }
    
    private class func dateWithSubtractedTime(size: TimePeriodSize, amount: Int, baseDate date: Date, calendar: Calendar) -> Date {
        switch size {
        case .second:
            return calendar.dateBySubtracting(seconds: amount, from: date)
        case .minute:
            return calendar.dateBySubtracting(minutes: amount, from: date)
        case .hour:
            return calendar.dateBySubtracting(hours: amount, from: date)
        case .day:
            return calendar.dateBySubtracting(days: amount, from: date)
        case .week:
            return calendar.dateBySubtracting(weeks: amount, from: date)
        case .month:
            return calendar.dateBySubtracting(months: amount, from: date)
        case .year:
            return calendar.dateBySubtracting(years: amount, from: date)
        }
    }
}

// MARK: - Comparators
public func == (lhs: TimePeriod, rhs: TimePeriod) -> Bool {
    return lhs.equals(period: rhs)
}

public func != (lhs: TimePeriod, rhs: TimePeriod) -> Bool {
    return !lhs.equals(period: rhs)
}
