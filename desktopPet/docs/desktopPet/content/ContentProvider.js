.pragma library

function createContent(id, category, title, dialogue, animation) {
    if (!id || !category || !title || !dialogue || dialogue.length === 0)
        throw new Error("Content requires an id, category, title, and at least one dialogue line.")

    return {
        id: id,
        category: category,
        title: title,
        dialogue: dialogue,
        animation: animation || "idle"
    }
}
