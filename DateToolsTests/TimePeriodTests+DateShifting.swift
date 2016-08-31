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
    
    // MARK: - Testing date shifting methods
    func testTimePeriod_shiftEarlier_shiftsPeriodEarlier() {
        self.testShiftEarlier(period: shortPeriod, size: .second, amount: 3, startDate: date(dateString: "1999-12-31 23:59:57"))
        self.testShiftEarlier(period: shortPeriod, size: .minute, amount: 73, startDate: date(dateString: "1999-12-31 22:47"))
        self.testShiftEarlier(period: shortPeriod, size: .hour, amount: 122, startDate: date(dateString: "1999-12-26 22"))
        self.testShiftEarlier(period: shortPeriod, size: .day, amount: 44, startDate: date(dateString: "1999-11-18"))
        self.testShiftEarlier(period: shortPeriod, size: .week, amount: 1, startDate: date(dateString: "1999-12-25"))
        self.testShiftEarlier(period: shortPeriod, size: .month, amount: 8, startDate: date(dateString: "1999-05-01"))
        self.testShiftEarlier(period: shortPeriod, size: .year, amount: 1, startDate: date(dateString: "1999-01-01"))
    }
    
    func testTimePeriod_shiftEarlierByNegativeAmount_shiftsPeriodLater() {
        self.testShiftEarlier(period: shortPeriod, size: .second, amount: -12, startDate: date(dateString: "2000-01-01 00:00:12"))
        self.testShiftEarlier(period: shortPeriod, size: .minute, amount: -39, startDate: date(dateString: "2000-01-01 00:39"))
        self.testShiftEarlier(period: shortPeriod, size: .hour, amount: -31, startDate: date(dateString: "2000-01-02 07"))
        self.testShiftEarlier(period: shortPeriod, size: .day, amount: -43, startDate: date(dateString: "2000-02-13"))
        self.testShiftEarlier(period: shortPeriod, size: .week, amount: -2, startDate: date(dateString: "2000-01-15"))
        self.testShiftEarlier(period: shortPeriod, size: .month, amount: -14, startDate: date(dateString: "2001-03-01"))
        self.testShiftEarlier(period: shortPeriod, size: .year, amount: -1, startDate: calendar.date(year: 2001))
    }
    
    func testTimePeriod_shiftLater_shiftsPeriodLater() {
        self.testShiftLater(period: shortPeriod, size: .second, amount: 12, startDate: date(dateString: "2000-01-01 00:00:12"))
        self.testShiftLater(period: shortPeriod, size: .minute, amount: 39, startDate: date(dateString: "2000-01-01 00:39"))
        self.testShiftLater(period: shortPeriod, size: .hour, amount: 31, startDate: date(dateString: "2000-01-02 07"))
        self.testShiftLater(period: shortPeriod, size: .day, amount: 43, startDate: date(dateString: "2000-02-13"))
        self.testShiftLater(period: shortPeriod, size: .week, amount: 2, startDate: date(dateString: "2000-01-15"))
        self.testShiftLater(period: shortPeriod, size: .month, amount: 14, startDate: date(dateString: "2001-03-01"))
        self.testShiftLater(period: shortPeriod, size: .year, amount: 1, startDate: calendar.date(year: 2001))
    }
    
    func testTimePeriod_shiftLaterByNegativeAmount_shiftsPeriodEarlier() {
        self.testShiftLater(period: shortPeriod, size: .second, amount: -3, startDate: date(dateString: "1999-12-31 23:59:57"))
        self.testShiftLater(period: shortPeriod, size: .minute, amount: -73, startDate: date(dateString: "1999-12-31 22:47"))
        self.testShiftLater(period: shortPeriod, size: .hour, amount: -122, startDate: date(dateString: "1999-12-26 22"))
        self.testShiftLater(period: shortPeriod, size: .day, amount: -44, startDate: date(dateString: "1999-11-18"))
        self.testShiftLater(period: shortPeriod, size: .week, amount: -1, startDate: date(dateString: "1999-12-25"))
        self.testShiftLater(period: shortPeriod, size: .month, amount: -8, startDate: date(dateString: "1999-05-01"))
        self.testShiftLater(period: shortPeriod, size: .year, amount: -1, startDate: date(dateString: "1999-01-01"))
    }
    
    // MARK: - Testing lengthen with start anchor
    func testTimePeriod_lengthenWithStartAnchorBySeconds_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .start, size: .second, amount: 39)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14 00:00:39")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByMinutes_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .start, size: .minute, amount: 41)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14 00:41")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByHours_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .start, size: .hour, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14 05")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByDays_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .start, size: .day, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-19")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByWeeks_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .start, size: .week, amount: 2)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-28")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByMonths_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .start, size: .month, amount: 4)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-07-14")
    }
    
    func testTimePeriod_lengthenWithStartAnchorByYears_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .start, size: .year, amount: 7)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2007-03-14")
    }
    
    // MARK: - Testing lengthen with center anchor
    func testTimePeriod_lengthenWithCenterAnchorBySeconds_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .center, size: .second, amount: 40)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-31 23:59:40")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14 00:00:20")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByMinutes_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .center, size: .minute, amount: 30)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-31 23:45")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14 00:15")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByHours_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .center, size: .hour, amount: 6)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-31 21")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14 03")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByDays_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .center, size: .day, amount: 4)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-30")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-16")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByWeeks_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .center, size: .week, amount: 2)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-25")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-21")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByMonths_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .center, size: .month, amount: 4)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-11-01")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-05-14")
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByYears_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .center, size: .year, amount: 8)
        expect(self.shortPeriod.startDate) == calendar.date(year: 1996)
        expect(self.shortPeriod.endDate)   == date(dateString: "2004-03-14")
    }

    // MARK: - Testing lengthen with end anchor
    func testTimePeriod_lengthenWithEndAnchorBySeconds_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .end, size: .second, amount: 40)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-31 23:59:20")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByMinutes_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .end, size: .minute, amount: 30)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-31 23:30:00")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByHours_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .end, size: .hour, amount: 6)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-31 18")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByDays_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .end, size: .day, amount: 4)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-28")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByWeeks_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .end, size: .week, amount: 2)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-12-18")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByMonths_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .end, size: .month, amount: 4)
        expect(self.shortPeriod.startDate) == date(dateString: "1999-09-01")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_lengthenWithEndAnchorByYears_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthen(withAnchor: .end, size: .year, amount: 8)
        expect(self.shortPeriod.startDate) == calendar.date(year: 1992)
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    // MARK: - Testing shorten with start anchor
    func testTimePeriod_shortenWithStartAnchorBySeconds_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .start, size: .second, amount: 39)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-13 23:59:21")
    }
    
    func testTimePeriod_shortenWithStartAnchorByMinutes_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .start, size: .minute, amount: 41)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-13 23:19")
    }
    
    func testTimePeriod_shortenWithStartAnchorByHours_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .start, size: .hour, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-13 19")
    }
    
    func testTimePeriod_shortenWithStartAnchorByDays_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .start, size: .day, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-09")
    }
    
    func testTimePeriod_shortenWithStartAnchorByWeeks_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .start, size: .week, amount: 2)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-02-29")
    }
    
    func testTimePeriod_shortenWithStartAnchorByMonths_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .start, size: .month, amount: 4)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "1999-11-14")
    }
    
    func testTimePeriod_shortenWithStartAnchorByYears_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .start, size: .year, amount: 7)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate)   == date(dateString: "1993-03-14")
    }
    
    // MARK: - Testing shorten with center anchor
    func testTimePeriod_shortenWithCenterAnchorBySeconds_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .center, size: .second, amount: 40)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-01 00:00:20")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-13 23:59:40")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByMinutes_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .center, size: .minute, amount: 30)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-01 00:15")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-13 23:45")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByHours_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .center, size: .hour, amount: 6)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-01 03")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-13 21")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByDays_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .center, size: .day, amount: 4)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-03")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-12")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByWeeks_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .center, size: .week, amount: 2)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-08")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-07")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByMonths_shortensPeriodByGivenSize() {
        self.longPeriod.shorten(withAnchor: .center, size: .month, amount: 4)
        expect(self.longPeriod.startDate) == date(dateString: "1900-08-15")
        expect(self.longPeriod.endDate)   == date(dateString: "1999-11-01")
    }
    
    func testTimePeriod_shortenWithCenterAnchorByYears_shortensPeriodByGivenSize() {
        self.longPeriod.shorten(withAnchor: .center, size: .year, amount: 8)
        expect(self.longPeriod.startDate) == date(dateString: "1904-06-15")
        expect(self.longPeriod.endDate)   == date(dateString: "1996-01-01")
    }
    
    // MARK: - Testing shorten with end anchor
    func testTimePeriod_shortenWithEndAnchorBySeconds_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .end, size: .second, amount: 40)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-01 00:00:40")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByMinutes_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .end, size: .minute, amount: 30)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-01 00:30")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByHours_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .end, size: .hour, amount: 6)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-01 06")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByDays_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .end, size: .day, amount: 4)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-05")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByWeeks_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .end, size: .week, amount: 2)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-01-15")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByMonths_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .end, size: .month, amount: 4)
        expect(self.shortPeriod.startDate) == date(dateString: "2000-05-01")
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    func testTimePeriod_shortenWithEndAnchorByYears_shortensPeriodByGivenSize() {
        self.shortPeriod.shorten(withAnchor: .end, size: .year, amount: 8)
        expect(self.shortPeriod.startDate) == calendar.date(year: 2008)
        expect(self.shortPeriod.endDate)   == date(dateString: "2000-03-14")
    }
    
    // MARK: - Helper methods
    func testShiftEarlier(period: TimePeriod, size: TimePeriodSize, amount: Int, startDate: Date) {
        let newPeriod = period.copy()
        newPeriod.shiftEarlier(withSize: size, amount: amount)
        expect(newPeriod.startDate) == startDate
    }
    
    func testShiftLater(period: TimePeriod, size: TimePeriodSize, amount: Int, startDate: Date) {
        let newPeriod = period.copy()
        newPeriod.shiftLater(withSize: size, amount: amount)
        expect(newPeriod.startDate) == startDate
    }
}

