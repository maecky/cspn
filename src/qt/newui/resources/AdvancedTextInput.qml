/**
 * @file
 *
 * @brief       Advanced version of the QML TextInput type
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

import QtQuick 2.5
import QtQuick.Controls 2.2
import "config.js" as Config

Item {
    id: root

    property string placeholderText: ""
    property alias text: input.text
    property alias textColor: input.color
    property alias textEchoMode: input.echoMode
    property alias fontSize: input.font.pixelSize
    property string iconSource: ""
    property bool underline: true

    TextInput {
        id: input

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: (root.iconSource.length > 0 ? icon.right : root.left)
        anchors.leftMargin: (root.iconSource.length > 0 ? 5 : 1)
        anchors.right: parent.right
        anchors.rightMargin: 5

        text: ""
        color: root.textColor
        wrapMode: TextInput.NoWrap
        clip: true

        Text {
            text: root.placeholderText
            visible: !(parent.text.length > 0)
            font.pixelSize: parent.font.pixelSize
            color: Config.color.gray.dark
        }
    }

    Image {
        id: icon
        width: height
        height: parent.height - 5

        visible: (root.iconSource.length > 0)

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 3
        source: root.iconSource
    }

    Rectangle {
        id: line
        height: remToPx(0.2)
        color: (input.activeFocus ? Config.color.primary : Config.color.gray.dark)
        visible: parent.underline

        anchors.top: input.bottom
        anchors.topMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
    }

    function forceFocus()
    {
        input.forceActiveFocus()
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
