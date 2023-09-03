//
//  Date+Helper.swift
//  Agalia_Facility
//
//  Created by Nickelfox on 29/12/22.
//  Copyright © 2022 Nickelfox. All rights reserved.
//

import Foundation

enum TimeZones: String {
    case GMT
    
    var identifier: String {
        return self.rawValue
    }
}

enum DateFormat: String {
    
    case MMMMyyyy = "MMMM yyyy"
    case yyyyMMdd = "yyyy-MM-dd"
    case d = "d"
    case MMM = "MMM"
    case hmma = "h:mm a"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case dMMMyyyy = "d MMM yyyy"
    case ddMMyyyy = "dd/MM/yyyy"
    case MMyy = "MM/yy"
    case dMMMyyyyhmma = "d MMM yyyy, h:mm a"
    case MMMd = "MMM d"
    case MMMdyyyy = "MMM d, yyyy"
    case yyyy = "yyyy"
    case MMMdyyyyhhmma = "MMM d, yyyy hh:mm a"
    case custom = "E, d MMM yyyy HH:mm:ss"
    case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case HHmmss = "HH:mm:ss"
    case ha = "h a"
    case dMMM = "d MMM"
    case custom3 = "yyyy-MM-dd'T'HH:mm:ss"
    case custom1 = "dd-MMMM-yyyy"
    
    var string: String {
        return self.rawValue
    }
}

struct DateHelper {
    
    //static let dateFormatter = DateFormatter()
    
    
    public static func date(fromString string: String,
                            format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.string
        return dateFormatter.date(from: string)
    }
    
    public static func date(fromDate date: Date,
                            format: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.string
        return dateFormatter.string(from: date)
    }
    
    public static func dateWithTimeZone(fromDate date: Date,
                                        timeZone: TimeZones,
                                        format: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.string
        dateFormatter.timeZone = TimeZone(identifier: timeZone.identifier)
        return dateFormatter.string(from: date)
    }
    
    public static func dateWithTimeZoneString(fromDate date: Date,
                                        timeZone: String,
                                        format: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.string
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        return dateFormatter.string(from: date)
    }
    
    public static func isValidAge(ageString: String) -> Bool {
        let date = DateHelper.date(fromString: ageString,
                                   format: .dMMMyyyy) ?? Date()
        let maxDate = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
        return date <= maxDate
        
    }
    
    public static func isAgeBelow40(ageString: String) -> Bool {
        let date = DateHelper.date(fromString: ageString,
                                   format: .dMMMyyyy) ?? Date()
        let maxDate = Calendar.current.date(byAdding: .year, value: -40, to: Date()) ?? Date()
        return date >= maxDate
        
    }
    
    public static func getSecondsBetweenDates(from: Date, to: Date) -> Int {
        let component = Calendar.current.dateComponents([.second], from: from, to: to)
        return component.second ?? 0
    }
    
    public static func convert(dateString: String, fromFormat: DateFormat, toFormat: DateFormat) -> String? {
        guard let date = DateHelper.date(fromString: dateString,
                                         format: fromFormat) else {
            return nil
        }
        let convertDate = DateHelper.date(fromDate: date, format: toFormat)
        return convertDate
    }
    
    public static func convert(date: Date, format: DateFormat) -> Date {
        guard let dateString = DateHelper.date(fromDate: date,
                                               format: format) else {
            return Date()
        }
        let convertDate = DateHelper.date(fromString: dateString,
                                          format: format)
        return convertDate ?? Date()
    }
    
    public static func convertWithTimeZone(date: Date,
                                           timeZone: TimeZones,
                                           format: DateFormat) -> Date {
        guard let dateString = DateHelper.dateWithTimeZone(fromDate: date, timeZone: timeZone, format: format) else {
            return Date()
        }
        let convertDate = DateHelper.date(fromString: dateString,
                                          format: format)
        return convertDate ?? Date()
    }
    
