//
//  TimePeriodTests+DateShifting.swift
//  DateTools
//
//  Created by Paweł Sękara on 23.09.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import Foundation
import XCTest
import Nimble
@testable import DateTools

extension TimePeriodTests {
    
    //MARK: - Date shifting methods
    
    func testTimePeriod_shiftEarlier_shiftsPeriodEarlier() {
        self.testShiftEarlier(shortPeriod, .Second, 3, date("1999-12-31 23:59:57"))
        self.testShiftEarlier(shortPeriod, .Minute, 73, date("1999-12-31 22:47"))
        self.testShiftEarlier(shortPeriod, .Hour, 122, date("1999-12-26 22"))
        self.testShiftEarlier(shortPeriod, .Day, 44, date("1999-11-18"))
        self.testShiftEarlier(shortPeriod, .Week, 1, date("1999-12-25"))
        self.testShiftEarlier(shortPeriod, .Month, 8, date("1999-05-01"))
        self.testShiftEarlier(shortPeriod, .Year, 1, date("1999-01-01"))
    }
    
    func testTimePeriod_shiftEarlierByNegativeAmount_shiftsPeriodLater() {
        self.testShiftEarlier(shortPeriod, .Second, -12, date("2000-01-01 00:00:12"))
        self.testShiftEarlier(shortPeriod, .Minute, -39, date("2000-01-01 00:39"))
        self.testShiftEarlier(shortPeriod, .Hour, -31, date("2000-01-02 07"))
        self.testShiftEarlier(shortPeriod, .Day, -43, date("2000-02-13"))
        self.testShiftEarlier(shortPeriod, .Week, -2, date("2000-01-15"))
        self.testShiftEarlier(shortPeriod, .Month, -14, date("2001-03-01"))
        self.testShiftEarlier(shortPeriod, .Year, -1, calendar.dateWithYear(2001))
    }
    
    func testTimePeriod_shiftLater_shiftsPeriodLater() {
        self.testShiftLater(shortPeriod, .Second, 12, date("2000-01-01 00:00:12"))
        self.testShiftLater(shortPeriod, .Minute, 39, date("2000-01-01 00:39"))
        self.testShiftLater(shortPeriod, .Hour, 31, date("2000-01-02 07"))
        self.testShiftLater(shortPeriod, .Day, 43, date("2000-02-13"))
        self.testShiftLater(shortPeriod, .Week, 2, date("2000-01-15"))
        self.testShiftLater(shortPeriod, .Month, 14, date("2001-03-01"))
        self.testShiftLater(shortPeriod, .Year, 1, calendar.dateWithYear(2001))
    }
    
    func testTimePeriod_shiftLaterByNegativeAmount_shiftsPeriodEarlier() {
        self.testShiftLater(shortPeriod, .Second, -3, date("1999-12-31 23:59:57"))
        self.testShiftLater(shortPeriod, .Minute, -73, date("1999-12-31 22:47"))
        self.testShiftLater(shortPeriod, .Hour, -122, date("1999-12-26 22"))
        self.testShiftLater(shortPeriod, .Day, -44, date("1999-11-18"))
        self.testShiftLater(shortPeriod, .Week, -1, date("1999-12-25"))
        self.testShiftLater(shortPeriod, .Month, -8, date("1999-05-01"))
        self.testShiftLater(shortPeriod, .Year, -1, date("1999-01-01"))
    }
    
    //MARK: - Previous and next methods
    
    func testTimePeriod_previous_returnsPreviousTimePeriod() {
        self.testPrevious(shortPeriod, .Second, date("1999-10-20"))
        self.testPrevious(shortPeriod, .Minute, date("1999-10-20"))
        self.testPrevious(shortPeriod, .Hour, date("1999-10-20"))
        self.testPrevious(shortPeriod, .Day, date("1999-10-20"))
        self.testPrevious(shortPeriod, .Week, date("1999-10-23"))
        self.testPrevious(shortPeriod, .Month, date("1999-11-01"))
        self.testPrevious(shortPeriod, .Year, date("2000-01-01"))
    }
    
    func testTimePeriod_next_returnsNextTimePeriod() {
        self.testNext(shortPeriod, .Second, date("2000-05-26"))
        self.testNext(shortPeriod, .Minute, date("2000-05-26"))
        self.testNext(shortPeriod, .Hour, date("2000-05-26"))
        self.testNext(shortPeriod, .Day, date("2000-05-26"))
        self.testNext(shortPeriod, .Week, date("2000-05-23"))
        self.testNext(shortPeriod, .Month, date("2000-05-14"))
        self.testNext(shortPeriod, .Year, date("2000-03-14"))
    }
    
    //MARK: - lengthen with anchor Start
    
