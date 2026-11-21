import QtQuick
import QtTest
import "../services/DateService.js" as DateService
import "../content/ContentProvider.js" as ContentProvider
import "../content/AnniversaryProvider.js" as AnniversaryProvider
import "../content/data/anniversaries.js" as AnniversaryData

TestCase {
    name: "AnniversaryContent"

    function test_dateService() {
        compare(DateService.keyForDate(new Date(2024, 1, 29)), "02-29")
        compare(DateService.keyForDate(new Date(2025, 10, 20)), "11-20")
        compare(DateService.formatJapaneseDate(new Date(2025, 10, 20)), "11月20日")
        verify(DateService.isLeapYear(2000))
        verify(!DateService.isLeapYear(1900))
        compare(DateService.daysInYear(2024), 366)
        compare(Object.keys(AnniversaryData.entries).length, 366)
        compare(AnniversaryData.entries["01-02"].title, "初夢の日")
        compare(AnniversaryData.entries["02-29"].title, "閏日")

        var conversationalDescriptions = true
        for (var key in AnniversaryData.entries) {
            if (!AnniversaryData.entries[key].description.endsWith("だよ。")) {
                conversationalDescriptions = false
                break
            }
        }
        verify(conversationalDescriptions)
    }

    function test_anniversaryContent() {
        var date = new Date(2025, 10, 20)
        var content = AnniversaryProvider.createContent(
                    date,
                    DateService.keyForDate(date),
                    AnniversaryData.entries,
                    ContentProvider.createContent)
        compare(content.id, "today_11-20")
        compare(content.category, "anniversary")
        compare(content.dialogue.length, 2)
        verify(content.dialogue[0].text.indexOf("世界こどもの日") !== -1)

        date = new Date(2025, 0, 2)
        content = AnniversaryProvider.createContent(
                    date,
                    DateService.keyForDate(date),
                    AnniversaryData.entries,
                    ContentProvider.createContent)
        compare(content.title, "初夢の日")
        compare(content.category, "anniversary")

        content = AnniversaryProvider.createContent(
                    date,
                    DateService.keyForDate(date),
                    {},
                    ContentProvider.createContent)
        compare(content.category, "daily")
    }
}
