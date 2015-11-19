//
//  TimePeriodTests.swift
//  DateTools
//
//  Created by Paweł Sękara on 22.09.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import Foundation
import XCTest
import Nimble
@testable import DateTools

class TimePeriodTests: XCTestCase {
    
    var startDate: NSDate!
    var endDate: NSDate!
    var longPeriod: TimePeriod!
    var shortPeriod: TimePeriod!
    var veryShortPeriod: TimePeriod!
    var periodBefore: TimePeriod!
    var periodAfter: TimePeriod!
    var periodBeforeOverlaps: TimePeriod!
    var periodAfterOverlaps: TimePeriod!
    var periodInside: TimePeriod!
    var periodBeforeTouching: TimePeriod!
    var periodAfterTouching: TimePeriod!

    
    var calendar: NSCalendar!
    
    override func setUp() {
        super.setUp()
        calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        startDate = date("2000-01-01")
        endDate = date("1900-06-15")
        longPeriod = TimePeriod(startDate: endDate, endDate: startDate, calendar: calendar)
        shortPeriod = TimePeriod(startDate: startDate, endDate: date("2000-03-14"), calendar: calendar)
        veryShortPeriod = TimePeriod(startDate: startDate, endDate: date("2000-01-02 12:20:30"), calendar: calendar)
        periodBeforeOverlaps = TimePeriod(startDate: date("1890-01-01"), endDate: date("1960-01-01"), calendar: calendar)
        periodAfterOverlaps = TimePeriod(startDate: date("1950-01-01"), endDate: date("2010-01-01"), calendar: calendar)
        periodBefore = TimePeriod(startDate: date("1890-01-01"), endDate: date("1900-06-14"), calendar: calendar)
        periodAfter = TimePeriod(startDate: date("2000-01-02"), endDate: date("2010-01-01"), calendar: calendar)
        periodInside = TimePeriod(startDate: date("1950-01-01"), endDate: date("1960-01-01"), calendar: calendar)
        periodBeforeTouching = TimePeriod(startDate: date("1890-01-01"), endDate: date("1900-06-15"), calendar: calendar)
        periodAfterTouching = TimePeriod(startDate: date("2000-01-01"), endDate: date("2010-01-01"), calendar: calendar)
    }
    
    override func tearDown() {
        startDate = nil
        endDate = nil
        longPeriod = nil
        shortPeriod = nil
        veryShortPeriod = nil
        periodBefore = nil
        periodAfter = nil
        periodBeforeOverlaps = nil
        periodAfterOverlaps = nil
        periodInside = nil
        calendar = nil
        periodBeforeTouching = nil
        periodAfterTouching = nil
        super.tearDown()
    }
    
    //MARK: - create with starting date
    
    func testTimePeriod_createPeriodsWithStartingDate_returnsValidTimePeriods() {
        let testCases: [(TimePeriodSize, Int, NSDate)] = [
            (.Day, 1, date("2000-01-02")),
            (.Month, 1, date("2000-02-01")),
            (.Year, 1, date("2001-01-01")),
            (.Day, 5, date("2000-01-06")),
            (.Month, 5, date("2000-06-01")),
            (.Year, 5, date("2005-01-01")),
            (.Day, 50, date("2000-02-20")),
            (.Month, 14, date("2001-03-01")),
            (.Day, -10, date("1999-12-22")),
            (.Month, -28, date("1997-09-01")),
            (.Day, -32, date("1999-11-30"))
        ]
        
        for (size, amount, expectedDate) in testCases {
            self.testTimePeriodStartingAtWithSize(size, amount: amount, expectedEndDate: expectedDate)
        }
    }
    
    //MARK: - create with ending date
    
    func testTimePeriod_createPeriodsWithEndingDate_returnsValidTimePeriods() {
        let testCases: [(TimePeriodSize, Int, NSDate)] = [
            (.Day, 1, date("1900-06-14")),
            (.Month, 1, date("1900-05-15")),
            (.Year, 1, date("1899-06-15")),
            (.Day, 5, date("1900-06-10")),
            (.Month, 5, date("1900-01-15")),
            (.Year, 5, date("1895-06-15")),
            (.Day, 50, date("1900-04-26")),
            (.Month, 14, date("1899-04-15")),
            (.Day, -14, date("1900-06-29")),
            (.Month, -14, date("1901-08-15"))
        ]
        
        for (size, amount, expectedDate) in testCases {
            self.testTimePeriodEndingAtWithSize(size, amount: amount, expectedStartDate: expectedDate)
        }
    }
    
