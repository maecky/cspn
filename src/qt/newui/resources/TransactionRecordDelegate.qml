/**
 * @file
 *
 * @brief       Transaction history list delegate
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
import org.bitg 1.0

Item {
    property bool confirmed: (role_status === TransactionListModel.STATUS_CONFIRMED)
    property int confirmationsNeeded: (role_type === TransactionListModel.TYPE_STAKE_MINT || role_type === TransactionListModel.TYPE_GENERATED ? 21 : 6)

    property bool dropDown: !confirmed

    height: (dropDown ? 80 : 30)

    /*  Image showing the 'type' of transaction, i.e. minted, masternode reward, incoming etc.
     */
    Image {
        id: transactionRecord_TypeImage

        width: 25
        height: width

        anchors.left: parent.left
        anchors.top: parent.top

        source: {
            var src = "";
            if(role_type === TransactionListModel.TYPE_OTHER)
            {
            }
            else if(role_type === TransactionListModel.TYPE_GENERATED)
            {
                /*  mining icon */
                src = "icons/mining-64px.svg"
            }
            else if(role_type === TransactionListModel.TYPE_SEND_TO_ADDRESS || role_type === TransactionListModel.TYPE_SEND_TO_OTHER)
            {
                src = "icons/outgoing-24px.svg";
            }
            else if(role_type === TransactionListModel.TYPE_RECV_WITH_ADDRESS || role_type === TransactionListModel.TYPE_RECV_FROM_OTHER)
            {
                src = "icons/incoming-24px.svg";
            }
            else if(role_type === TransactionListModel.TYPE_SEND_TO_SELF)
            {
                src = "icons/outgoing-24px.svg";
            }
            else if(role_type === TransactionListModel.TYPE_STAKE_MINT)
            {
                /*  mining icon */
                src = "icons/mining-64px.svg"
            }
            else
            {
                console.log("[TransactionRecordDelegate] Warning: transaction type " + role_type + " not recognized!");
            }
            src;
        }
    }

    /** Image displayed when transaction is not confirmed yet
     */
    Image {
        id: transactionRecord_StatusImage

        width: 20
        height: width

        visible: !confirmed

        anchors.left: transactionRecord_TypeImage.right
        anchors.leftMargin: 5
        anchors.top: parent.top

        source: "icons/confirming-24px.svg"
    }

    /** Address / Label
     */
    Text {
        id: transactionRecord_Address

        width: contentWidth
        height: contentHeight

        anchors.left: (confirmed ? transactionRecord_TypeImage.right : transactionRecord_StatusImage.right)
        anchors.leftMargin: (confirmed ? 5 : 3)
        anchors.top: parent.top
        anchors.topMargin: 1

        text: (role_label.length > 0 ? role_label : role_address)
        color: Style.style_grey_dark
        font.pointSize: 12
    }

    /** Small clock icon
     */
    Image {
        id: transactionRecord_DateTimeIcon

        width: 15
        height: 15

        anchors.left: transactionRecord_Address.right
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 3

        source: "icons/clock-24px.svg"
    }

    /** DateTime indication
     */
    Text {
        id: transactionRecord_DateTime

        width: contentWidth
        height: contentHeight

        anchors.left: transactionRecord_DateTimeIcon.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 3

        text: niceDateTimeString(role_datetime)
        color: Style.style_grey_dark
        font.pointSize: 10
    }

    /** Amount
     */
    Text {
        id: transactionRecord_Amount

        width: contentWidth
        height: contentHeight

        anchors.right: transactionRecord_DropDownButton.left
        anchors.rightMargin: 10
        anchors.top: parent.top

        text: formatAmount(role_amount)
        color: (role_amount >= 0 ? Style.style_green_light : Style.style_orange)
        horizontalAlignment: Text.AlignRight
        font.pointSize: 13
    }

    /** Dropdown button
     */
    HoverButton {
        id: transactionRecord_DropDownButton

        width: 20
        height: 20

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 3

        imageTopAnchor: 0
        imageWidth: width
        imageHeight: height
        imageSource: (dropDown ? "icons/expand-less-24px.svg" : "icons/expand-more-24px.svg")

        onActivated: {
            dropDown = !dropDown;
        }
    }

    /** Dropdown item
     */
    Item {
        id: transactionRecord_DropDownItem

        anchors.left: transactionRecord_TypeImage.right
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.top: transactionRecord_Address.bottom
        anchors.topMargin: 2
        anchors.bottom: parent.bottom

        visible: dropDown

        /** Transaction Id
         */
        Text {
            id: transactionRecord_TxId

            height: contentHeight

            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: parent.right

            text: role_txid
            maximumLineCount: 1
            elide: Text.ElideRight
            font.pointSize: 9
            color: Style.style_grey_light

            /*  Pressing on the text copies it to clipboard    */
            MouseArea {
                /*  The txId item is a lot longer than the actual text. Ensure that only
                  actually pressing on the text results in a Press event. Additionally, this also
                  improves the ToolTip positioning */
                width: parent.contentWidth

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                onPressed: {
                    console.log("[TransactionRecordDelegate] Copied txId to clipboard");
                    cClipboard.setText(parent.text);

                    /*  Display a tooltip after the user copies the txId    */
                    ToolTip.show("Copied to clipboard", 500);
                }
            }
        }

        /** Confirmation progressbar
         */
        CustomProgressBar {
            id: transactionRecord_ConfirmationBar

            height: 7
            width: 150

            anchors.left: parent.left
            anchors.top: transactionRecord_TxId.bottom
            anchors.topMargin: 8

            value: (confirmed ? 1.0 : role_depth / confirmationsNeeded)
        }

        /** Confirmation label
         */
        Text {
            id: transactionRecord_ConfirmationText

            width: contentWidth
            height: contentHeight

            anchors.left: parent.left
            anchors.top: transactionRecord_ConfirmationBar.bottom
            anchors.topMargin: 2

            visible: dropDown
            text: (confirmed ? qsTr("Confirmed") : qsTr("%1 of %2 confirmations").arg(role_depth).arg(confirmationsNeeded))
            font.pointSize: 7
        }

    }

}
