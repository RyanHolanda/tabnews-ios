@testable import TabNews
import XCTest

final class DateExtensionUnitTests: XCTestCase {
    func testCreateCustomDate() {
        let date: Date = .init(year: 2010, month: 10, day: 08, hour: 22, minute: 23)

        XCTAssertTrue(date.ISO8601Format() == "2010-10-08T22:23:00Z")
    }

    func testGetTimeAgoYearsPlural() throws {
        let currentDate: Date = .init(year: 2020, month: 10, day: 08, hour: 22, minute: 23)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2010-09-02T20:47:31.295Z", to: currentDate)
        XCTAssert(timeAgo == "10 anos atrás")
    }

    func testGetTimeAgoYearSingle() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2016-10-08T00:00:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "1 ano atrás")
    }

    func testGetTimeAgoMonthsPlural() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2017-05-08T00:00:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "5 meses atrás")
    }

    func testGetTimeAgoMonthSingle() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2017-09-07T00:00:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "1 mês atrás")
    }

    func testGetTimeAgoDaysPlural() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2017-10-02T00:00:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "6 dias atrás")
    }

    func testGetTimeAgoDaySingle() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2017-10-07T00:00:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "1 dia atrás")
    }

    func testGetTimeAgoHoursPlural() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08, hour: 02, minute: 30)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2017-10-08T00:00:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "2 horas atrás")
    }

    func testGetTimeAgoHourSingle() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08, hour: 10, minute: 30)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2017-10-08T09:30:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "1 hora atrás")
    }

    func testGetTimeAgoMinutesPlural() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08, hour: 10, minute: 30)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2017-10-08T10:20:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "10 minutos atrás")
    }

    func testGetTimeAgoMinuteSingle() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08, hour: 10, minute: 30)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2017-10-08T10:29:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "1 minuto atrás")
    }

    func testGetTimeAgoJustNow() throws {
        let currentDate: Date = .init(year: 2017, month: 10, day: 08, hour: 10, minute: 30)

        let timeAgo: String = Date.getTimeAgo(fromISO: "2017-10-08T10:30:00.000Z", to: currentDate)
        XCTAssert(timeAgo == "Agora")
    }
}
