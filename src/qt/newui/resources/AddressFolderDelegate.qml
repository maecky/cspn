/**
 * @file
 *
 * @brief       Address Folder Delegate
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

import QtQuick 2.6
import QtQuick.Controls 2.2
import "style.js" as Style

Item {

    property alias name: addressFolderDelegate_Name.text

    /** Folder Name
     */
    Text {
        id: addressFolderDelegate_Name

        height: font.pixelSize

        anchors.left: parent.left
        anchors.leftMargin: 13
        anchors.right: parent.right
        anchors.rightMargin: 13
        anchors.top: parent.top
        anchors.topMargin: 4

        text: role_name
        font.pixelSize: remToPx(0.7)
        color: (parent.ListView.isCurrentItem ? Style.style_green_light : Style.style_grey_dark)

        maximumLineCount: 1
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
    }

    /** Number of addresses in Folder
     */
    Text {
        anchors.left: parent.left
        anchors.leftMargin: 13
        anchors.right: parent.right
        anchors.rightMargin: 13
        anchors.top: addressFolderDelegate_Name.bottom
        anchors.topMargin: 10

        text: qsTr("%1 Addresses").arg(role_count)
        font.pixelSize: remToPx(1.0)

        wrapMode: Text.NoWrap
        elide: Text.ElideRight
    }

    /** Background rectangle, visible when folder is selected or mouse hovers on top of it
     */
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: addressFolderDelegate_Separator.top

        opacity: 0.4
        layer.enabled: true

        visible: (parent.ListView.isCurrentItem || addressFolderDelegate_MouseArea.containsMouse)
        color: Style.style_light
    }

    /** Separator for the Folder items
     */
    Rectangle {
        id: addressFolderDelegate_Separator

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        height: 2

        color: Style.style_light
    }

    MouseArea {
        id: addressFolderDelegate_MouseArea

        anchors.fill: parent

        hoverEnabled: true

        onClicked: {
            parent.ListView.view.currentIndex = parent.ListView.view.indexAt(parent.x, parent.y);
        }
    }
}
