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
    
    var startDate: Date!
    var endDate: Date!
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

    
    var calendar: Calendar!
    
    override func setUp() {
        super.setUp()
        calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        startDate = calendar.date(year: 2000, month: 01, day: 01)
        endDate = calendar.date(year: 1900, month: 06, day: 15)
        longPeriod = TimePeriod(startDate: endDate, endDate: startDate, calendar: calendar)
        shortPeriod = TimePeriod(startDate: startDate, endDate: date(dateString: "2000-03-14"), calendar: calendar)
        veryShortPeriod = TimePeriod(startDate: startDate, endDate: date(dateString: "2000-01-02 12:20:30"), calendar: calendar)
        periodBeforeOverlaps = TimePeriod(startDate: date(dateString: "1890-01-01"), endDate: date(dateString: "1960-01-01"), calendar: calendar)
        periodAfterOverlaps = TimePeriod(startDate: date(dateString: "1950-01-01"), endDate: date(dateString: "2010-01-01"), calendar: calendar)
        periodBefore = TimePeriod(startDate: date(dateString: "1890-01-01"), endDate: date(dateString: "1900-06-14"), calendar: calendar)
        periodAfter = TimePeriod(startDate: date(dateString: "2000-01-02"), endDate: date(dateString: "2010-01-01"), calendar: calendar)
        periodInside = TimePeriod(startDate: date(dateString: "1950-01-01"), endDate: date(dateString: "1960-01-01"), calendar: calendar)
        periodBeforeTouching = TimePeriod(startDate: date(dateString: "1890-01-01"), endDate: date(dateString: "1900-06-15"), calendar: calendar)
        periodAfterTouching = TimePeriod(startDate: date(dateString: "2000-01-01"), endDate: date(dateString: "2010-01-01"), calendar: calendar)

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
    
    // MARK: - Testing creation with start date
    func testTimePeriod_createPeriodsWithStartingDate_returnsValidTimePeriods() {
        let testCases: [(TimePeriodSize, Int, Date)] = [
            (.day, 1, date(dateString: "2000-01-02")),
            (.month, 1, date(dateString: "2000-02-01")),
            (.year, 1, date(dateString: "2001-01-01")),
            (.day, 5, date(dateString: "2000-01-06")),
            (.month, 5, date(dateString: "2000-06-01")),
            (.year, 5, date(dateString: "2005-01-01")),
            (.day, 50, date(dateString: "2000-02-20")),
            (.month, 14, date(dateString: "2001-03-01")),
            (.day, -10, date(dateString: "1999-12-22")),
            (.month, -28, date(dateString: "1997-09-01")),
            (.day, -32, date(dateString: "1999-11-30"))
        ]
        
        for (size, amount, expectedDate) in testCases {
            self.testTimePeriodStartingAtWithSize(size: size, amount: amount, expectedEndDate: expectedDate)
        }
    }
    
    // MARK: - Testing creation with end date
    func testTimePeriod_createPeriodsWithEndingDate_returnsValidTimePeriods() {
        let testCases: [(TimePeriodSize, Int, Date)] = [
            (.day, 1, date(dateString: "1900-06-14")),
            (.month, 1, date(dateString: "1900-05-15")),
            (.year, 1, date(dateString: "1899-06-15")),
            (.day, 5, date(dateString: "1900-06-10")),
            (.month, 5, date(dateString: "1900-01-15")),
            (.year, 5, date(dateString: "1895-06-15")),
            (.day, 50, date(dateString: "1900-04-26")),
            (.month, 14, date(dateString: "1899-04-15")),
            (.day, -14, date(dateString: "1900-06-29")),
            (.month, -14, date(dateString: "1901-08-15"))
        ]
        
        for (size, amount, expectedDate) in testCases {
            self.testTimePeriodEndingAtWithSize(size: size, amount: amount, expectedStartDate: expectedDate)
        }
    }
    
    func testTimePeriod_createPeriodWithAllTime_returnsPeriodWithDistantPastAndFuture() {
        let period = TimePeriod.timePeriodWithAllTime()
        expect(period.startDate) == Date.distantPast
        expect(period.endDate) == Date.distantFuture
    }
    
    func testTimePeriod_copyPeriod_returnsCopiedPeriodWithSameDateRange() {
        let period = self.longPeriod.copy()
        expect(period.startDate) == self.longPeriod.startDate
        expect(period.endDate) == self.longPeriod.endDate
        expect(period.calendar) == self.longPeriod.calendar
    }
    
    // MARK: - Testing duration in unit methods
    func testTimePeriod_durationInYears_returnsValidAmountOfYearsInPeriod() {
        expect(self.longPeriod.durationIn(size: .year)) == 99
        expect(self.shortPeriod.durationIn(size: .year)) == 0
        expect(self.veryShortPeriod.durationIn(size: .year)) == 0
    }
    
    func testTimePeriod_durationInMonths_returnsValidAmountOfMonhtsInPeriod() {
        expect(self.longPeriod.durationIn(size: .month)) == 1194
        expect(self.shortPeriod.durationIn(size: .month)) == 2
        expect(self.veryShortPeriod.durationIn(size: .month)) == 0
    }
    
    func testTimePeriod_durationInWeeks_returnsValidAmountOfWeeksInPeriod() {
        expect(self.longPeriod.durationIn(size: .week)) == 5194
        expect(self.shortPeriod.durationIn(size: .week)) == 10
        expect(self.veryShortPeriod.durationIn(size: .week)) == 0
    }

    func testTimePeriod_durationInDays_returnsValidAmountOfDaysInPeriod() {
        expect(self.longPeriod.durationIn(size: .day)) == 36359
        expect(self.shortPeriod.durationIn(size: .day)) == 73
        expect(self.veryShortPeriod.durationIn(size: .day)) == 1
    }
    
    func testTimePeriod_durationInHours_returnsValidAmountOfHoursInPeriod() {
        expect(self.veryShortPeriod.durationIn(size: .hour)) == 36
    }
    
    func testTimePeriod_durationInMinutes_returnsValidAmountOfMinutesInPeriod() {
        expect(self.veryShortPeriod.durationIn(size: .minute)) == 2180
    }
    
    func testTimePeriod_durationInSeconds_returnsValidAmountOfSecondsInPeriod() {
        expect(self.veryShortPeriod.durationIn(size: .second)) == 130830
    }
    
    // MARK: - Testing time period comparisons
    func testTimePeriod_isMoment_returnsTrueIfStartDateIsEqualEndDate() {
        let period = TimePeriod(startDate: date(dateString: "2000-01-01"), endDate: date(dateString: "2000-01-01"), calendar: calendar)
        expect(period.isMoment()) == true
        expect(self.longPeriod.isMoment()) == false
    }
    
    func testTimePeriod_isEqualToPeriod_returnsFalseForDifferentTimePeriods() {
        expect(self.veryShortPeriod.equals(self.shortPeriod)) == false
        expect(self.veryShortPeriod == self.shortPeriod) == false
    }
    
    func testTimePeriod_isEqualToPeriod_returnsTrueForSameTimePeriods() {
        expect(self.longPeriod.equals(TimePeriod(startDate: self.endDate, endDate: self.startDate, calendar: self.calendar))) == true
        expect(self.longPeriod == TimePeriod(startDate: self.endDate, endDate: self.startDate, calendar: self.calendar)) == true
    }
    
    func testTimePeriod_isInside_returnsFalseForTimePeriodThatIsNotInsideOfAnotherTimePeriod() {
        expect(self.periodBeforeOverlaps.isInside(period: self.longPeriod)) == false
        expect(self.periodAfterOverlaps.isInside(period: self.longPeriod)) == false
    }
    
    func testTimePeriod_isInside_returnsTrueForTimePeriodInsideOrEqual() {
        expect(self.periodInside.isInside(period: self.longPeriod)) == true
        expect(self.longPeriod.isInside(period: self.longPeriod)) == true
        expect(self.shortPeriod.isInside(period: self.shortPeriod)) == true
        expect(self.veryShortPeriod.isInside(period: self.veryShortPeriod)) == true
    }
    
    func testTimePeriod_contains_returnsFalseForTimePeriodNotContainingOther() {
        expect(self.longPeriod.contains(period: self.periodBeforeOverlaps)) == false
        expect(self.longPeriod.contains(period: self.periodAfterOverlaps)) == false
    }
    
    func testTimePeriod_contains_returnsTrueForTimePeriodContainingOther() {
        expect(self.longPeriod.contains(period: self.periodInside)) == true
        expect(self.longPeriod.contains(period: self.longPeriod)) == true
        expect(self.shortPeriod.contains(period: self.shortPeriod)) == true
        expect(self.veryShortPeriod.contains(period: self.veryShortPeriod)) == true
    }
    
    func testTimePeriod_overlapsWith_returnsTrueIfPeriodsOverlapEachother() {
        expect(self.periodBeforeOverlaps.overlapsWith(period: self.longPeriod)) == true
        expect(self.periodAfterOverlaps.overlapsWith(period: self.longPeriod)) == true
        expect(self.periodInside.overlapsWith(period: self.longPeriod)) == true
        
        expect(self.longPeriod.overlapsWith(period: self.periodBeforeOverlaps)) == true
        expect(self.longPeriod.overlapsWith(period: self.periodAfterOverlaps)) == true
        expect(self.longPeriod.overlapsWith(period: self.periodInside)) == true
    }
    
    func testTimePeriod_overlapsWith_returnsFalseIfPeriodsDoesNotOverlap() {
        expect(self.periodBefore.overlapsWith(period: self.longPeriod)) == false
        expect(self.periodAfter.overlapsWith(period: self.longPeriod)) == false
        expect(self.periodBeforeTouching.overlapsWith(period: self.longPeriod)) == false
        expect(self.periodAfterTouching.overlapsWith(period: self.longPeriod)) == false
        
        expect(self.longPeriod.overlapsWith(period: self.periodAfter)) == false
        expect(self.longPeriod.overlapsWith(period: self.periodBefore)) == false
    }
    
    func testTimePeriod_intersects_returnsFalseIfPeriodsDoesNotIntersect() {
        expect(self.periodBefore.intersects(period: self.longPeriod)) == false
        expect(self.periodAfter.intersects(period: self.longPeriod)) == false
        
        expect(self.longPeriod.intersects(period: self.periodAfter)) == false
        expect(self.longPeriod.intersects(period: self.periodBefore)) == false
    }
    
    func testTimePeriod_intersects_returnsTrueIfPeriodsIntersect() {
        expect(self.periodBeforeOverlaps.intersects(period: self.longPeriod)) == true
        expect(self.periodAfterOverlaps.intersects(period: self.longPeriod)) == true
        expect(self.periodInside.intersects(period: self.longPeriod)) == true
        expect(self.periodBeforeTouching.intersects(period: self.longPeriod)) == true
        expect(self.periodAfterTouching.intersects(period: self.longPeriod)) == true
        
        expect(self.longPeriod.intersects(period: self.periodBeforeOverlaps)) == true
        expect(self.longPeriod.intersects(period: self.periodAfterOverlaps)) == true
        expect(self.longPeriod.intersects(period: self.periodInside)) == true
    }
    
    // MARK: - Testing utility methods
    func testTimePeriod_gapBetween_returnsGapInSecondsBetweenTwoTimePeriods() {
        expect(self.longPeriod.gapBetween(period: self.periodInside)) == 0
        expect(self.longPeriod.gapBetween(period: self.periodAfter)) == Double(SecondsIn.day.rawValue)
        expect(self.longPeriod.gapBetween(period: self.periodBefore)) == Double(SecondsIn.day.rawValue)
    }
    
    func testTimePeriod_containsDate_returnsTrueIfPeriodContainsDate() {
        expect(self.longPeriod.contains(date: self.calendar.date(year: 1950), interval: TimePeriodInterval.open)) == true
        expect(self.longPeriod.contains(date: self.calendar.date(year: 2000), interval: TimePeriodInterval.open)) == false
        expect(self.longPeriod.contains(date: self.calendar.date(year: 2050), interval: TimePeriodInterval.open)) == false
        expect(self.longPeriod.contains(date: self.calendar.date(year: 2000), interval: TimePeriodInterval.closed)) == true
    }
    
    func testCalendarExtension_isLeapYear_returnsWhetherYearIsLeap() {
        expect(Calendar.isLeapYear(year: 2000)) == true
        expect(Calendar.isLeapYear(year: 2001)) == false
        expect(Calendar.isLeapYear(year: 2100)) == false
        expect(Calendar.isLeapYear(year: 2004)) == true
    }
    
    // MARK: - Helper methods
    func testTimePeriodStartingAtWithSize(size: TimePeriodSize, amount: Int, expectedEndDate: Date) {
        let period = TimePeriod(size: size, amount: amount, startingAt: startDate, calendar: calendar)
        
        expect(period.startDate) == startDate
        expect(period.endDate) == expectedEndDate
    }
    
    func testTimePeriodEndingAtWithSize(size: TimePeriodSize, amount: Int, expectedStartDate: Date) {
        let period = TimePeriod(size: size, amount: amount, endingAt: endDate, calendar: calendar)
        
        expect(period.startDate) == expectedStartDate
        expect(period.endDate) == endDate
    }
    
    
    
}

