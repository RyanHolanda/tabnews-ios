import Foundation

extension Date {
    init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0) {
        var dateComponents: DateComponents = .init()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.timeZone = .gmt

        self = Calendar.current.date(from: dateComponents) ?? Date()
    }

    static func getTimeAgo(fromISO: String, to todate: Date) -> String {
        let dateFormatter: ISO8601DateFormatter = .init()
        dateFormatter.formatOptions = [.withFractionalSeconds, .withInternetDateTime]

        guard let formattedDate = dateFormatter.date(from: fromISO) else {
            return String(localized: .localizable.nA)
        }

        let dateDifference: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: formattedDate, to: todate)

        if let years = dateDifference.year, years != 0 {
            return String(localized: .localizable.dateExtensionYearAgo(years))
        }

        if let months = dateDifference.month, months != 0 {
            return String(localized: .localizable.dateExtensionMonthAgo(months))
        }

        if let days = dateDifference.day, days != 0 {
            return String(localized: .localizable.dateExtensionDayAgo(days))
        }

        if let hours = dateDifference.hour, hours != 0 {
            return String(localized: .localizable.dateExtensionHourAgo(hours))
        }

        if let minutes = dateDifference.minute, minutes != 0 {
            return String(localized: .localizable.dateExtensionMinuteAgo(minutes))
        }

        return String(localized: .localizable.justNow)
    }
}
