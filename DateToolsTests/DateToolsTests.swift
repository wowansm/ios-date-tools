//
//  DateToolsTests.swift
//  DateTools
//
//  Created by David Gileadi on 1/24/17.
//  Copyright © 2017 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import XCTest
import Nimble
@testable import DateTools

class DateToolsTests: XCTestCase {

    var formatter: DateFormatter!
    var controlDate: Date!

    override func setUp() {
        super.setUp()

        self.formatter = DateFormatter()
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.controlDate = self.formatter.date(from: "2014 11 05 18:15:12.000")!
    }

    // MARK: - Date Components

    func testEra() {
        expect(Date().era) == 1
    }
    func testYear() {
        expect(self.controlDate.year) == 2014
    }
    func testMonth() {
        expect(self.controlDate.month) == 11
    }
    func testDay() {
        expect(self.controlDate.day) == 5
    }
    func testHour() {
        expect(self.controlDate.hour) == 18
    }
    func testMinute() {
        expect(self.controlDate.minute) == 15
    }
    func testSecond() {
        expect(self.controlDate.second) == 12
    }
    func testWeekday() {
        expect(self.controlDate.weekday) == 4
    }
    func testWeekdayOrdinal() {
        expect(self.controlDate.weekdayOrdinal) == 1
    }
    func testQuarter() {
        //Quarter is a little funky right now
        //expect(self.testDate.quarter) == 4
    }
    func testWeekOfMonth() {
        expect(self.controlDate.weekOfMonth) == 2
    }
    func testWeekOfYear() {
        expect(self.controlDate.weekOfYear) == 45
    }
    func testYearForWeekOfYear() {
        expect(self.controlDate.yearForWeekOfYear) == 2014
    }
    func testDaysInMonth() {
        expect(self.controlDate.daysInMonth) == 30
    }
    func testDaysInYear() {
        //Non leap year (2014)
        expect(self.controlDate.daysInYear) == 365

		//Leap year (2000)
        expect(self.controlDate.subtracting(years: 14).daysInYear) == 366
    }
    func testIsInLeapYear() {
        //Not leap year
        expect(false) == self.controlDate.isInLeapYear

		//Is leap year (%400) 2000
        expect(true) == self.controlDate.subtracting(years: 14).isInLeapYear

		//Not leap year (%100) 1900
        expect(false) == self.controlDate.subtracting(years: 114).isInLeapYear

		//Is leap year (%4) 2016
        expect(true) == self.controlDate.adding(years: 2).isInLeapYear
    }
    func testIsToday() {
        //Test true now
        expect(true) == Date().isToday

		//Test true past (Technically, could fail if you ran the test precisely at midnight, but...)
        expect(true) == Date().subtracting(seconds: 1).isToday

		//Test true future (Technically, could fail if you ran the test precisely at midnight, but...)
        expect(true) == Date().adding(seconds: 1).isToday

		//Tests false past
        expect(false) == Date().subtracting(days: 2).isToday

		//Tests false future
        expect(false) == Date().adding(days: 1).isToday
    }
    func testIsTomorrow() {
        //Test false with now
        expect(false) == Date().isTomorrow

		//Test false past
        expect(false) == Date().subtracting(days: 1).isTomorrow

		//Test true future
        expect(true) == Date().adding(days: 1).isTomorrow

		//Tests false future
        expect(false) == Date().adding(days: 2).isTomorrow

	}
    func testIsYesterday() {
        //Test false with now
        expect(false) == Date().isYesterday

		//Test true past
        expect(true) == Date().subtracting(days: 1).isYesterday

		//Test false future
        expect(false) == Date().adding(days: 1).isYesterday

		//Tests false future
        expect(false) == Date().subtracting(days: 2).isYesterday
    }

