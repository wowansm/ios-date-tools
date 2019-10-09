//
//  DateTestUtils.swift
//  DateTools
//
//  Created by Paweł Sękara on 07.10.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import Foundation

let secondPrecisionFormatter = createFormatterWithFormat(format: "yyyy-MM-dd HH:mm:ss")
let minutePrecisionFormatter = createFormatterWithFormat(format: "yyyy-MM-dd HH:mm")
let hourPrecisionFormatter = createFormatterWithFormat(format: "yyyy-MM-dd HH")
let dayPrecisionFormatter = createFormatterWithFormat(format: "yyyy-MM-dd")

func date(dateString: String) -> Date {
    for formatter in [secondPrecisionFormatter, minutePrecisionFormatter, hourPrecisionFormatter, dayPrecisionFormatter] {
        if let date = formatter.date(from: dateString) {
            return date
        }
    }
    return Date(timeIntervalSince1970: 0)
}

private func createFormatterWithFormat(format: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
}
