//
//  TimePeriodCollectionTests.swift
//  DateTools
//
//  Created by Paweł Sękara on 29.09.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import XCTest
import Nimble
@testable import DateTools

class TimePeriodCollectionTests: XCTestCase {
    
    var collection: TimePeriodCollection!
    var emptyCollection: TimePeriodCollection!
    var calendar: Calendar!
    var startDate: Date!
    
    var monthPeriod: TimePeriod!
    var twoMonthsPeriod: TimePeriod!
    var monthPeriodAfterMonth: TimePeriod!
    var twoMonthsPeriodAfterTwoWeeks: TimePeriod!
    
    var fourMonthsPeriod: TimePeriod!
    
    override func setUp() {
        super.setUp()
        calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        collection = TimePeriodCollection(calendar: calendar)
        emptyCollection = TimePeriodCollection(calendar: calendar)
        
        startDate = date(dateString: "2010-01-01")
        monthPeriod = self.createTimePeriodWithMonthSize(amount: 1, startingAt: startDate)
        twoMonthsPeriod = self.createTimePeriodWithMonthSize(amount: 2, startingAt: startDate)
        monthPeriodAfterMonth = self.createTimePeriodWithMonthSize(amount: 1, startingAt: calendar.dateByAdding(months: 1, to: self.startDate))
        twoMonthsPeriodAfterTwoWeeks = self.createTimePeriodWithMonthSize(amount: 2, startingAt: calendar.dateByAdding(weeks: 2, to: self.startDate))
        fourMonthsPeriod = self.createTimePeriodWithMonthSize(amount: 4, startingAt: self.startDate)
        
        collection.add(timePeriod: monthPeriod)
        collection.add(timePeriod: twoMonthsPeriod)
        collection.add(timePeriod: monthPeriodAfterMonth)
        collection.add(timePeriod: twoMonthsPeriodAfterTwoWeeks)
    }
    
    override func tearDown() {
        collection = nil
        calendar = nil
        startDate = nil
        super.tearDown()
    }
    
    func testPeriodCollection_getSubscript_returnsPeriodAtGivenSubscript() {
        expect(self.collection[0]) == monthPeriod
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[2]) == monthPeriodAfterMonth
        expect(self.collection[3]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_setSubscript_setsTimePeriodAtGivenSubscript() {
        self.collection[0] = fourMonthsPeriod
        self.collection[3] = monthPeriod
        
        expect(self.collection[0]) == fourMonthsPeriod
        expect(self.collection[3]) == monthPeriod
    }
    
    func testPeriodCollection_count_returnsCountOfPeriodsInCollection() {
        expect(self.collection.count) == 4
    }
    
    func testPeriodCollection_startDate_returnsTheEarliestStartDateFromCollection() {
        expect(self.collection.startDate) == self.startDate
    }
    
    func testPeriodCollection_endDate_returnsTheOldestDateFromCollection() {
        expect(self.collection.endDate) == self.twoMonthsPeriodAfterTwoWeeks.endDate
    }
    
    // MARK: - Testing duration in unit methods
    func testPeriodCollection_durationInYears_returnsOverallDurationOfAllPeriodsInYears() {
        expect(self.collection.durationInYears) == 0
    }
    
    func testPeriodCollection_durationInMonths_returnsOverallDurationOfAllPeriodsInMonths() {
        expect(self.collection.durationInMonths) == 2
    }
    
    func testPeriodCollection_durationInWeeks_returnsOverallDurationOfAllPeriodsInWeeks() {
        expect(self.collection.durationInWeeks) == 10
    }
    
    func testPeriodCollection_durationInDays_returnsOverallDurationOfAllPeriodsInDays() {
        expect(self.collection.durationInDays) == 73
    }
    
    func testPeriodCollection_durationInHours_returnsOverallDurationOfAllPeriodsInHours() {
        expect(self.collection.durationInHours) == 73 * 24
    }
    
    func testPeriodCollection_durationInMinutes_returnsOverallDurationOfAllPeriodsInMinutes() {
        expect(self.collection.durationInMinutes) == 73 * 24 * 60
    }
    
    func testPeriodCollection_durationInSeconds_returnsOverallDurationOfAllPeriodsInSeconds() {
        expect(self.collection.durationInSeconds) == 73 * 24 * 60 * 60
    }
    
    func testPeriodCollection_durationForEmptyCollection_returnsZero() {
        expect(self.emptyCollection.durationInSeconds) == 0
        expect(self.emptyCollection.durationInMinutes) == 0
        expect(self.emptyCollection.durationInHours)   == 0
        expect(self.emptyCollection.durationInDays)    == 0
        expect(self.emptyCollection.durationInWeeks)   == 0
        expect(self.emptyCollection.durationInMonths)  == 0
        expect(self.emptyCollection.durationInYears)   == 0
    }
    
    // MARK: - Testing adding time periods
    func testPeriodCollection_addTimePeriod_addsTimePeriodAtTheEndOfCollection() {
        collection.add(timePeriod: fourMonthsPeriod)
        expect(self.collection[4]) == fourMonthsPeriod
        expect(self.collection.count) == 5
    }
    
    func testPeriodCollection_insertTimePeriodAtTheBeginning_insertsTimePeriodAtTheBeginning() {
        collection.insert(timePeriod: fourMonthsPeriod, atIndex: 0)
        expect(self.collection[0]) == fourMonthsPeriod
        expect(self.collection[1]) == monthPeriod
        expect(self.collection.count) == 5
    }
    
    func testPeriodCollection_insertTimePeriodInTheMiddle_insertsTimePeriodInTheMiddle() {
        collection.insert(timePeriod: fourMonthsPeriod, atIndex: 2)
        expect(self.collection[2]) == fourMonthsPeriod
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[3]) == monthPeriodAfterMonth
        expect(self.collection.count) == 5
    }
    