    func testTimePeriod_createPeriodWithAllTime_returnsPeriodWithDistantPastAndFuture() {
        let period = TimePeriod.timePeriodWithAllTime()
        expect(period.startDate) == NSDate.distantPast()
        expect(period.endDate) == NSDate.distantFuture()
    }
    
    func testTimePeriod_copyPeriod_returnsCopiedPeriodWithSameDateRange() {
        let period = self.longPeriod.copy() as! TimePeriod
        expect(period.startDate) == self.longPeriod.startDate
        expect(period.endDate) == self.longPeriod.endDate
        expect(period.calendar) == self.longPeriod.calendar
    }
    
    //MARK: - Duration in ... tests
    
    func testTimePeriod_durationInYears_returnsValidAmountOfYearsInPeriod() {
        expect(self.longPeriod.durationIn(.Year)) == 99
        expect(self.shortPeriod.durationIn(.Year)) == 0
        expect(self.veryShortPeriod.durationIn(.Year)) == 0
    }
    
    func testTimePeriod_durationInMonths_returnsValidAmountOfMonhtsInPeriod() {
        expect(self.longPeriod.durationIn(.Month)) == 1194
        expect(self.shortPeriod.durationIn(.Month)) == 2
        expect(self.veryShortPeriod.durationIn(.Month)) == 0
    }
    
    func testTimePeriod_durationInWeeks_returnsValidAmountOfWeeksInPeriod() {
        expect(self.longPeriod.durationIn(.Week)) == 5194
        expect(self.shortPeriod.durationIn(.Week)) == 10
        expect(self.veryShortPeriod.durationIn(.Week)) == 0
    }

    func testTimePeriod_durationInDays_returnsValidAmountOfDaysInPeriod() {
        expect(self.longPeriod.durationIn(.Day)) == 36359
        expect(self.shortPeriod.durationIn(.Day)) == 73
        expect(self.veryShortPeriod.durationIn(.Day)) == 1
    }
    
    func testTimePeriod_durationInHours_returnsValidAmountOfHoursInPeriod() {
        expect(self.veryShortPeriod.durationIn(.Hour)) == 36
    }
    
    func testTimePeriod_durationInMinutes_returnsValidAmountOfMinutesInPeriod() {
        expect(self.veryShortPeriod.durationIn(.Minute)) == 2180
    }
    
    func testTimePeriod_durationInSeconds_returnsValidAmountOfSecondsInPeriod() {
        expect(self.veryShortPeriod.durationIn(.Second)) == 130830
    }
    
    //MARK: - Period comparison tests
    
    func testTimePeriod_isMoment_returnsTrueIfStartDateIsEqualEndDate() {
        let period = TimePeriod(startDate: date("2000-01-01"), endDate: date("2000-01-01"), calendar: calendar)
        expect(period.isMoment()) == true
        expect(self.longPeriod.isMoment()) == false
    }
    
    func testTimePeriod_isEqualToPeriod_returnsFalseForDifferentTimePeriods() {
        expect(self.veryShortPeriod.isEqualToPeriod(self.shortPeriod)) == false
        expect(self.veryShortPeriod == self.shortPeriod) == false
    }
    
    func testTimePeriod_isEqualToPeriod_returnsTrueForSameTimePeriods() {
        expect(self.longPeriod.isEqualToPeriod(TimePeriod(startDate: self.endDate, endDate: self.startDate, calendar: self.calendar))) == true
        expect(self.longPeriod == TimePeriod(startDate: self.endDate, endDate: self.startDate, calendar: self.calendar)) == true
    }
    
    func testTimePeriod_isInside_returnsFalseForTimePeriodThatIsNotInsideOfAnotherTimePeriod() {
        expect(self.periodBeforeOverlaps.isInside(self.longPeriod)) == false
        expect(self.periodAfterOverlaps.isInside(self.longPeriod)) == false
    }
    
    func testTimePeriod_isInside_returnsTrueForTimePeriodInsideOrEqual() {
        expect(self.periodInside.isInside(self.longPeriod)) == true
        expect(self.longPeriod.isInside(self.longPeriod)) == true
        expect(self.shortPeriod.isInside(self.shortPeriod)) == true
        expect(self.veryShortPeriod.isInside(self.veryShortPeriod)) == true
    }
    
    func testTimePeriod_contains_returnsFalseForTimePeriodNotContainingOther() {
        expect(self.longPeriod.contains(self.periodBeforeOverlaps)) == false
        expect(self.longPeriod.contains(self.periodAfterOverlaps)) == false
    }
    
    func testTimePeriod_contains_returnsTrueForTimePeriodContainingOther() {
        expect(self.longPeriod.contains(self.periodInside)) == true
        expect(self.longPeriod.contains(self.longPeriod)) == true
        expect(self.shortPeriod.contains(self.shortPeriod)) == true
        expect(self.veryShortPeriod.contains(self.veryShortPeriod)) == true
    }
    
