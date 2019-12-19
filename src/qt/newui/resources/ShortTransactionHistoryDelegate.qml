/**
 * @file
 *
 * @brief       Short-Transaction history list delegate
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

    Text {
        id: shortHistoryItem_Address

        width: 60
        height: 20

        anchors.left: parent.left
        anchors.top: parent.top

        text: role_address
        font.pointSize: 11

        elide: Text.ElideNone
        wrapMode: Text.WordWrap
    }

    Text {
        id: shortHistoryItem_Amount

        height: contentHeight
        width: contentWidth

        anchors.right: parent.right
        anchors.top: parent.top

        text: formatAmount(role_amount)
        color: (role_amount > 0 ? Style.style_green_light : Style.style_orange)
        horizontalAlignment: Text.AlignRight
    }

    Image {
        id: shortHistoryItem_TimeIcon

        anchors.left: parent.left
        anchors.top: shortHistoryItem_Address.bottom
        anchors.topMargin: 1

        width: 7
        height: 7

        source: ""
    }

    Text {
        id: shortHistoryItem_Time

        anchors.left: shortHistoryItem_TimeIcon.right
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.top: shortHistoryItem_Address.bottom
        anchors.topMargin: 1

        text: niceDateTimeString(role_datetime)
        font.pointSize: 10
    }
}
