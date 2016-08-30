//
//  TimePeriodChainTests.swift
//  DateTools
//
//  Created by Paweł Sękara on 30.09.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import XCTest
import Nimble
@testable import DateTools

class TimePeriodChainTests: XCTestCase {
    
    var calendar: Calendar!
    var startDate: Date!
    var monthPeriod: TimePeriod!
    var twoMonthsPeriod: TimePeriod!
    var monthPeriodAfterMonth: TimePeriod!
    var twoMonthsPeriodAfterTwoWeeks: TimePeriod!
    var fourMonthsPeriod: TimePeriod!
    
    var chain: TimePeriodChain!
    
    override func setUp() {
        super.setUp()
        calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        startDate = date(dateString: "2010-01-01")
        monthPeriod = self.createTimePeriodWithMonthSize(amount: 1, startingAt: startDate)
        twoMonthsPeriod = self.createTimePeriodWithMonthSize(amount: 2, startingAt: startDate)
        monthPeriodAfterMonth = self.createTimePeriodWithMonthSize(amount: 1, startingAt: calendar.dateByAdding(months: 1, to: self.startDate))
        twoMonthsPeriodAfterTwoWeeks = self.createTimePeriodWithMonthSize(amount: 2, startingAt: calendar.dateByAdding(weeks: 2, to: self.startDate))
        fourMonthsPeriod = self.createTimePeriodWithMonthSize(amount: 4, startingAt: self.startDate)
        
        chain = TimePeriodChain(calendar: calendar)
        
        chain.add(timePeriod: monthPeriod)
        chain.add(timePeriod: twoMonthsPeriod)
        chain.add(timePeriod: monthPeriodAfterMonth)
        chain.add(timePeriod: twoMonthsPeriodAfterTwoWeeks)
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testTimePeriodChain_appendElements_createsAChainOfTimePeriods() {
        expect(self.chain[0].startDate) == startDate
        expect(self.chain[0].endDate)   == date(dateString: "2010-02-01")
        
        expect(self.chain[1].startDate) == date(dateString: "2010-02-01")
        expect(self.chain[1].endDate)   == date(dateString: "2010-04-01")
        
        expect(self.chain[2].startDate) == date(dateString: "2010-04-01")
        expect(self.chain[2].endDate)   == date(dateString: "2010-04-29")
        
        expect(self.chain[3].startDate) == date(dateString: "2010-04-29")
        expect(self.chain[3].endDate)   == date(dateString: "2010-06-27")
    }
    
    func testTimePeriodChain_startDate_returnsStartDateOfTimePeriodChain() {
        expect(self.chain.startDate) == startDate
    }
    
    func testTimePeriodChain_endDate_returnsEndDateOfTimePeriodChain() {
        expect(self.chain.endDate) == date(dateString: "2010-06-27")
    }
    
    func testTimePeriodChain_durationInDays_returnsNumberOfDaysInChain() {
        expect(self.chain.durationInDays) == 177
    }
    
    func testTimePeriodChain_insertTimePeriodAtTheBeginning_insertsTimePeriodWithCorrectedDates() {
        self.chain.insert(timePeriod: self.fourMonthsPeriod, atIndex: 0)
        
        expect(self.chain.first!.endDate) == startDate
        expect(self.chain.first!.startDate) == date(dateString: "2009-09-03")
        
        expect(self.chain.last!.endDate) == date(dateString: "2010-06-27")
    }
    
    func testTimePeriodChain_insertFirstTimePeriod_insertsTimePeriodWithCurrentDates() {
        let chain = TimePeriodChain(calendar: self.calendar)
        chain.insert(timePeriod: self.monthPeriod, atIndex: 0)
        
        expect(chain.count) == 1
        expect(chain.startDate) == self.monthPeriod.startDate
        expect(chain.endDate) == self.monthPeriod.endDate
    }
    
    func testTimePeriodChain_insertTimePeriodInTheMiddle_shiftsPeriodsToTheRightToMatchChain() {
        self.chain.insert(timePeriod: TimePeriod(size: .day, amount: 1, startingAt: startDate, calendar: calendar), atIndex: 2)
        
        expect(self.chain[0].startDate) == startDate
        expect(self.chain[1].endDate) == date(dateString: "2010-04-01")
        expect(self.chain[2].endDate) == date(dateString: "2010-04-02")
        expect(self.chain[3].endDate) == date(dateString: "2010-04-30")
        expect(self.chain[4].endDate) == date(dateString: "2010-06-28")
    }
    
    func testTimePeriodChain_insertTimePeriodAtTheEnd_appendsTimePeriodToChainWithCorrectedDates() {
        self.chain.insert(timePeriod: TimePeriod(size: .day, amount: 1, startingAt: chain[3].endDate, calendar: calendar), atIndex: 4)
        
        expect(self.chain[2].endDate) == date(dateString: "2010-04-29")
        expect(self.chain[3].endDate) == date(dateString: "2010-06-27")
        expect(self.chain[4].endDate) == date(dateString: "2010-06-28")
    }
    
    func testTimePeriodChain_insertTimePeriodBeyondTheBounds_doesNothingAndFailsSilently() {
        self.chain.insert(timePeriod: self.fourMonthsPeriod, atIndex: 10)
        
        expect(self.chain.count) == 4
    }
    
    func testTimePeriodChain_removePeriodBeyondTheBounds_doesNothingAndReturnsNil() {
        let removedPeriod = self.chain.remove(atIndex: 10)
        
        expect(self.chain.count) == 4
        expect(removedPeriod).to(beNil())
    }
    
    func testTimePeriodChain_removeLatestAndEarliesFromEmptyChain_doesNothingAndReturnsNil() {
        let chain = TimePeriodChain()
        
        let earliest = chain.removeEarliestTimePeriod()
        let latest = chain.removeLatestTimePeriod()
        
        expect(earliest).to(beNil())
        expect(latest).to(beNil())
    }
    
    func testTimePeriodChain_removeFirstTimePeriod_removesFirstTimePeriodAndShiftsChainLeft() {
        let removedPeriod = self.chain.removeEarliestTimePeriod()
        
        expect(self.chain.count) == 3
        expect(self.chain.startDate) == self.startDate
        expect(self.chain.endDate) == date(dateString: "2010-05-27")
        expect(removedPeriod).notTo(beNil())
    }
    
    func testTimePeriodChain_removeMiddleTimePeriod_removesElementAndShiftTheChainLeft() {
        let removedPeriod = self.chain.remove(atIndex: 2)
        
        expect(self.chain.count) == 3
        expect(self.chain.startDate) == self.startDate
        expect(self.chain.endDate) == date(dateString: "2010-05-30")
        expect(removedPeriod).notTo(beNil())
    }
    
    func testTimePeriod_removeLastTimePeriod_removesLastElementAndDoesNotShift() {
        let removedPeriod = self.chain.removeLatestTimePeriod()
        
        expect(self.chain.count) == 3
        expect(self.chain.startDate) == self.startDate
        expect(self.chain.endDate) == date(dateString: "2010-04-29")
        expect(removedPeriod).notTo(beNil())
    }
    
    func testTimePeriod_isEqualToCopy_returnsTrue() {
        let copy = self.chain.copy() as! TimePeriodChain
        
        expect(self.chain.equals(chain: copy)) == true
        expect(self.chain == copy) == true
    }
    
    func testTimePeriod_isEqualToChainWithMorePeriods_returnsFalse() {
        let copy = self.chain.copy() as! TimePeriodChain
        copy.add(timePeriod: self.fourMonthsPeriod)
        
        expect(self.chain.equals(chain: copy)) == false
        expect(self.chain == copy) == false
    }
    
    func testTimePeriod_isEqualToChainWithSimilarCharacteristicsButDifferentPeriods_returnsFalse() {
        let chain = TimePeriodChain(calendar: self.calendar)
        chain.add(timePeriod: self.monthPeriod)
        self.twoMonthsPeriod.shorten(withAnchor: .start, size: .day)
        chain.add(timePeriod: self.twoMonthsPeriod)
        self.monthPeriodAfterMonth.lengthen(withAnchor: .start, size: .day)
        chain.add(timePeriod: monthPeriodAfterMonth)
        chain.add(timePeriod: twoMonthsPeriodAfterTwoWeeks)
        
        expect(self.chain.equals(chain: chain)) == false
        expect(self.chain == chain) == false
    }
    
    // MARK: - Helper methods
    func createTimePeriodWithMonthSize(amount: Int, startingAt: Date) -> TimePeriod {
        return TimePeriod(size: .month, amount: amount, startingAt: startingAt, calendar: self.calendar)
    }
}
