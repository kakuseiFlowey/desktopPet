const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const vm = require("node:vm");

const root = path.resolve(__dirname, "..");

function loadQmlJavaScript(relativePath, imports = {}) {
    const source = fs.readFileSync(path.join(root, relativePath), "utf8")
        .replace(/^\.pragma library\s*/m, "")
        .replace(/^import .*$/gm, "");
    const context = { ...imports };
    vm.runInNewContext(source, context, { filename: relativePath });
    return context;
}

const dates = loadQmlJavaScript("services/DateService.js");
const provider = loadQmlJavaScript("content/ContentProvider.js");
const data = loadQmlJavaScript("content/data/anniversaries.js");
const anniversary = loadQmlJavaScript("content/AnniversaryProvider.js", {
    DateService: dates,
    ContentProvider: provider,
    AnniversaryData: data
});

assert.equal(dates.keyForDate(new Date(2024, 1, 29)), "02-29");
assert.equal(dates.keyForDate(new Date(2025, 10, 20)), "11-20");
assert.equal(dates.formatJapaneseDate(new Date(2025, 10, 20)), "11月20日");
assert.equal(dates.isLeapYear(2000), true);
assert.equal(dates.isLeapYear(1900), false);
assert.equal(dates.isLeapYear(2024), true);
assert.equal(dates.daysInYear(2023), 365);
assert.equal(dates.daysInYear(2024), 366);
assert.equal(Object.keys(data.entries).length, 366);
assert.equal(data.entries["01-02"].title, "初夢の日");
assert.equal(data.entries["02-29"].title, "閏日");
assert.ok(Object.values(data.entries).every(entry => entry.description.endsWith("だよ。")));

const childrenDayDate = new Date(2025, 10, 20);
const childrenDay = anniversary.createContent(
    childrenDayDate,
    dates.keyForDate(childrenDayDate),
    data.entries,
    provider.createContent
);
assert.equal(childrenDay.id, "today_11-20");
assert.equal(childrenDay.category, "anniversary");
assert.equal(childrenDay.dialogue.length, 2);
assert.match(childrenDay.dialogue[0].text, /世界こどもの日/);

const fallbackDate = new Date(2025, 0, 2);
const fallback = anniversary.createContent(
    fallbackDate,
    dates.keyForDate(fallbackDate),
    {},
    provider.createContent
);
assert.equal(fallback.category, "daily");
assert.equal(fallback.dialogue.length, 2);

assert.throws(
    () => provider.createContent("empty", "test", "Empty", []),
    /at least one dialogue line/
);

console.log("Content and date tests passed.");