	func testIsWeekend() {
        //Created test dates
        let testFriday = self.formatter.date(from: "2015 09 04 12:45:12.000")!
        let testMonday = self.formatter.date(from: "2015 02 16 00:00:00.000")!
        let testWeekend = self.formatter.date(from: "2015 09 05 17:45:12.000")!

		//Test false with friday and monday
        expect(false) == testFriday.isWeekend
        expect(false) == testMonday.isWeekend

		//Test true past
        expect(true) == testWeekend.isWeekend
    }

	func testIsSameDay() {
        //Test same time stamp
        expect(true) == Date().isSameDay(Date())

		//Test true same day
        let testSameDay1 = self.formatter.date(from: "2014 11 05 12:45:12.000")!
        let testSameDay2 = self.formatter.date(from: "2014 11 05 17:45:12.000")!
        expect(true) == testSameDay1.isSameDay(testSameDay2)

		//Test false 1 day ahead
        expect(false) == testSameDay1.isSameDay(Date().adding(days: 1))

		//Test false 1 day before
        expect(false) == testSameDay1.isSameDay(Date().subtracting(days: 1))
    }

	func testIsSameDayStatic() {
        //Test true same time stamp
        expect(true) == Date.isSameDay(date: Date(), asDate: Date())

		//Test true same day
        let testSameDay1 = self.formatter.date(from: "2014 11 05 12:45:12.000")!
        let testSameDay2 = self.formatter.date(from: "2014 11 05 17:45:12.000")!
		expect(true) == Date.isSameDay(date: testSameDay1, asDate: testSameDay2)

        //Test false 1 day ahead
		expect(false) == Date.isSameDay(date: Date(), asDate: Date().adding(days: 1))

        //Test false 1 day before
		expect(false) == Date.isSameDay(date: Date(), asDate: Date().subtracting(days: 1))
    }

	// MARK: - Date Editing
    // MARK: Date Creating

	func testDateWithYearMonthDayHourMinuteSecond() {
		expect(self.controlDate) == Date.dateWith(year: 2014, month: 11, day: 5, hour: 18, minute: 15, second: 12)
    }

	func testDateWithStringFormatStringTimeZone() {
		let testDate = Date.dateWith(dateString: "2015-02-27T18:15:00", formatString: "yyyy-MM-dd'T'HH:mm:ss", timeZone: TimeZone(identifier: "UTC")!)

		expect(testDate) == Date.dateWith(dateString: "2015-02-27T19:15:00", formatString: "yyyy-MM-dd'T'HH:mm:ss", timeZone: TimeZone(identifier: "Europe/Warsaw")!)
    }

	// MARK: Date By Adding
    func testAddingYears() {
        let testDate = self.formatter.date(from: "2016 11 05 18:15:12.000")!
        expect(testDate) == self.controlDate.adding(years: 2)
    }
    func testAddingMonths() {
        let testDate = self.formatter.date(from: "2015 01 05 18:15:12.000")!
        expect(testDate) == self.controlDate.adding(months: 2)
    }
    func testAddingWeeks() {
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(testDate) == self.controlDate.adding(weeks: 1)
    }
    func testAddingDays() {
        let testDate = self.formatter.date(from: "2014 11 07 18:15:12.000")!
        expect(testDate) == self.controlDate.adding(days: 2)
    }
    func testAddingHours() {
        let testDate = self.formatter.date(from: "2014 11 06 6:15:12.000")!
        expect(testDate) == self.controlDate.adding(hours: 12)
    }
    func testAddingMinutes() {
        let testDate = self.formatter.date(from: "2014 11 05 18:30:12.000")!
        expect(testDate) == self.controlDate.adding(minutes: 15)
    }
    func testAddingSeconds() {
        let testDate = self.formatter.date(from: "2014 11 05 18:16:12.000")!
        expect(testDate) == self.controlDate.adding(seconds: 60)
    }