    public static func compare(fromDate: String,
                               toDate: String) -> Bool {
        let fromDate = DateHelper.date(fromString: fromDate,
                                       format: .yyyyMMdd) ?? Date()
        let toDate = DateHelper.date(fromString: toDate,
                                     format: .yyyyMMdd) ?? Date()
        return fromDate.isEqualToDate(toDate)
    }
    
    public static func serverToLocalTime(date: String?) -> Date? {
        guard let serverDate = date,
              let stringToDate = self.date(fromString: serverDate,
                                           format: .yyyyMMddHHmmss) else {
            return nil
        }
        return stringToDate.toCurrentTimeZone()
    }
}

extension Date {
    func addMonth(_ value: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .month, value: value, to: self)!
    }
    
    func addDay(_ value: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .day, value: value, to: self)!
    }
    
    func addYear(_ value: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .year, value: value, to: self)!
    }
    
}

extension Date {
    func isEqualMonthYear(_ date: Date) -> Bool {
        let date = Calendar.current.dateComponents([.month, .year], from: date, to: self)
        return (date.month == 0 && date.year == 0)
    }
    
    func isEqualToDate(_ toDate: Date?) -> Bool {
        guard let toDate = toDate else { return false }
        // format both date to same format to get rid of time comparison
        let formattedSelfDate = DateHelper.convert(date: self,
                                                   format: .yyyyMMdd)
        let formattedToDate = DateHelper.convert(date: toDate,
                                                 format: .yyyyMMdd)
        
        return formattedSelfDate.compare(formattedToDate) == .orderedSame
    }
    
    var isToday: Bool {
        return Calendar.current.compare(self, to: Date(), toGranularity: .day) == .orderedSame
    }
    
    func adding(seconds: Int) -> Date {
        return Calendar.current.date(byAdding: .second,
                                     value: seconds,
                                     to: self)!
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute,
                                     value: minutes,
                                     to: self)!
    }
    
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour,
                                     value: hours,
                                     to: self)!
    }
    
    func adding(years: Int) -> Date {
        return Calendar.current.date(byAdding: .year,
                                     value: years,
                                     to: self)!
    }
    
    func hasGreaterThanEqualTo(_ date: Date) -> Bool {
        return self >= date
    }
    
    func hasLessThanEqualTo(_ date: Date) -> Bool {
        return self <= date
    }
    
    func hasGreaterThan(_ date: Date) -> Bool {
        return self > date
    }
    
    func hasLessThan(_ date: Date) -> Bool {
        return self < date
    }
    
    func minutesTill(date: Date) -> Int {
        let component = Calendar.current.dateComponents([.minute], from: self, to: date)
        return component.minute ?? 0
    }
    
    func secondsTill(date: Date) -> Int {
        let component = Calendar.current.dateComponents([.second], from: self, to: date)
        return component.second ?? 0
    }
    
//    func daysTill(date: Date) -> Int {
//        print(self.customFormattedDate())
//        print(date.customFormattedDate())
//        let component = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: self, to: date)
//        return component.day ?? 0
//    }
    
    func daysTill(date: Date) -> Int {

        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: self) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: date) else {
            return 0
        }
        return end - start
    }
}

extension Date {
    
    func formattedYear() -> String? {
        return DateHelper.date(fromDate: self, format: .yyyy)
    }
    
    func serverFormattedDate() -> String? {
        return DateHelper.date(fromDate: self, format: .yyyyMMdd)
    }
    
    func customFormattedDate() -> String? {
        return DateHelper.date(fromDate: self, format: .custom)
    }
    
    func fullDateWithTime() -> String? {
        return DateHelper.date(fromDate: self, format: .MMMdyyyyhhmma)
    }
    
    func MMMdyyyy() -> String? {
        return DateHelper.date(fromDate: self, format: .MMMdyyyy)
    }
}

