/**
 * @file
 *
 * @brief       Wallet Overview
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
import QtQuick.Window 2.2
import "style.js" as Style

Item {
    Rectangle {
        anchors.fill: parent

        color: Style.style_light
        border.color: Style.style_grey_light
        radius: 5
    }

    Image {
        id: walletOverview_Image

        width: 100
        height: width

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 17

        source: "icons/bitg-circled-64px.svg"
    }

    Item {
        id: walletOverview_BalanceItem

        width: 140
        height: walletOverview_Image.height

        anchors.left: walletOverview_Image.right
        anchors.leftMargin: 25
        anchors.top: parent.top
        anchors.topMargin: 17

        /** Total Balance description
         */
        Text {
            id: walletOverview_TotalBalanceLabel

            height: 18

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            text: "Total Balance"
            font.pointSize: 11
            color: Style.style_grey_dark
        }

        /** Total Balance indication
         */
        Text {
            id: walletOverview_TotalBalance

            height: 35
            width: contentWidth

            anchors.left: parent.left
            anchors.top: walletOverview_TotalBalanceLabel.bottom
            anchors.topMargin: 1

            text: "-"
            font.pointSize: 22
        }

        /** Available Description
         */
        Text {
            id: walletOverview_AvailableLabel

            height: contentHeight
            width: contentWidth

            anchors.left: parent.left
            anchors.top: walletOverview_TotalBalance.bottom
            anchors.topMargin: 6

            text: "Available"
            font.pointSize: 10
        }

        /** Available indication
         */
        Text {
            height: contentHeight
            width: contentWidth

            anchors.right: parent.right
            anchors.verticalCenter: walletOverview_AvailableLabel.verticalCenter

            text: "-"
            font.pointSize: 10
        }

        /** Unconfirmed description
         */
        Text {
            id: walletOverview_UnconfirmedLabel

            height: contentHeight
            width: contentWidth

            anchors.left: parent.left
            anchors.top: walletOverview_AvailableLabel.bottom
            anchors.topMargin: 2

            text: "Unconfirmed"
            font.pointSize: 10
        }

        /** Unconfirmed indication
         */
        Text {
            height: contentHeight
            width: contentWidth

            anchors.right: parent.right
            anchors.verticalCenter: walletOverview_UnconfirmedLabel.verticalCenter

            text: "-"
            font.pointSize: 10
        }

        /** Locked description
         */
        Text {
            id: walletOverview_LockedLabel

            height: contentHeight
            width: contentWidth

            anchors.left: parent.left
            anchors.top: walletOverview_UnconfirmedLabel.bottom
            anchors.topMargin: 2

            text: "Locked"
            font.pointSize: 10
        }

        /** Lock image
         */
        Image {
            height: 13
            width: 13

            anchors.left: walletOverview_LockedLabel.right
            anchors.leftMargin: 3
            anchors.verticalCenter: walletOverview_LockedLabel.verticalCenter
            anchors.verticalCenterOffset: 1

            source: "icons/lock-64px.svg"
        }

        /** Locked indication
         */
        Text {
            height: contentHeight
            width: contentWidth

            anchors.right: parent.right
            anchors.verticalCenter: walletOverview_LockedLabel.verticalCenter

            text: "-"
            font.pointSize: 10
        }
    }

    Image {
        id: walletOverview_IncomingOutgoingIcon

        width: 24
        height: width

        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: walletOverview_BalanceItem.bottom
        anchors.topMargin: 6

        source: "icons/import-export-24px.svg"
    }

    Text {
        height: contentHeight

        anchors.left: walletOverview_IncomingOutgoingIcon.right
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.verticalCenter: walletOverview_IncomingOutgoingIcon.verticalCenter

        text: "Past 30 days"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        color: Style.style_grey_light
        font.pointSize: 10
    }

    Item {
        id: walletOverview_Incoming

        height: walletOverview_IncomingBarText.height + 1 + walletOverview_IncomingBar.height

        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.top: walletOverview_IncomingOutgoingIcon.bottom
        anchors.topMargin: 5

        Text {
            id: walletOverview_IncomingBarText

            height: contentHeight

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            text: "Incoming"
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 9
        }

        CustomProgressBar {
            id: walletOverview_IncomingBar

            height: 12

            anchors.left: parent.left
            anchors.right: walletOverview_IncomingText.left
            anchors.rightMargin: 4
            anchors.top: walletOverview_IncomingBarText.bottom
            anchors.topMargin: 1

            value: 0.5

            color: Style.style_green_light
            backgroundColor: Style.style_grey_light
        }

        Text {
            id: walletOverview_IncomingText

            width: 30
            height: contentHeight

            anchors.right: parent.right
            anchors.verticalCenter: walletOverview_IncomingBar.verticalCenter

            text: "-"
            horizontalAlignment: Text.AlignRight
            font.pointSize: 9
        }
    }

    Item {
        id: walletOverview_Outgoing

        height: walletOverview_OutgoingBarText.height + 1 + walletOverview_OutgoingBar.height

        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.top: walletOverview_Incoming.bottom
        anchors.topMargin: 8

        Text {
            id: walletOverview_OutgoingBarText

            height: contentHeight

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            text: "Outgoing"
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 9
        }

        CustomProgressBar {
            id: walletOverview_OutgoingBar

            height: 12

            anchors.left: parent.left
            anchors.right: walletOverview_OutgoingText.left
            anchors.rightMargin: 4
            anchors.top: walletOverview_OutgoingBarText.bottom
            anchors.topMargin: 1

            value: 0.5

            color: Style.style_orange
            backgroundColor: Style.style_grey_light
        }

        Text {
            id: walletOverview_OutgoingText

            width: 30
            height: contentHeight

            anchors.right: parent.right
            anchors.verticalCenter: walletOverview_OutgoingBar.verticalCenter

            text: "-"
            horizontalAlignment: Text.AlignRight
            font.pointSize: 9
        }
    }

}
