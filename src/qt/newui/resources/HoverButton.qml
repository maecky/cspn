/**
 * @file
 *
 * @brief       Customized Icon+Text button
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
    property alias text: hoverButton_Text.text

    property int imageTopAnchor: sDim(Config.ui.padding.xs)

    property alias imageWidth: hoverButton_Image.width
    property alias imageHeight: hoverButton_Image.height
    property alias imageSource: hoverButton_Image.source


    /*
        Background
    */
    Rectangle {
        anchors.fill: parent

        //opacity: 0.4
        layer.enabled: true
        color: Config.color.primary
        radius: sDim(Config.ui.radius.md)

        visible: hoverButton_MouseArea.containsMouse
    }

    Image {
        id: hoverButton_Image

        width: (parent.height / 2)
        height: width

        anchors.top: parent.top
        anchors.topMargin: parent.imageTopAnchor
        anchors.horizontalCenter: parent.horizontalCenter

        source: ""
    }

    Text {
        id: hoverButton_Text

        color: (hoverButton_MouseArea.containsMouse ? Config.color.white : Config.color.black)

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: hoverButton_Image.bottom
        anchors.topMargin: sDim(Config.ui.margin.xs)

        visible: (text.length > 0)

        text: ""
        font.capitalization: Font.AllUppercase
        font.pixelSize: remToPx(0.8)
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea {
        id: hoverButton_MouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor;

        onClicked: {
            parent.activated();
        }
    }

    signal activated()
}
