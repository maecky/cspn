/**
 * @file
 *
 * @brief       Masternode Delegate
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

    Rectangle {
        anchors.fill: parent

        radius: 100
        border.color: (role_status ? Style.style_green_light_transparent : Style.style_red_transparent)
        border.width: 2
    }

    Image {
        id: masternode_Icon
        width: 50
        height: width

        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.verticalCenter: parent.verticalCenter

        source: (role_status ? "icons/masternode-active-64px.svg" : "icons/masternode-error-64px.svg")
    }

    Text {
        id: masternode_NameText

        text: role_name
        font.pointSize: 17

        anchors.left: masternode_Icon.right
        anchors.leftMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -10
    }

    Text {
        id: masternode_AddressText

        text: role_address
        font.pointSize: 11
        color: Style.style_grey_dark

        anchors.left: masternode_Icon.right
        anchors.leftMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 15
    }

    Text {
        id: masternode_IpAddressText

        text: role_ipaddress
        font.pointSize: 11
        color: Style.style_grey_dark

        anchors.left: masternode_AddressText.right
        anchors.leftMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 15
    }
}
