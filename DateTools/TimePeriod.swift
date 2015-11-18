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
    case After
    case StartTouching
    case StartInside
    case InsideStartTouching
    case EnclosingStartTouching
    case Enclosing
    case EnclosingEndTouching
    case ExactMatch
    case Inside
    case InsideEndTouching
    case EndInside
    case EndTouching
    case Before
    case None //One or more of the dates does not exist
}

public enum TimePeriodSize : UInt {
    case Second
    case Minute
    case Hour
    case Day
    case Week
    case Month
    case Year
}

public enum TimePeriodInterval : UInt {
    case Open
    case Closed
}

public enum TimePeriodAnchor : UInt {
    case Start
    case Center
    case End
}

public class TimePeriod: NSObject {
    
    /**
       The start date for a TimePeriod representing the starting boundary of the time period
     */
    public var startDate: NSDate
    
    /**
       The end date for a TimePeriod representing the ending boundary of the time period
     */
    public var endDate: NSDate
    
    /**
       Calendar used for date calculations
     */
    public let calendar: NSCalendar
    
    /**
      Initializes an instance of TimePeriod from a given start and end date
    
      - parameter startDate: Desired start date
      - parameter endDate: Desired end date
      - parameter calendar: Calendar used for date calculations, defaults to `NSCalendar.currentCalendar()`
    
      - returns: TimePeriod - new instance
     */
    public init(startDate: NSDate, endDate: NSDate, calendar: NSCalendar = NSCalendar.currentCalendar()) {
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
       - parameter calendar: Calendar used for date calculations, defaults to `NSCalendar.currentCalendar()`
    
       - returns: TimePeriod - new instance
     */
    public convenience init(size: TimePeriodSize, amount: Int = 1, startingAt date: NSDate, calendar: NSCalendar = NSCalendar.currentCalendar()) {
        self.init(startDate: date, endDate: TimePeriod.dateWithAddedTime(size, amount: amount, baseDate: date, calendar: calendar), calendar: calendar)
    }
    
    
    /**
       Returns a new instance of TimePeriod that ends on the provided end date
       and is of the size provided. The amount represents a multipler to the size (e.g. "2 weeks" or "4 years")
    
       - parameter size: Desired size of the new time period
       - parameter amount: Desired multiplier of the size provided
       - parameter date: Desired end date of the new time period
       - parameter calendar: Calendar used for date calculations, defaults to `NSCalendar.currentCalendar()`
    
       - returns: TimePeriod - new instance
     */
    public convenience init(size: TimePeriodSize, amount: Int = 1, endingAt date: NSDate, calendar: NSCalendar = NSCalendar.currentCalendar()) {
        self.init(startDate: TimePeriod.dateWithSubtractedTime(size, amount: amount, baseDate: date, calendar: calendar), endDate: date, calendar: calendar)
    }
    
    /**
      Returns a new instance of TimePeriod that represents the largest time period available.
      The start date is in the distant past and the end date is in the distant future.
    
      - returns: TimePeriod - new instance
     */
    public class func timePeriodWithAllTime() -> TimePeriod {
        return TimePeriod(startDate: NSDate.distantPast(), endDate: NSDate.distantFuture())
    }
    
    /**
      Returns a boolean representing whether the receiver is a "moment", that is the start and end dates are the same.
    
      - returns: true if receiver is a moment, otherwise false
     */
    public func isMoment() -> Bool {
        return self.startDate.isEqualToDate(self.endDate)
    }
    
    
    /**
       - returns: duration of the receiver in given `TimePeriodSize`
     */
    public func durationIn(size: TimePeriodSize) -> Int {
        switch size {
        case .Second:
            return Int(self.durationInSeconds)
        case .Minute:
            return Int(self.durationInMinutes)
        case .Hour:
            return Int(self.durationInHours)
        case .Day:
            return self.durationInDays
        case .Week:
            return self.durationInWeeks
        case .Month:
            return self.durationInMonths
        case .Year:
            return self.durationInYears
        }
    }
    
    /**
        - returns: duration of the receiver in years
     */
    public var durationInYears: Int {
        get { return self.calendar.yearsEarlierFor(self.startDate, thanDate: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in months
    */
    public var durationInMonths: Int {
        get { return self.calendar.monthsEarlierFor(self.startDate, thanDate: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in weeks
    */
    public var durationInWeeks: Int {
        get { return self.calendar.weeksEarlierFor(self.startDate, thanDate: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in days
    */
    public var durationInDays: Int {
        get { return self.calendar.daysEarlierFor(self.startDate, thanDate: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in hours
    */
    public var durationInHours: Double {
        get { return self.calendar.hoursEarlierFor(self.startDate, thanDate: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in minutes
    */
    public var durationInMinutes: Double {
        get { return self.calendar.minutesEarlierFor(self.startDate, thanDate: self.endDate) }
    }
    
    /**
        - returns: duration of the receiver in seconds
    */
    public var durationInSeconds: Double {
        get { return self.calendar.secondsEarlierFor(self.startDate, thanDate: self.endDate) }
    }
    
    /**
       Returns a `Bool` representing whether the receiver's start and end dates exatcly match a given time period
    
       - parameter period: `TimePeriod` to compare to receiver
    
       - returns: `true` if the two periods are the same, otherwise `false`
     */
    public func isEqualToPeriod(period: TimePeriod) -> Bool {
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
    public func relationToPeriod(period: TimePeriod) -> TimePeriodRelation {
        guard self.startDate < self.endDate && period.startDate < period.endDate else {
            return .None
        }
        
        if period.endDate < self.startDate {
            return .After
        } else if period.endDate == self.startDate {
            return .StartTouching
        } else if period.startDate <  self.startDate && period.endDate < self.endDate  {
            return .StartInside
        } else if period.startDate == self.startDate && period.endDate > self.endDate {
            return .InsideStartTouching
        } else if period.startDate == self.startDate && period.endDate < self.endDate {
            return .EnclosingStartTouching
        } else if period.startDate > self.startDate  && period.endDate < self.endDate {
            return .Enclosing
        } else if period.startDate > self.startDate  && period.endDate == self.endDate {
            return .EnclosingEndTouching
        } else if period.startDate == self.startDate && period.endDate == self.endDate {
            return .ExactMatch
        } else if period.startDate < self.startDate  && period.endDate > self.endDate {
            return .Inside
        } else if period.startDate < self.startDate  && period.endDate == self.endDate {
            return .InsideEndTouching
        } else if period.startDate < self.endDate    && period.endDate > self.endDate {
            return .EndInside
        } else if period.startDate == self.endDate   && period.endDate > self.endDate {
            return .EndTouching
        } else if period.startDate > self.endDate {
            return .Before
        }
        return .None
    }
    
    /**
       - parameter period: `TimePeriod` to compute the gap
    
       - returns: the gap in seconds between the receiver and provided time period. Returns 0 if the time periods intersect, otherwise returns the gap between.
     */
    public func gapBetween(period: TimePeriod) -> NSTimeInterval {
        if self.endDate < period.startDate {
            return abs(self.endDate.timeIntervalSinceDate(period.startDate))
        } else if period.endDate < self.startDate {
            return abs(period.endDate.timeIntervalSinceDate(self.startDate))
        }
        return 0
    }
    
    /**
       - parameter date: Date to evaluate
       - parameter interval: TimePeriodInterval representing evaluation type (Closed includes StartDate and EndDate in evaluation, Open does not)
    
       - returns: `Bool` representing whether the provided date is contained in the receiver.
     */
    public func containsDate(date: NSDate, interval: TimePeriodInterval) -> Bool {
        switch interval {
        case .Open:
            return self.startDate < date && self.endDate > date
        case .Closed:
            return self.startDate <= date && self.endDate >= date
        }
    }
    
    /**
       - parameter size: Desired size, defaults to seconds.
     
       - returns: new `TimePeriod` instance earlier than receiver by duration in given size (defaults to seconds).
     */
    public func previous(size: TimePeriodSize = .Second) -> TimePeriod {
        return TimePeriod(size: size, amount: self.durationIn(size), endingAt: self.startDate, calendar: self.calendar)
    }
    
    /**
       - parameter size: Desired size, defaults to seconds.
     
       - returns: new `TimePeriod` instance later than receiver by duration in given size (defaults to seconds).
    */
    public func next(size: TimePeriodSize = .Second) -> TimePeriod {
        return TimePeriod(size: size, amount: self.durationIn(size), startingAt: self.endDate, calendar: self.calendar)
    }
    
    /**
       Shifts the `startDate` and `endDate` earlier by a given size amount. Amount multiplies size.
    
       - parameter size: Desired shift size
       - parameter amount: Multiplier of size (i.e. "2 weeks" or "4 years")
     */
    public func shiftEarlierWithSize(size: TimePeriodSize, amount: Int = 1) {
        self.startDate = TimePeriod.dateWithSubtractedTime(size, amount: amount, baseDate: self.startDate, calendar: self.calendar)
        self.endDate = TimePeriod.dateWithSubtractedTime(size, amount: amount, baseDate: self.endDate, calendar: self.calendar)
    }
    
    /**
       Shifts the `startDate` and `endDate` later by a given size amount. Amount multiplies size.
    
       - parameter size: Desired shift size
       - parameter amount: Multiplier of size (i.e. "2 weeks" or "4 years")
     */
    public func shiftLaterWithSize(size: TimePeriodSize, amount: Int = 1) {
        self.startDate = TimePeriod.dateWithAddedTime(size, amount: amount, baseDate: self.startDate, calendar: self.calendar)
        self.endDate = TimePeriod.dateWithAddedTime(size, amount: amount, baseDate: self.endDate, calendar: self.calendar)
    }
    
    /**
       Lengthens the receiver by a given amount, anchored by a provided point. Amount multiplies size.
    
       - parameter anchor: Anchor point for the lengthen (the date that stays the same)
       - parameter size: Desired lenghtening size
       - parameter amount: Multiplier of size (i.e. "2 weeks" or "4 years")
     */
    public func lengthenWithAnchorDate(anchor: TimePeriodAnchor, size: TimePeriodSize, amount: Int = 1) {
        switch anchor {
        case .Start:
            self.endDate = TimePeriod.dateWithAddedTime(size, amount: amount, baseDate: self.endDate, calendar: self.calendar)
        case .Center:
            self.startDate = TimePeriod.dateWithSubtractedTime(size, amount: Int(Double(amount) * 0.5), baseDate: self.startDate, calendar: self.calendar)
            self.endDate = TimePeriod.dateWithAddedTime(size, amount: Int(Double(amount) * 0.5), baseDate: self.endDate, calendar: self.calendar)
        case .End:
            self.startDate = TimePeriod.dateWithSubtractedTime(size, amount: amount, baseDate: self.startDate, calendar: self.calendar)
        }
    }
    
    /**
       Shortens the receiver by a given amount, anchored by a provided point. Amount multiplies size.
    
       - parameter anchor: Anchor point for the shorten (the date that stays the same)
       - parameter size: Desired shortening size
       - parameter amount: Multiplier of size (i.e. "2 weeks" or "4 years")
     */
    public func shortenWithAnchorDate(anchor: TimePeriodAnchor, size: TimePeriodSize, amount: Int = 1) {
        switch anchor {
        case .Start:
            self.endDate = TimePeriod.dateWithSubtractedTime(size, amount: amount, baseDate: self.endDate, calendar: self.calendar)
        case .Center:
            self.startDate = TimePeriod.dateWithAddedTime(size, amount: Int(Double(amount) * 0.5), baseDate: self.startDate, calendar: self.calendar)
            self.endDate = TimePeriod.dateWithSubtractedTime(size, amount: Int(Double(amount) * 0.5), baseDate: self.endDate, calendar: self.calendar)
        case .End:
            self.startDate = TimePeriod.dateWithAddedTime(size, amount: amount, baseDate: self.startDate, calendar: self.calendar)
        }
    }
    
    public override func copy() -> AnyObject {
        return TimePeriod(startDate: NSDate(timeIntervalSince1970: self.startDate.timeIntervalSince1970), endDate: NSDate(timeIntervalSince1970: self.endDate.timeIntervalSince1970), calendar: self.calendar.copy() as! NSCalendar)
    }
    
    //MARK: - Private
    
    private class func dateWithAddedTime(size: TimePeriodSize, amount: Int, baseDate date: NSDate, calendar: NSCalendar) -> NSDate {
        switch size {
        case .Second:
            return calendar.dateByAddingSeconds(amount, toDate: date)
        case .Minute:
            return calendar.dateByAddingMinutes(amount, toDate: date)
        case .Hour:
            return calendar.dateByAddingHours(amount, toDate: date)
        case .Day:
            return calendar.dateByAddingDays(amount, toDate: date)
        case .Week:
            return calendar.dateByAddingWeeks(amount, toDate: date)
        case .Month:
            return calendar.dateByAddingMonths(amount, toDate: date)
        case .Year:
            return calendar.dateByAddingYears(amount, toDate: date)
        }
    }
    
    private class func dateWithSubtractedTime(size: TimePeriodSize, amount: Int, baseDate date: NSDate, calendar: NSCalendar) -> NSDate {
        switch size {
        case .Second:
            return calendar.dateBySubtractingSeconds(amount, toDate: date)
        case .Minute:
            return calendar.dateBySubtractingMinutes(amount, toDate: date)
        case .Hour:
            return calendar.dateBySubtractingHours(amount, toDate: date)
        case .Day:
            return calendar.dateBySubtractingDays(amount, toDate: date)
        case .Week:
            return calendar.dateBySubtractingWeeks(amount, toDate: date)
        case .Month:
            return calendar.dateBySubtractingMonths(amount, toDate: date)
        case .Year:
            return calendar.dateBySubtractingYears(amount, toDate: date)
        }
    }
    
}

public func == (lhs: TimePeriod, rhs: TimePeriod) -> Bool {
    return lhs.isEqualToPeriod(rhs)
}

public func != (lhs: TimePeriod, rhs: TimePeriod) -> Bool {
    return !lhs.isEqualToPeriod(rhs)
}
