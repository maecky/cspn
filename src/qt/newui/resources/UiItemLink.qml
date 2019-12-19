/**
 * @file
 *
 * @brief       General UI Link (i.e. to a page)
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

Rectangle {
    id: root

    width: 300
    height: 60

    border.width: 1
    border.color: Config.color.gray.light
    radius: sDim(Config.ui.radius.sm)
    color: Config.color.white

    property alias text: uiItemLink_Text.text
    property alias textColor: uiItemLink_Text.color
    property alias description: uiItemLink_Description.text
    property alias descriptionColor: uiItemLink_Description.color

    property alias iconSource: uiItemLink_Icon.source

    property alias buttonText: uiItemLink_Button.text

    property int padding: sDim(Config.ui.padding.sm)

    /*
        Icon
    */
    Image {
        id: uiItemLink_Icon

        width: height
        height: parent.height - (2 * parent.padding)

        source: ""

        anchors.left: parent.left
        anchors.leftMargin: padding

        anchors.verticalCenter: parent.verticalCenter
    }
    /*
        Title
    */
    Text {
        id: uiItemLink_Text
        height: font.pixelSize

        text: ""
        anchors.right: uiItemLink_Button.left
        anchors.rightMargin: 5
        font.pixelSize: remToPx(1)

        anchors.left: uiItemLink_Icon.right
        anchors.leftMargin: parent.padding

        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: (-1 * height) * 0.7
    }
    /*
        Description
    */
    Text {
        id: uiItemLink_Description

        text: ""
        anchors.rightMargin: 5
        font.pixelSize: remToPx(0.85)
        color: Config.color.gray.dark

        anchors.left: uiItemLink_Icon.right
        anchors.leftMargin: parent.padding

        anchors.right: uiItemLink_Button.left

        anchors.top: uiItemLink_Text.bottom
        anchors.topMargin: sDim(Config.ui.margin.xs)
    }
    /*
        Call to action button
    */
    CustomButton {
        id: uiItemLink_Button

        width: parent.width * 0.25
        height: parent.height - (2 * parent.padding)
        text: "Open"

        anchors.right: parent.right
        anchors.rightMargin: parent.padding

        anchors.verticalCenter: parent.verticalCenter

        onClicked: {
            parent.activated()
        }
    }

    signal activated()
}



/*##^## Designer {
    D{i:2;anchors_width:142}
}
 ##^##*/