extension Date {
    private func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
         let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
         return addingTimeInterval(delta)
    }
    
    func toUTCTimeZone() -> Date {
        let localTimeZone = TimeZone.current
        let utcTimeZone = TimeZone(abbreviation: "UTC")
        
        let utcTime = self.convertToTimeZone(initTimeZone: localTimeZone, timeZone: utcTimeZone!)
        return utcTime
    }
    
    func toCurrentTimeZone() -> Date {
        let localTimeZone = TimeZone.current
        let utcTimeZone = TimeZone(abbreviation: "UTC")
        
        let localTime = self.convertToTimeZone(initTimeZone: utcTimeZone!, timeZone: localTimeZone)
        return localTime
    }
}

// swiftlint:disable line_length
extension DateHelper {
    
    static func timeAgoSinceDate(_ date: Date, currentDate: Date, numericDates: Bool) -> String {
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = earliest == now ? date : now
        let components: DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute, NSCalendar.Unit.hour, NSCalendar.Unit.day, NSCalendar.Unit.weekOfYear, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if components.year! >= 2 {
            return "\(components.year!) years ago"
        } else if components.year! >= 1 {
            if numericDates {
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if components.month! >= 2 {
            return "\(components.month!) months ago"
        } else if components.month! >= 1 {
            if numericDates {
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if components.weekOfYear! >= 2 {
            return "\(components.weekOfYear!) weeks ago"
        } else if components.weekOfYear! >= 1 {
            if numericDates {
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if components.day! >= 2 {
            return "\(components.day!) days ago"
        } else if components.day! >= 1 {
            if numericDates {
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if components.hour! >= 2 {
            return "\(components.hour!) hours ago"
        } else if components.hour! >= 1 {
            if numericDates {
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if components.minute! >= 2 {
            return "\(components.minute!) minutes ago"
        } else if components.minute! >= 1 {
            if numericDates {
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if components.second! >= 3 {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    static func getDay(withDateString dateString: String, andFormat format: DateFormat) -> String {
        let chatdate = DateHelper.date(fromString: dateString, format: format) ?? Date()
        if Calendar.current.isDateInToday(chatdate) {
            return "Today"
        }
        
        if Calendar.current.isDateInYesterday(chatdate) {
            return "Yesterday"
        }
        
        return dateString
    }
    
    static func getDaysSimple(for month: Date) -> [Date] {
        
        //get the current Calendar for our calculations
        let cal = Calendar.current
        //get the days in the month as a range, e.g. 1..<32 for March
        let monthRange = cal.range(of: .day, in: .month, for: month)!
        //get first day of the month
        let comps = cal.dateComponents([.year, .month], from: month)
        //start with the first day
        //building a date from just a year and a month gets us day 1
        var date = cal.date(from: comps)!

        //somewhere to store our output
        var dates: [Date] = []
        //loop thru the days of the month
        for _ in monthRange {
            //add to our output array...
            dates.append(date)
            //and increment the day
            date = cal.date(byAdding: .day, value: 1, to: date)!
        }
        return dates
    }

}

extension DateHelper {
    static func convertTimeFrom(time timeString: String, format: DateFormat) -> String? {
        let separatedTimeComponents = timeString.components(separatedBy: ":").compactMap { Int($0) }
        let cal = Calendar.current
        let date = cal.date(bySettingHour: separatedTimeComponents[0], minute: separatedTimeComponents[1], second: 0, of: Date())
        return DateHelper.date(fromDate: date ?? Date(), format: format)
    }
}

extension Date {
    
    func day() -> Int {
        Calendar.current.component(.day, from: self)
    }
    
    func month() -> Int {
        Calendar.current.component(.month, from: self)
    }
    
    func year() -> Int {
        Calendar.current.component(.year, from: self)
    }
    
    func getWeekDates() -> [Date] {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: self)
        return calendar.range(of: .weekday, in: .weekOfYear, for: self)!.compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: self) }
//            .filter { !calendar.isDateInWeekend($0) }
    }
    
    func dateWithMonthName() -> String? {
        DateHelper.date(fromDate: self, format: .dMMM)
    }
    
    func dateYMD() -> String? {
        DateHelper.date(fromDate: self, format: .yyyyMMdd)
    }
    
    func year() -> String? {
        DateHelper.date(fromDate: self, format: .yyyy)
    }
    }


