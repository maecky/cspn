/**
 * @file
 *
 * @brief       Compact Transaction History
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

import QtQuick 2.5
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "style.js" as Style

Item {
    Text {

        id: shortHistory_Title

        width: contentWidth
        height: contentHeight

        text: "Recent Transactions"
        font.pointSize: 14

        anchors.left: parent.left
        anchors.top: parent.top
    }

    ListView {
        id: shortHistory_ListView

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: shortHistory_Title.bottom
        anchors.topMargin: 15
        anchors.bottom: shortHistory_Button.top
        anchors.bottomMargin: 5

        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        spacing: 5
        clip: true

        delegate: ShortTransactionHistoryDelegate {
            width: parent.width
            height: 40
        }

        model: cTransactionModel
    }

    CustomButton {
        id: shortHistory_Button

        width: 120
        height: 30

        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom

        text: "View History"
        font.pointSize: 11

        onPressed: {
            switchPage("TransactionHistory");
        }
    }
}