	// MARK: Date By Subtracting
    func testSubtractingYears() {
        let testDate = self.formatter.date(from: "2000 11 05 18:15:12.000")!
        expect(testDate) == self.controlDate.subtracting(years: 14)
    }
    func testSubtractingMonths() {
        let testDate = self.formatter.date(from: "2014 4 05 18:15:12.000")!
        expect(testDate) == self.controlDate.subtracting(months: 7)
    }
    func testSubtractingWeeks() {
        let testDate = self.formatter.date(from: "2014 10 29 18:15:12.000")!
        expect(testDate) == self.controlDate.subtracting(weeks: 1)
    }
    func testSubtractingDays() {
        let testDate = self.formatter.date(from: "2014 11 01 18:15:12.000")!
        expect(testDate) == self.controlDate.subtracting(days: 4)
    }
    func testSubtractingHours() {
        let testDate = self.formatter.date(from: "2014 11 05 00:15:12.000")!
        expect(testDate) == self.controlDate.subtracting(hours: 18)
    }
    func testSubtractingMinutes() {
        let testDate = self.formatter.date(from: "2014 11 05 17:45:12.000")!
        expect(testDate) == self.controlDate.subtracting(minutes: 30)
    }
    func testSubtractingSeconds() {
        let testDate = self.formatter.date(from: "2014 11 05 18:14:12.000")!
        expect(testDate) == self.controlDate.subtracting(seconds: 60)
    }

	// MARK: - Date Comparison
    // MARK: Time From
    func testYearsFrom() {
        //Under a year
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.years(from: testDate)) == 0

		//Exactly a year
        let testDate2 = self.formatter.date(from: "2015 11 05 18:15:12.000")!
        expect(-1) == self.controlDate.years(from: testDate2)

		//Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2015 11 04 18:15:12.000")!
        expect(self.controlDate.years(from: testDate3)) == 0

		//Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2013 11 06 18:15:12.000")!
        expect(self.controlDate.years(from: testDate5)) == 0

		//Over a year earlier
        let testDate6 = self.formatter.date(from: "2012 11 04 18:15:12.000")!
        expect(self.controlDate.years(from: testDate6)) == 2

		///Over a year later
        let testDate7 = self.formatter.date(from: "2017 11 12 18:15:12.000")!
        expect(-3) == self.controlDate.years(from: testDate7)

		///Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2017 11 3 18:15:12.000")!
        expect(-2) == self.controlDate.years(from: testDate8)

