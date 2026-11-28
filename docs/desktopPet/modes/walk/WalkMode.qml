import QtQuick
import QtQuick.Layouts
import "../../components"

Item {
    id: root

    property bool active: false
    property real maximumDialogueHeight: 100
    property real characterSize: 220
    property string currentPrompt: qsTr("一緒にお散歩しよう")
    property var prompts: [
        qsTr("近くの公園まで歩いてみよう"),
        qsTr("交差点を3回曲がって知らない景色を探そう"),
        qsTr("川や池が見える場所まで歩こう"),
        qsTr("10分だけ遠回りして帰ろう"),
        qsTr("遠くに見える高い建物のふもとまで行こう"),
        qsTr("緑が多い場所を探してみよう"),
        qsTr("知らない植物の名前を調べてみよう"),
        qsTr("ベンチのある場所まで歩いて、座ろう"),
        qsTr("赤いものを3つ見つけよう"),
        qsTr("鳥の鳴き声を聞いてみよう"),
        qsTr("面白い形の雲を探してみよう"),
        qsTr("今日の空の写真を撮ってみよう"),
        qsTr("変わった看板を見つけよう"),
        qsTr("猫か犬を見つけよう"),
        qsTr("ここで一句"),
        qsTr("近くの本屋さんに入ってみよう"),
        qsTr("一番大きな木を探してみよう"),
        qsTr("食べ歩きできそうなものを買ってみよう"),
        qsTr("コンビニで気になるお菓子を1つ選ぼう"),
        qsTr("飲んだことのない飲み物を試してみよう"),
        qsTr("飲み物を買って一休みしよう"),
        qsTr("お気に入りのおやつを見つけよう"),
        qsTr("地元のお店を1軒のぞいてみよう"),
        qsTr("駅周辺のお店を1軒のぞいてみよう"),
        qsTr("早歩きとかしてみる？"),
        qsTr("深呼吸を5回してみよう"),
        qsTr("大きくジャンプしてみよう"),
        qsTr("立ち止まって空を30秒眺めよう"),
        qsTr("近くの木に触れてみよう"),
        qsTr("今日の思い出を1枚だけ撮ろう"),
        qsTr("きれいだと思った景色を探して、写真に残そう"),
        qsTr("意味不明な言葉を探してみよう"),
        qsTr("落ち葉を1枚観察してみよう"),
        qsTr("一番静かな場所を探してみよう"),
        qsTr("一番にぎやかな場所を探してみよう"),
        qsTr("水辺の生き物を探してみよう"),
        qsTr("散歩中に季節を感じるものを見つけよう"),
        qsTr("景色のいい場所で少し休憩しよう")
    ]

    function choosePrompt() {
        if (!prompts || prompts.length === 0)
            return

        var candidates = []
        for (var i = 0; i < prompts.length; ++i) {
            if (prompts[i] !== currentPrompt)
                candidates.push(prompts[i])
        }
        if (candidates.length === 0)
            return

        currentPrompt = candidates[Math.floor(Math.random() * candidates.length)]
    }

    clip: true

    WalkBackground {
        x: walkPet.x
        y: walkPet.y - walkPet.height * 0.3
        width: walkPet.width
        height: walkPet.height * 1.0
        active: root.active
        touchAnimationActive: walkPet.touchAnimationActive
        z: 0
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 14
        z: 1

        SpeechBubble {
            Layout.fillWidth: true
            maximumTextHeight: root.maximumDialogueHeight
            text: root.currentPrompt
        }

        WalkPet {
            id: walkPet
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 180
            active: root.active
            characterSize: root.characterSize
        }

        PrimaryActionButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: Math.min(240, root.width - 48)
            Layout.preferredHeight: 48
            text: qsTr("お題をもらう")
            onClicked: root.choosePrompt()
        }
    }
}
