.pragma library

function keyForDate(date) {
    var month = String(date.getMonth() + 1)
    var day = String(date.getDate())
    return (month.length < 2 ? "0" : "") + month + "-" + (day.length < 2 ? "0" : "") + day
}

function formatJapaneseDate(date) {
    return (date.getMonth() + 1) + "月" + date.getDate() + "日"
}

function isLeapYear(year) {
    return year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0)
}

function daysInYear(year) {
    return isLeapYear(year) ? 366 : 365
}
