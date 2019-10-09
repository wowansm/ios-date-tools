//
//  TimePeriodTests+Relationships.swift
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

	// MARK: - Relationship methods
    func testTimePeriod_relationToPeriodAfter_returnsAfterPeriodRelation() {
        expect(self.longPeriod.relationTo(period: self.periodBefore)) == TimePeriodRelation.after
    }

	func testTimePeriod_relationToPeriodStartTouching_returnsStartTouchingPeriodRelation() {
        expect(self.periodAfterTouching.relationTo(period: self.longPeriod)) == TimePeriodRelation.startTouching
    }

	func testTimePeriod_relationToPeriodStartInside_returnsStartInsidePeriodRelation() {
        let startInsidePeriod = TimePeriod(startDate: calendar.date(year: 1800), endDate: calendar.date(year: 1950), calendar: calendar)
        expect(self.longPeriod.relationTo(period: startInsidePeriod)) == TimePeriodRelation.startInside
    }

	func testTimePeriod_relationToPeriodInsideStartTouching_returnsInsideStartTouchingPeriodRelation() {
        let insideTouchingPeriod = TimePeriod(startDate: date(dateString: "1900-06-15"), endDate: date(dateString: "2020-01-10"), calendar: self.calendar)
        expect(self.longPeriod.relationTo(period: insideTouchingPeriod)) == TimePeriodRelation.insideStartTouching
    }

	func testTimePeriod_relationToPeriodEnclosingStartTouching_returnsEnclosingStartTouchingPeriodRelation() {
        let enclosingStartTouching = TimePeriod(startDate: date(dateString: "1900-06-15"), endDate: calendar.date(year: 1950), calendar: calendar)
        expect(self.longPeriod.relationTo(period: enclosingStartTouching)) == TimePeriodRelation.enclosingStartTouching
    }

	func testTimePeriod_relationToPeriodEnclosing_returnsEnclosingPeriodRelation() {
        expect(self.longPeriod.relationTo(period: self.periodInside)) == TimePeriodRelation.enclosing
    }

	func testTimePeriod_relationToPeriodEnclosingEndTouching_returnsEnclosingEndTouchingRelation() {
        let enclosingEndTouching = TimePeriod(startDate: calendar.date(year: 1910), endDate: calendar.date(year: 2000), calendar: calendar)
        expect(self.longPeriod.relationTo(period: enclosingEndTouching)) == TimePeriodRelation.enclosingEndTouching
    }

	func testTimePeriod_relationToPeriodExactMatch_returnsExactMatchRelation() {
        expect(self.longPeriod.relationTo(period: self.longPeriod)) == TimePeriodRelation.exactMatch
    }

	func testTimePeriod_relationToPeriodInside_returnsInsideRelation() {
        expect(self.periodInside.relationTo(period: self.longPeriod)) == TimePeriodRelation.inside
    }

	func testTimePeriod_relationToPeriodInsideEndTouching_returnsInsideEndTouchingRelation() {
        let insideEndTouching = TimePeriod(startDate: calendar.date(year: 1850), endDate: calendar.date(year: 2000), calendar: calendar)
        expect(self.longPeriod.relationTo(period: insideEndTouching)) == TimePeriodRelation.insideEndTouching
    }

	func testTimePeriod_relationToPeriodEndInside_returnsEndInsideRelation() {
        expect(self.longPeriod.relationTo(period: self.periodAfterOverlaps)) == TimePeriodRelation.endInside
    }

	func testTimePeriod_relationToPeriodEndTouching_returnsEndTouchingRelation() {
        expect(self.longPeriod.relationTo(period: self.periodAfterTouching)) == TimePeriodRelation.endTouching
    }

	func testTimePeriod_relationToPeriodBefore_returnsBeforeRelation() {
        expect(self.longPeriod.relationTo(period: self.periodAfter)) == TimePeriodRelation.before
    }

	func testTimePeriod_relationToInvalidPeriod_returnsNoneRelation() {
        let invalidPeriod = TimePeriod(startDate: calendar.date(year: 2010), endDate: calendar.date(year: 1990), calendar: calendar)
        expect(self.longPeriod.relationTo(period: invalidPeriod)) == TimePeriodRelation.none
    }
}