    func testTimePeriod_lengthenWithStartAnchorBySeconds_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Second, amount: 39)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-03-14 00:00:39")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByMinutes_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Minute, amount: 41)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-03-14 00:41")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByHours_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Hour, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-03-14 05")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByDays_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Day, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-03-19")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByWeeks_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-03-28")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByMonths_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-07-14")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByYears_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Year, amount: 7)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2007-03-14")
    }
    
    //MARK: lengthen with anchor Center

    func testTimePeriod_lengthenWithCenterAnchorBySeconds_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Second, amount: 40)
        expect(self.shortPeriod.startDate) == date("1999-12-31 23:59:40")
        expect(self.shortPeriod.endDate)   == date("2000-03-14 00:00:20")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByMinutes_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Minute, amount: 30)
        expect(self.shortPeriod.startDate) == date("1999-12-31 23:45")
        expect(self.shortPeriod.endDate)   == date("2000-03-14 00:15")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByHours_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Hour, amount: 6)
        expect(self.shortPeriod.startDate) == date("1999-12-31 21")
        expect(self.shortPeriod.endDate)   == date("2000-03-14 03")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByDays_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Day, amount: 4)
        expect(self.shortPeriod.startDate) == date("1999-12-30")
        expect(self.shortPeriod.endDate)   == date("2000-03-16")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByWeeks_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == date("1999-12-25")
        expect(self.shortPeriod.endDate)   == date("2000-03-21")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByMonths_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == date("1999-11-01")
        expect(self.shortPeriod.endDate)   == date("2000-05-14")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByYears_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Year, amount: 8)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1996)
        expect(self.shortPeriod.endDate)   == date("2004-03-14")
    }

    //MARK: lengthen with anchor end
    
    func testTimePeriod_lengthenWithEndAnchorBySeconds_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Second, amount: 40)
        expect(self.shortPeriod.startDate) == date("1999-12-31 23:59:20")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByMinutes_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Minute, amount: 30)
        expect(self.shortPeriod.startDate) == date("1999-12-31 23:30:00")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByHours_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Hour, amount: 6)
        expect(self.shortPeriod.startDate) == date("1999-12-31 18")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByDays_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Day, amount: 4)
        expect(self.shortPeriod.startDate) == date("1999-12-28")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByWeeks_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == date("1999-12-18")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByMonths_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == date("1999-09-01")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByYears_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Year, amount: 8)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1992)
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    //MARK: - shorten with anchor start
    
    func testTimePeriod_shortenWithStartAnchorBySeconds_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Second, amount: 39)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-03-13 23:59:21")
    }
    
    func testTimePeriod_shortenWithStartAnchorByMinutes_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Minute, amount: 41)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-03-13 23:19")
    }
    
    func testTimePeriod_shortenWithStartAnchorByHours_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Hour, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-03-13 19")
    }
    
    func testTimePeriod_shortenWithStartAnchorByDays_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Day, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-03-09")
    }
    
    func testTimePeriod_shortenWithStartAnchorByWeeks_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("2000-02-29")
    }
    
    func testTimePeriod_shortenWithStartAnchorByMonths_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("1999-11-14")
    }
    
    func testTimePeriod_shortenWithStartAnchorByYears_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Year, amount: 7)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date("1993-03-14")
    }
    
    //MARK: shorten with anchor center
    
    func testTimePeriod_shortenWithCenterAnchorBySeconds_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Second, amount: 40)
        expect(self.shortPeriod.startDate) == date("2000-01-01 00:00:20")
        expect(self.shortPeriod.endDate)   == date("2000-03-13 23:59:40")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByMinutes_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Minute, amount: 30)
        expect(self.shortPeriod.startDate) == date("2000-01-01 00:15")
        expect(self.shortPeriod.endDate)   == date("2000-03-13 23:45")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByHours_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Hour, amount: 6)
        expect(self.shortPeriod.startDate) == date("2000-01-01 03")
        expect(self.shortPeriod.endDate)   == date("2000-03-13 21")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByDays_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Day, amount: 4)
        expect(self.shortPeriod.startDate) == date("2000-01-03")
        expect(self.shortPeriod.endDate)   == date("2000-03-12")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByWeeks_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == date("2000-01-08")
        expect(self.shortPeriod.endDate)   == date("2000-03-07")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByMonths_shortensPeriodByGivenSize() {
        self.longPeriod.shortenWithAnchorDate(.Center, size: .Month, amount: 4)
        expect(self.longPeriod.startDate) == date("1900-08-15")
        expect(self.longPeriod.endDate)   == date("1999-11-01")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByYears_shortensPeriodByGivenSize() {
        self.longPeriod.shortenWithAnchorDate(.Center, size: .Year, amount: 8)
        expect(self.longPeriod.startDate) == date("1904-06-15")
        expect(self.longPeriod.endDate)   == date("1996-01-01")
    }
    
    //MARK: shorten with anchor end
    
    func testTimePeriod_shortenWithEndAnchorBySeconds_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Second, amount: 40)
        expect(self.shortPeriod.startDate) == date("2000-01-01 00:00:40")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByMinutes_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Minute, amount: 30)
        expect(self.shortPeriod.startDate) == date("2000-01-01 00:30")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByHours_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Hour, amount: 6)
        expect(self.shortPeriod.startDate) == date("2000-01-01 06")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByDays_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Day, amount: 4)
        expect(self.shortPeriod.startDate) == date("2000-01-05")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByWeeks_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == date("2000-01-15")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByMonths_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == date("2000-05-01")
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByYears_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Year, amount: 8)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2008)
        expect(self.shortPeriod.endDate)   == date("2000-03-14")
    }
    
    //MARK: - Helpers
    
    func testPrevious(period: TimePeriod, _ size: TimePeriodSize, _ expectedDate: NSDate) {
        let previous = period.previous(size)
        expect(previous) !== period
        expect(previous.endDate) == period.startDate
        expect(previous.startDate) == expectedDate
    }
    
    func testNext(period: TimePeriod, _ size: TimePeriodSize, _ expectedDate: NSDate) {
        let next = period.next(size)
        expect(next) !== period
        expect(next.startDate) == period.endDate
        expect(next.endDate) == expectedDate
    }
    
    func testShiftEarlier(var period: TimePeriod, _ size: TimePeriodSize, _ amount: Int, _ startDate: NSDate) {
        period = period.copy() as! TimePeriod
        period.shiftEarlierWithSize(size, amount: amount)
        expect(period.startDate) == startDate
    }
    
    func testShiftLater(var period: TimePeriod, _ size: TimePeriodSize, _ amount: Int, _ startDate: NSDate) {
        period = period.copy() as! TimePeriod
        period.shiftLaterWithSize(size, amount: amount)
        expect(period.startDate) == startDate
    }
    
    
}