    func testTimePeriod_overlapsWith_returnsTrueIfPeriodsOverlapEachother() {
        expect(self.periodBeforeOverlaps.overlapsWith(self.longPeriod)) == true
        expect(self.periodAfterOverlaps.overlapsWith(self.longPeriod)) == true
        expect(self.periodInside.overlapsWith(self.longPeriod)) == true
        
        expect(self.longPeriod.overlapsWith(self.periodBeforeOverlaps)) == true
        expect(self.longPeriod.overlapsWith(self.periodAfterOverlaps)) == true
        expect(self.longPeriod.overlapsWith(self.periodInside)) == true
    }
    
    func testTimePeriod_overlapsWith_returnsFalseIfPeriodsDoesNotOverlap() {
        expect(self.periodBefore.overlapsWith(self.longPeriod)) == false
        expect(self.periodAfter.overlapsWith(self.longPeriod)) == false
        expect(self.periodBeforeTouching.overlapsWith(self.longPeriod)) == false
        expect(self.periodAfterTouching.overlapsWith(self.longPeriod)) == false
        
        expect(self.longPeriod.overlapsWith(self.periodAfter)) == false
        expect(self.longPeriod.overlapsWith(self.periodBefore)) == false
    }
    
    func testTimePeriod_intersects_returnsFalseIfPeriodsDoesNotIntersect() {
        expect(self.periodBefore.intersects(self.longPeriod)) == false
        expect(self.periodAfter.intersects(self.longPeriod)) == false
        
        expect(self.longPeriod.intersects(self.periodAfter)) == false
        expect(self.longPeriod.intersects(self.periodBefore)) == false
    }
    
    func testTimePeriod_intersects_returnsTrueIfPeriodsIntersect() {
        expect(self.periodBeforeOverlaps.intersects(self.longPeriod)) == true
        expect(self.periodAfterOverlaps.intersects(self.longPeriod)) == true
        expect(self.periodInside.intersects(self.longPeriod)) == true
        expect(self.periodBeforeTouching.intersects(self.longPeriod)) == true
        expect(self.periodAfterTouching.intersects(self.longPeriod)) == true
        
        expect(self.longPeriod.intersects(self.periodBeforeOverlaps)) == true
        expect(self.longPeriod.intersects(self.periodAfterOverlaps)) == true
        expect(self.longPeriod.intersects(self.periodInside)) == true
    }
    
    //MARK: - other utility methods tests
    
    func testTimePeriod_gapBetween_returnsGapInSecondsBetweenTwoTimePeriods() {
        expect(self.longPeriod.gapBetween(self.periodInside)) == 0
        expect(self.longPeriod.gapBetween(self.periodAfter)) == Double(SECONDS_IN_DAY)
        expect(self.longPeriod.gapBetween(self.periodBefore)) == Double(SECONDS_IN_DAY)
    }
    
    func testTimePeriod_containsDate_returnsTrueIfPeriodContainsDate() {
        expect(self.longPeriod.containsDate(self.calendar.dateWithYear(1950), interval: TimePeriodInterval.Open)) == true
        expect(self.longPeriod.containsDate(self.calendar.dateWithYear(2000), interval: TimePeriodInterval.Open)) == false
        expect(self.longPeriod.containsDate(self.calendar.dateWithYear(2050), interval: TimePeriodInterval.Open)) == false
        expect(self.longPeriod.containsDate(self.calendar.dateWithYear(2000), interval: TimePeriodInterval.Closed)) == true
    }
    
    func testCalendarExtension_isLeapYear_returnsWhetherYearIsLeap() {
        expect(NSCalendar.isLeapYear(2000)) == true
        expect(NSCalendar.isLeapYear(2001)) == false
        expect(NSCalendar.isLeapYear(2100)) == false
        expect(NSCalendar.isLeapYear(2004)) == true
    }
    
    
    //MARK: - Helpers
    
    func testTimePeriodStartingAtWithSize(size: TimePeriodSize, amount: Int, expectedEndDate: NSDate) {
        let period = TimePeriod(size: size, amount: amount, startingAt: startDate, calendar: calendar)
        
        expect(period.startDate) == startDate
        expect(period.endDate) == expectedEndDate
    }
    
    func testTimePeriodEndingAtWithSize(size: TimePeriodSize, amount: Int, expectedStartDate: NSDate) {
        let period = TimePeriod(size: size, amount: amount, endingAt: endDate, calendar: calendar)
        
        expect(period.startDate) == expectedStartDate
        expect(period.endDate) == endDate
    }
    
    
    
}