		///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2012 11 8 18:15:12.000")!
        expect(self.controlDate.years(from: testDate9)) == 1
    }
    func testMonthsFrom() {
        //Under a month
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.months(from: testDate)) == 0

		//Exactly a month
        let testDate2 = self.formatter.date(from: "2014 12 05 18:15:12.000")!
        expect(-1) == self.controlDate.months(from: testDate2)

		//Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2015 11 04 18:15:12.000")!
        expect(-11) == self.controlDate.months(from: testDate3)

		//Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2013 11 06 18:15:12.000")!
        expect(self.controlDate.months(from: testDate5)) == 11

		//Over a year earlier
        let testDate6 = self.formatter.date(from: "2012 11 04 18:15:12.000")!
        expect(self.controlDate.months(from: testDate6)) == 24

		///Over a year later
        let testDate7 = self.formatter.date(from: "2017 11 12 18:15:12.000")!
        expect(-36) == self.controlDate.months(from: testDate7)
    }
    func testWeeksFrom() {
        //Same week
        let testSameDate = self.formatter.date(from: "2014 11 06 18:15:12.000")!
        expect(self.controlDate.weeks(from: testSameDate)) == 0

		//Same year
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(-1) == self.controlDate.weeks(from: testDate)

		//Eariler year
        let testDate2 = self.formatter.date(from: "2013 11 12 18:15:12.000")!
        expect(self.controlDate.weeks(from: testDate2)) == 51

		//Later year
        let testDate3 = self.formatter.date(from: "2015 11 12 18:15:12.000")!
        expect(-53) == self.controlDate.weeks(from: testDate3)
    }
    func testDaysFrom() {
        //Same day
        let testSameDate = self.formatter.date(from: "2014 11 05 18:15:12.000")!
        expect(self.controlDate.days(from: testSameDate)) == 0

		//Same year
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(-7) == self.controlDate.days(from: testDate)

		//Eariler year
        let testDate2 = self.formatter.date(from: "2013 11 12 18:15:12.000")!
        expect(self.controlDate.days(from: testDate2)) == 358

		//Later year
        let testDate3 = self.formatter.date(from: "2015 11 12 18:15:12.000")!
        expect(-372) == self.controlDate.days(from: testDate3)
    }
    func testHoursFrom() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(-2) == self.controlDate.hours(from: testDate)

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(self.controlDate.hours(from: testDate2)) == 3
    }
    func testMinutesFrom() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(-120) == self.controlDate.minutes(from: testDate)

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(self.controlDate.minutes(from: testDate2)) == 180
    }
    func testSecondsFrom() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(-7200) == self.controlDate.seconds(from: testDate)

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(self.controlDate.seconds(from: testDate2)) == 10800
    }

	// MARK: Earlier Than
    func testYearsEarlierThan() {
        //Under a year
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.yearsEarlier(than: testDate)) == 0

		//Exactly a year
        let testDate2 = self.formatter.date(from: "2015 11 05 18:15:12.000")!
        expect(self.controlDate.yearsEarlier(than: testDate2)) == 1

		//Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2015 11 04 18:15:12.000")!
        expect(self.controlDate.yearsEarlier(than: testDate3)) == 0

		//Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2013 11 06 18:15:12.000")!
        expect(self.controlDate.yearsEarlier(than: testDate5)) == 0

		//Over a year earlier
        let testDate6 = self.formatter.date(from: "2012 11 04 18:15:12.000")!
        expect(self.controlDate.yearsEarlier(than: testDate6)) == 0

		///Over a year later
        let testDate7 = self.formatter.date(from: "2017 11 12 18:15:12.000")!
        expect(self.controlDate.yearsEarlier(than: testDate7)) == 3

		///Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2017 11 3 18:15:12.000")!
        expect(self.controlDate.yearsEarlier(than: testDate8)) == 2

		///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2012 11 8 18:15:12.000")!
        expect(self.controlDate.yearsEarlier(than: testDate9)) == 0
    }
    func testMonthsEarlerThan() {
        //Under a month
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.monthsEarlier(than: testDate)) == 0

		//Exactly a month
        let testDate2 = self.formatter.date(from: "2014 12 05 18:15:12.000")!
        expect(self.controlDate.monthsEarlier(than: testDate2)) == 1

		//Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2015 11 04 18:15:12.000")!
        expect(self.controlDate.monthsEarlier(than: testDate3)) == 11

		//Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2013 11 06 18:15:12.000")!
        expect(self.controlDate.monthsEarlier(than: testDate5)) == 0

		//Over a year earlier
        let testDate6 = self.formatter.date(from: "2012 11 04 18:15:12.000")!
        expect(self.controlDate.monthsEarlier(than: testDate6)) == 0

		///Over a year later
        let testDate7 = self.formatter.date(from: "2017 11 12 18:15:12.000")!
        expect(self.controlDate.monthsEarlier(than: testDate7)) == 36
    }
    func testWeeksEarlierThan() {
        //Same week
        let testSameDate = self.formatter.date(from: "2014 11 06 18:15:12.000")!
        expect(self.controlDate.weeksEarlier(than: testSameDate)) == 0

		//Same year
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.weeksEarlier(than: testDate)) == 1

		//Eariler year
        let testDate2 = self.formatter.date(from: "2013 11 12 18:15:12.000")!
        expect(self.controlDate.weeksEarlier(than: testDate2)) == 0

		//Later year
        let testDate3 = self.formatter.date(from: "2015 11 12 18:15:12.000")!
        expect(self.controlDate.weeksEarlier(than: testDate3)) == 53
    }
    func testDaysEarlierThan() {
        //Same day
        let testSameDate = self.formatter.date(from: "2014 11 05 18:15:12.000")!
        expect(self.controlDate.daysEarlier(than: testSameDate)) == 0

		//Same year
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.daysEarlier(than: testDate)) == 7

		//Eariler year
        let testDate2 = self.formatter.date(from: "2013 11 12 18:15:12.000")!
        expect(self.controlDate.daysEarlier(than: testDate2)) == 0

		//Later year
        let testDate3 = self.formatter.date(from: "2015 11 12 18:15:12.000")!
        expect(self.controlDate.daysEarlier(than: testDate3)) == 372
    }
    func testHoursEarlierThan() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(self.controlDate.hoursEarlier(than: testDate)) == 2

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(self.controlDate.hoursEarlier(than: testDate2)) == 0
    }
    func testMinutesEarlierThan() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(self.controlDate.minutesEarlier(than: testDate)) == 120

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(self.controlDate.minutesEarlier(than: testDate2)) == 0
    }
    func testSecondsEarlierThan() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(self.controlDate.secondsEarlier(than: testDate)) == 7200

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(self.controlDate.secondsEarlier(than: testDate2)) == 0
    }

	// MARK: Later Than
    func testYearsLaterThan() {
        //Under a year
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.yearsLater(than: testDate)) == 0

		//Exactly a year later
        let testDate2 = self.formatter.date(from: "2015 11 05 18:15:12.000")!
        expect(self.controlDate.yearsLater(than: testDate2)) == 0

		//Exactly a year earlier
        let testDate3 = self.formatter.date(from: "2013 11 05 18:15:12.000")!
        expect(self.controlDate.yearsLater(than: testDate3)) == 1

		//Year number later, still less than a year
        let testDate4 = self.formatter.date(from: "2015 11 04 18:15:12.000")!
        expect(self.controlDate.yearsLater(than: testDate4)) == 0

		//Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2013 11 06 18:15:12.000")!
        expect(self.controlDate.yearsLater(than: testDate5)) == 0

		//Over a year earlier
        let testDate6 = self.formatter.date(from: "2012 11 04 18:15:12.000")!
        expect(self.controlDate.yearsLater(than: testDate6)) == 2

		///Over a year later
        let testDate7 = self.formatter.date(from: "2017 11 12 18:15:12.000")!
        expect(self.controlDate.yearsLater(than: testDate7)) == 0

		///Over a year later, but less than a year in final comparison year
        let testDate8 = self.formatter.date(from: "2017 11 3 18:15:12.000")!
        expect(self.controlDate.yearsLater(than: testDate8)) == 0

		///Over a year earlier, but less than a year in final comparison year
        let testDate9 = self.formatter.date(from: "2012 11 8 18:15:12.000")!
        expect(self.controlDate.yearsLater(than: testDate9)) == 1
    }
    func testMonthsLaterThan() {
        //Under a month
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.monthsLater(than: testDate)) == 0

		//Exactly a month
        let testDate2 = self.formatter.date(from: "2014 12 05 18:15:12.000")!
        expect(self.controlDate.monthsLater(than: testDate2)) == 0

		//Year number later, still less than a year
        let testDate3 = self.formatter.date(from: "2015 11 04 18:15:12.000")!
        expect(self.controlDate.monthsLater(than: testDate3)) == 0

		//Year number earlier, still less than a year
        let testDate5 = self.formatter.date(from: "2013 11 06 18:15:12.000")!
        expect(self.controlDate.monthsLater(than: testDate5)) == 11

		//Over a year earlier
        let testDate6 = self.formatter.date(from: "2012 11 04 18:15:12.000")!
        expect(self.controlDate.monthsLater(than: testDate6)) == 24

		///Over a year later
        let testDate7 = self.formatter.date(from: "2017 11 12 18:15:12.000")!
        expect(self.controlDate.monthsLater(than: testDate7)) == 0
    }
    func testWeeksLaterThan() {
        //Same week
        let testSameDate = self.formatter.date(from: "2014 11 06 18:15:12.000")!
        expect(self.controlDate.weeksLater(than: testSameDate)) == 0

		//Same year later
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.weeksLater(than: testDate)) == 0

		//Same year earlier
        let testDate2 = self.formatter.date(from: "2014 10 24 18:15:12.000")!
        expect(self.controlDate.weeksLater(than: testDate2)) == 1

		//Eariler year
        let testDate3 = self.formatter.date(from: "2013 11 12 18:15:12.000")!
        expect(self.controlDate.weeksLater(than: testDate3)) == 51

		//Later year
        let testDate4 = self.formatter.date(from: "2015 11 12 18:15:12.000")!
        expect(self.controlDate.weeksLater(than: testDate4)) == 0
    }
    func testDaysLaterThan() {
        //Same day
        let testSameDate = self.formatter.date(from: "2014 11 05 18:15:12.000")!
        expect(self.controlDate.daysLater(than: testSameDate)) == 0

		//Same year later
        let testDate = self.formatter.date(from: "2014 11 12 18:15:12.000")!
        expect(self.controlDate.daysLater(than: testDate)) == 0

		//Same year earlier
        let testDate2 = self.formatter.date(from: "2014 11 3 18:15:12.000")!
        expect(self.controlDate.daysLater(than: testDate2)) == 2

		//Eariler year
        let testDate3 = self.formatter.date(from: "2013 11 12 18:15:12.000")!
        expect(self.controlDate.daysLater(than: testDate3)) == 358

		//Later year
        let testDate4 = self.formatter.date(from: "2015 11 12 18:15:12.000")!
        expect(self.controlDate.daysLater(than: testDate4)) == 0
    }
    func testHoursLaterThan() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(self.controlDate.hoursLater(than: testDate)) == 0

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(self.controlDate.hoursLater(than: testDate2)) == 3
    }
    func testMinutesLaterThan() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(self.controlDate.minutesLater(than: testDate)) == 0

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(self.controlDate.minutesLater(than: testDate2)) == 180
    }
    func testSecondsLaterThan() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(self.controlDate.secondsLater(than: testDate)) == 0

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(self.controlDate.secondsLater(than: testDate2)) == 10800
    }

	// MARK: Comparators
    func testIsEarlierThan() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(true) == self.controlDate.isEarlier(than: testDate)

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(false) == self.controlDate.isEarlier(than: testDate2)

		//Same
        expect(false) == self.controlDate.isEarlier(than: self.controlDate)
    }
    func testIsLaterThan() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(false) == self.controlDate.isLater(than: testDate)

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(true) == self.controlDate.isLater(than: testDate2)

		//Same
        expect(false) == self.controlDate.isLater(than: self.controlDate)
    }
    func testisEarlierThanOrEqualTo() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(true) == self.controlDate.isEarlierThanOrEqualTo(testDate)

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(false) == self.controlDate.isEarlierThanOrEqualTo(testDate2)

		//Same
        expect(true) == self.controlDate.isEarlierThanOrEqualTo(self.controlDate)
    }
    func testIsLaterOrEqualToDate() {
        //Later
        let testDate = self.formatter.date(from: "2014 11 05 20:15:12.000")!
        expect(false) == self.controlDate.isLaterThanOrEqualTo(testDate)

		//Earlier
        let testDate2 = self.formatter.date(from: "2014 11 05 15:15:12.000")!
        expect(true) == self.controlDate.isLaterThanOrEqualTo(testDate2)

		//Same
        expect(true) == self.controlDate.isLaterThanOrEqualTo(self.controlDate)
    }

}
