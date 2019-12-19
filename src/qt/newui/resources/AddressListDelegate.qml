/**
 * @file
 *
 * @brief       Address List Delegate
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

    /** Address Label text
     */
    TextInput {
        id: addressDelegate_Name

        height: contentHeight
        width: parent.width * 0.5

        anchors.top: parent.top
        anchors.left: parent.left

        text: role_label
    }

    /** Actual Address
     */
    Text {
        id: addressDelegate_Address

        height: font.pixelSize

        anchors.left: parent.left
        anchors.right: addressDelegate_CopyItem.left
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom

        text: role_address
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
    }

    /** Copy icon
     */
    Image {
        id: addressDelegate_CopyItem

        height: addressDelegate_Address.height
        width: height

        anchors.right: parent.right
        anchors.bottom: parent.bottom

        source: ""

        MouseArea {
            anchors.fill: parent.fill

            onClicked: {
                console.log("[AddressListDelegate] Copied address to clipboard");
                cClipboard.setText(addressDelegate_Address.text);

                /*  Display a tooltip after the user copies the address    */
                ToolTip.show("Copied to clipboard", 500);
            }
        }
    }
}
