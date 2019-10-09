//
//  TimeAgoTests.swift
//  DateTools
//
//  Created by David Gileadi on 1/24/17.
//  Copyright © 2017 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import XCTest
import Nimble
@testable import DateTools

class TimeAgoTests: XCTestCase {

	var formatter: DateFormatter!
    var date0: Date!
    var date1: Date!

	override func setUp() {
        super.setUp()

		self.formatter = DateFormatter()
        self.formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
        self.date0 = self.formatter.date(from: "2014 11 05 18:15:12.000")!
        self.date1 = self.formatter.date(from: "2014 11 07 18:15:12.000")!
    }

	func testBasicLongTimeAgo() {
        let now = self.date0.timeAgo(since: self.date0)
        expect(now).toNot(beEmpty(), description: "'Now' is nil or empty.")

		let ago = self.date1.timeAgo(since: self.date0)
        expect(ago).toNot(beEmpty(), description: "Ago is nil or empty.")
    }

	func testLongTimeAgo2Days() {
        self.date0 = self.formatter.date(from: "2014 11 05 18:15:12.000")!
        let ago = self.date0.timeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("2 days ago")
    }

	func testLongTimeAgo1DayAndHalf() {
        self.date0 = self.formatter.date(from: "2014 11 06 9:15:12.000")!
        let ago = self.date0.timeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("Yesterday")
    }

	func testLongTimeAgoExactlyYesterday() {
        self.date0 = self.formatter.date(from: "2014 11 06 18:15:12.000")!
        let ago = self.date0.timeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("Yesterday")
    }

	func testLongTimeAgoLessThan24hoursButYesterday() {
        self.date0 = self.formatter.date(from: "2014 11 06 20:15:12.000")!
        let ago = self.date0.timeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("22 hours ago")
    }

	func testLongTimeAgoLessThan24hoursSameDay() {
        self.date0 = self.formatter.date(from: "2014 11 07 10:15:12.000")!
        let ago = self.date0.timeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("8 hours ago")
    }

	func testLongTimeAgoBetween24And48Hours() {
        self.date0 = self.formatter.date(from: "2014 11 07 10:15:12.000")!
        self.date1 = self.formatter.date(from: "2014 11 08 18:15:12.000")!
        let ago = self.date0.timeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("Yesterday")
    }

	func testBasicShortTimeAgo() {
        let now = self.date0.shortTimeAgo(since: self.date0)
        expect(now).toNot(beEmpty(), description: "'Now' is nil or empty.")

		let ago = self.date1.shortTimeAgo(since: self.date0)
        expect(ago).toNot(beEmpty(), description: "Ago is nil or empty.")
    }

	func testShortTimeAgo2Days() {
        self.date0 = self.formatter.date(from: "2014 11 05 18:15:12.000")!
        let ago = self.date0.shortTimeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("2d")
    }

	func testShortTimeAgo1DayAndHalf() {
        self.date0 = self.formatter.date(from: "2014 11 06 9:15:12.000")!
        let ago = self.date0.shortTimeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("1d")
    }

	func testShortTimeAgoExactlyYesterday() {
        self.date0 = self.formatter.date(from: "2014 11 06 18:15:12.000")!
        let ago = self.date0.shortTimeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("1d")
    }

	func testShortTimeAgoLessThan24hoursButYesterday() {
        self.date0 = self.formatter.date(from: "2014 11 06 20:15:12.000")!
        let ago = self.date0.shortTimeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("22h")
    }

	func testShortTimeAgoLessThan24hoursSameDay() {
        self.date0 = self.formatter.date(from: "2014 11 07 10:15:12.000")!
        let ago = self.date0.shortTimeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("8h")
    }

	func testShortTimeAgoBetween24And48Hours() {
        self.date0 = self.formatter.date(from: "2014 11 07 10:15:12.000")!
        self.date1 = self.formatter.date(from: "2014 11 08 18:15:12.000")!
        let ago = self.date0.shortTimeAgo(since: self.date1)
        expect(ago) == DateToolsLocalizedStrings("1d")
    }

	func testLongTimeAgoLocalizationsAccessible() {
        let en_local = "Yesterday"
        let ja_local = "昨日"

		let key = en_local

		let url = Bundle(for: TimePeriodCollection.self).bundleURL.appendingPathComponent("DateTools.bundle/ja.lproj")
        let bundle = Bundle(url: url)

		expect(bundle).toNot(beNil())

		if (bundle != nil) {
            let ja_result = NSLocalizedString(key, tableName: "DateTools", bundle: bundle!, comment: key)

			expect(ja_local) == ja_result
        }
    }

}