    func testPeriodCollection_insertAtTheEnd_insertsTimePeriodAtTheEnd() {
        collection.insert(timePeriod: fourMonthsPeriod, atIndex: 4)
        expect(self.collection[4]) == fourMonthsPeriod
    }
    
    func testPeriodCollection_insertAtBadIndex_doesNotInsertTimePeriod() {
        collection.insert(timePeriod: fourMonthsPeriod, atIndex: 5)
        expect(self.collection.count) == 4
    }
    
    // MARK: - Testing removing time periods
    func testPeriodCollection_removeFirstTimePeriod_removesAndReturnFirstTimePeriod() {
        let removedPeriod = self.collection.remove(atIndex: 0)
        expect(removedPeriod) == monthPeriod
        expect(self.collection.count) == 3
        expect(self.collection[0]) == twoMonthsPeriod
    }
    
    func testPeriodCollection_removeMiddleTimePeriod_removesMiddleTimePeriodAndReturn() {
        let removedPeriod = self.collection.remove(atIndex: 2)
        expect(removedPeriod) == monthPeriodAfterMonth
        expect(self.collection[2]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection.count) == 3
    }
    
    func testPeriodCollection_removeLastTimePeriod_removesLastTimePeriodAndReturn() {
        let removedPeriod = self.collection.remove(atIndex: 3)
        expect(removedPeriod) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection.count) == 3
    }
    
    func testPeriodCollection_removePeriodOutsideBounds_doesNotCrashAndReturnsNil() {
        let removedPeriod = self.collection.remove(atIndex: 4)
        expect(removedPeriod).to(beNil())
        expect(self.collection.count) == 4
    }
    
    func testPeriodCollection_removeAllPeriodsFromCollection_yieldsEmptyCollection() {
        self.collection.remove(atIndex: 0)
        self.collection.remove(atIndex: 0)
        self.collection.remove(atIndex: 0)
        self.collection.remove(atIndex: 0)
        
        expect(self.collection.count) == 0
    }
    
    // MARK: - Testing sorting time period collections
    func testPeriodCollection_sortingByStartAscending_sortsPeriodsByStartAscending() {
        collection.sortByStartAscending()
        expect(self.collection[0]) == monthPeriod
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[2]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection[3]) == monthPeriodAfterMonth
    }
    
    func testPeriodCollection_sortByStartDescending_sortsPeriodsByStartDescending() {
        collection.sortByStartDescending()
        expect(self.collection[0]) == monthPeriodAfterMonth
        expect(self.collection[1]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection[2]) == monthPeriod
        expect(self.collection[3]) == twoMonthsPeriod
    }
    
    func testPeriodCollection_sortByEndAscending_sortsPeriodsByEndAscending() {
        collection.sortByEndAscending()
        expect(self.collection[0]) == monthPeriod
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[2]) == monthPeriodAfterMonth
        expect(self.collection[3]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_sortByEndDescending_sortsPeriodsByEndDescending() {
        collection.sortByEndDescending()
        expect(self.collection[0]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[2]) == monthPeriodAfterMonth
        expect(self.collection[3]) == monthPeriod
    }
    
    func testPeriodCollection_sortByDurationAscending_sortsPeriodsByDurationAscending() {
        collection.sortByDurationAscending()
        expect(self.collection[0]) == monthPeriodAfterMonth
        expect(self.collection[1]) == monthPeriod
        expect(self.collection[2]) == twoMonthsPeriod
        expect(self.collection[3]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_sortByDurationDescending_sortsPeriodsByDurationDescending() {
        collection.sortByDurationDescending()
        expect(self.collection[0]) == twoMonthsPeriod
        expect(self.collection[1]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection[2]) == monthPeriod
        expect(self.collection[3]) == monthPeriodAfterMonth
    }
    
    // MARK: - Testing shifting time period collections
    func testPeriodCollection_shiftLater_shiftsAllPeriodsLaterByGivenSize() {
        collection.shiftLater(withSize: .week, amount: 1)
        
        expect(self.collection[0].startDate) == date(dateString: "2010-01-08")
        expect(self.collection[0].endDate)   == date(dateString: "2010-02-08")
        
        expect(self.collection[1].startDate) == date(dateString: "2010-01-08")
        expect(self.collection[1].endDate)   == date(dateString: "2010-03-08")
        
        expect(self.collection[2].startDate) == date(dateString: "2010-02-08")
        expect(self.collection[2].endDate)   == date(dateString: "2010-03-08")
        
        expect(self.collection[3].startDate) == date(dateString: "2010-01-22")
        expect(self.collection[3].endDate)   == date(dateString: "2010-03-22")
    }
    
    func testPeriodCollection_shiftEarlier_shiftsAllPeriodsEarlierByGivenSize() {
        collection.shiftEarlier(withSize: .month, amount: 2)
        
        expect(self.collection[0].startDate) == date(dateString: "2009-11-01")
        expect(self.collection[0].endDate)   == date(dateString: "2009-12-01")
        
        expect(self.collection[1].startDate) == date(dateString: "2009-11-01")
        expect(self.collection[1].endDate)   == date(dateString: "2010-01-01")
        
        expect(self.collection[2].startDate) == date(dateString: "2009-12-01")
        expect(self.collection[2].endDate)   == date(dateString: "2010-01-01")
        
        expect(self.collection[3].startDate) == date(dateString: "2009-11-15")
        expect(self.collection[3].endDate)   == date(dateString: "2010-01-15")
    }
    
    func testPeriodCollection_isEqualToCollectionConsideringOrder_returnsTrueWhenCollectionsAreEqual() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        let secondCollection = TimePeriodCollection(calendar: calendar)
        secondCollection.add(timePeriod: monthPeriod)
        secondCollection.add(timePeriod: twoMonthsPeriod)
        secondCollection.add(timePeriod: monthPeriodAfterMonth)
        secondCollection.add(timePeriod: twoMonthsPeriodAfterTwoWeeks)
        
        expect(collectionCopy.equals(collection: self.collection, considerOrder: true)) == true
        expect(secondCollection.equals(collection: self.collection, considerOrder: true)) == true
        expect(TimePeriodCollection().equals(collection: self.emptyCollection, considerOrder: true)) == true
    }
    
    func testPeriodCollection_isEqualToCollectionWithDifferentCharacteristics_returnsFalse() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        collectionCopy[1] = fourMonthsPeriod
        
        expect(collectionCopy.equals(collection: self.collection)) == false
    }
    
    func testPeriodCollection_isEqualToCollectionConsideringOrder_returnsFalseWhenCollectionsAreNotEqual() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        collectionCopy.add(timePeriod: fourMonthsPeriod)
        let collection2 = self.collection.copy() as! TimePeriodCollection
        collection2[0] = collection[1]
        collection2[1] = collection[0]
        
        expect(collectionCopy.equals(collection: self.collection, considerOrder: true)) == false
        expect(collection2.equals(collection: self.collection, considerOrder: true)) == false
    }
    
    func testPeriodCollection_isEqualNotConsideringOrder_returnsTrueWhenCollectionsAreEqual() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        collectionCopy[0] = collection[1]
        collectionCopy[1] = collection[0]
        
        expect(collectionCopy.equals(collection: self.collection)) == true
    }
    
    func testPeriodCollection_isEqualNotConsideringOrder_returnsFalseWhenCollectionsAreNotEqual() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        collectionCopy[0] = TimePeriod(size: .week, amount: 2, startingAt: self.startDate, calendar: self.calendar)
        
        expect(collectionCopy.equals(collection: self.collection)) == false
        expect(collectionCopy == self.collection) == false

    }
    
    // MARK: - Testing time period relationship methods
    func testPeriodCollection_periodsInside_returnsAllPeriodsInsideOfAGivenPeriod() {
        let periods1 = self.collection.periodsInside(period: TimePeriod(size: .week, amount: 5, startingAt: self.startDate, calendar: self.calendar))
        let periods2 = self.collection.periodsInside(period: TimePeriod(size: .month, amount: 2, endingAt: self.twoMonthsPeriodAfterTwoWeeks.endDate, calendar: self.calendar))
        
        expect(periods1.count) == 1
        expect(periods1[0]) == monthPeriod
        
        expect(periods2.count) == 2
        expect(periods2[0]) == monthPeriodAfterMonth
        expect(periods2[1]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_periodsIntersectedByDate_returnsAllPeriodsThatContainGivenDate() {
        let periods1 = self.collection.periodsIntersected(byDate: date(dateString: "2010-01-20"))
        let periods2 = self.collection.periodsIntersected(byDate: date(dateString: "2010-03-02"))
        
        expect(periods1.count) == 3
        expect(periods1.periods).to(contain(monthPeriod, twoMonthsPeriod, twoMonthsPeriodAfterTwoWeeks))
        
        expect(periods2.count) == 1
        expect(periods2[0]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_periodsIntersectedByPeriod_returnsAllPeriodsThatIntersectWithGivenPeriod() {
        let periods1 = self.collection.periodsIntersected(byPeriod: TimePeriod(size: .week, amount: 5, startingAt: self.startDate.dateBySubtracting(days: 5), calendar: self.calendar))
        let periods2 = self.collection.periodsIntersected(byPeriod: TimePeriod(size: .week, amount: 1, startingAt: self.twoMonthsPeriod.endDate, calendar: self.calendar))
        
        expect(periods1.count) == 3
        expect(periods1.periods).to(contain(monthPeriod, twoMonthsPeriod, twoMonthsPeriodAfterTwoWeeks))
        
        expect(periods2.count) == 3
        expect(periods2.periods).to(contain(twoMonthsPeriod, monthPeriodAfterMonth, twoMonthsPeriodAfterTwoWeeks))
    }
    
    func testPeriodCollection_periodsOverlappedByPeriod_returnsAllPeriodsOverlappedByGivenPeriod() {
        let periods1 = self.collection.periodsOverlapped(byPeriod: TimePeriod(size: .month, amount: 2, startingAt: self.startDate.dateBySubtracting(months: 1), calendar: self.calendar))
        let periods2 = self.collection.periodsOverlapped(byPeriod: TimePeriod(size: .week, amount: 1, startingAt: self.twoMonthsPeriod.endDate, calendar: self.calendar))
        
        expect(periods1.count) == 3
        expect(periods1.periods).to(contain(monthPeriod, twoMonthsPeriod, twoMonthsPeriodAfterTwoWeeks))
        
        expect(periods2.count) == 1
        expect(periods2.periods).to(contain(twoMonthsPeriodAfterTwoWeeks))
    }

    // MARK: - Helper methods
    func createTimePeriodWithMonthSize(amount: Int, startingAt: Date) -> TimePeriod {
        return TimePeriod(size: .month, amount: amount, startingAt: startingAt, calendar: self.calendar)
    }
}
