.pragma library

function createContent(date, key, entries, contentFactory) {
    var entry = entries[key]
    var month = date.getMonth() + 1
    var day = date.getDate()

    if (!entry) {
        entry = {
            title: month + "月" + day + "日",
            description: "今日は" + month + "月" + day + "日。何気ない今日も、きみと過ごす大切な一日だよ。",
            category: "daily"
        }
    }

    return contentFactory(
                "today_" + key,
                entry.category || "anniversary",
                entry.title,
                [
                    { speaker: "pet", text: "今日は" + month + "月" + day + "日。" + entry.title + "だよ！" },
                    { speaker: "pet", text: entry.description }
                ],
                "talking")
}
