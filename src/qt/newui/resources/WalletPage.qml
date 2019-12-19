/**
 * @file
 *
 * @brief       Wallet Page
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
    id: walletPage

    Row {
        anchors.fill: parent

        Column {
            id: walletPage_FirstColumn
            width: parent.width * (8 / 24)
            height: parent.height - 10

            y: 0

            spacing: 10

            /** Wallet Overview: balance, incoming/outgoing etc.
             */
            WalletOverview {
                id: walletPage_WalletOverview

                height: 230

                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8
            }

            /** Brief history of recent transactions
             */
            ShortTransactionHistory {
                id: walletPage_TransactionHistory

                height: parent.height - parent.spacing - walletPage_WalletOverview.height

                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8
            }
        }

        Item {
            id: walletPage_SecondColum
            width: parent.width * (6 / 24)
            height: parent.height - 10

            y: 0

            Text {
                id: walletPage_MyWalletAddresses
                height: contentHeight

                anchors.left: parent.left
                anchors.leftMargin: 1
                anchors.right: parent.right
                anchors.top: parent.top

                text: "My wallet addresses"
            }

            Rectangle {
                id: walletPage_AddressesRectangle

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: walletPage_MyWalletAddresses.bottom
                anchors.topMargin: 2
                anchors.bottom: parent.bottom

                color: Style.style_white

                border.width: 4
                border.color: Style.style_light
                radius: 6
            }

            /*  Primary Address

                Show the 'primary address', as chosen by the User
                The user can copy the address to clipboard by pressing
                on it.
            */
            Rectangle {
                id: walletPage_PrimaryAddress

                height: 60

                anchors.top: walletPage_AddressesRectangle.top
                anchors.topMargin: 10
                anchors.right: walletPage_AddressesRectangle.right
                anchors.rightMargin: 10
                anchors.left: walletPage_AddressesRectangle.left
                anchors.leftMargin: 10

                border.width: 1
                border.color: Style.style_green_dark
                radius: 4
                color: Style.style_light

                Image {
                    id: walletPage_PrimaryAddressIcon

                    height: parent.height * 0.7
                    width: height

                    anchors.left: parent.left
                    anchors.leftMargin: 13
                    anchors.verticalCenter: parent.verticalCenter

                    source: "icons/page-wallet-64px.svg"
                }

                Text {
                    id: walletPage_PrimaryAddressLabel

                    y: walletPage_PrimaryAddressIcon.y
                    height: contentHeight

                    anchors.left: walletPage_PrimaryAddressIcon.right
                    anchors.leftMargin: 7
                    anchors.right: parent.right

                    text: "My primary address"
                    color: Style.style_grey_dark
                    font.pointSize: 9

                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                }

                Text {
                    id: walletPage_PrimaryAddressText

                    height: contentHeight

                    anchors.left: walletPage_PrimaryAddressIcon.right
                    anchors.leftMargin: 7
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: walletPage_PrimaryAddressLabel.bottom
                    anchors.topMargin: 4

                    text: cWalletModel.primaryAddress
                    font.pointSize: 10

                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                }

                MouseArea {
                    anchors.fill: parent

                    cursorShape: Qt.PointingHandCursor;

                    onPressed: {
                        console.log("[WalletPage] Copied primary address to clipboard")
                        cClipboard.setText(walletPage_PrimaryAddressText.text)
                    }
                }
            }

            /** Address Folder List
             */
            AddressFolderList {
                id: walletPage_AddressFolderList

                anchors.left: walletPage_AddressesRectangle.left
                anchors.leftMargin: walletPage_AddressesRectangle.border.width
                anchors.right: walletPage_AddressesRectangle.right
                anchors.rightMargin: walletPage_AddressesRectangle.border.width
                anchors.top: walletPage_PrimaryAddress.bottom
                anchors.topMargin: 5
                anchors.bottom: walletPage_AddressesRectangle.bottom
                anchors.bottomMargin: walletPage_AddressesRectangle.border.width

                folderSourceModel: cAddressFolderListModel

                onSearchTextChanged: {
                    applyAddressFilter(searchText);
                }

                onCurrentFolderItemChanged: {
                    applyAddressFilter(searchText);
                }
            }

            /** Green indicator for currently selected folder
             */
            Rectangle {
                y: (walletPage_AddressFolderList.currentFolderItem != null ? walletPage_AddressFolderList.y + walletPage_AddressFolderList.currentFolderItemY : 0)

                width: walletPage_AddressesRectangle.border.width
                height: (walletPage_AddressFolderList.currentFolderItem != null ? walletPage_AddressFolderList.currentFolderItem.height : 0)

                anchors.right: parent.right

                color: Style.style_green_light

                /*  Only show if there are any folders  */
                visible: (walletPage_AddressFolderList.currentFolderItem != null)
            }
        }

        Item {
            id: walletPage_ThirdColumn

            y: walletPage_AddressesRectangle.y

            width: parent.width * (10 / 24)
            height: parent.height - y

            /** Current Folder name
             */
            TextInput {
                id: walletPage_CurrentFolderName

                height: contentHeight

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 15
                anchors.top: parent.top

                clip: true

                text: (walletPage_AddressFolderList.currentFolderItem != null ? walletPage_AddressFolderList.currentFolderItem.name : "-")
                font.pixelSize: remToPx(2.0)
            }

            /** Address List
             */
            AddressList {
                id: walletPage_AddressList

                anchors.left: parent.left
                anchors.leftMargin: walletPage_CurrentFolderName.anchors.leftMargin
                anchors.right: parent.right
                anchors.top: walletPage_CurrentFolderName.bottom
                anchors.topMargin: 10
                anchors.bottom: walletPage_AddAddressButton.top
                anchors.bottomMargin: 10

                addressSourceModel: cAddressListModel
            }

            /** Green button to add a new address
             */
            Rectangle {
                id: walletPage_AddAddressButton

                width: Math.max(parent.width, parent.height) * 0.13
                height: width

                anchors.right: parent.right
                anchors.bottom: parent.bottom

                radius: width / 2

                color: (walletPage_AddressButton_MouseArea.pressed ? Style.style_green_dark : Style.style_green_light)

                Image {
                    width: parent.width * 0.6
                    height: width

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    sourceSize.width: Math.max(width, 10)
                    sourceSize.height: Math.max(height, 10)
                    source: "image://svg/:icons/add-24px.svg"
                }

                MouseArea {
                    id: walletPage_AddressButton_MouseArea

                    anchors.fill: parent

                    onClicked: {
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        applyAddressFilter("");
    }

    function applyAddressFilter(searchText)
    {
        var currentFolder = (walletPage_AddressFolderList.currentFolderItem != null ? walletPage_AddressFolderList.currentFolderItem.name : "")

        var folders = walletPage_AddressList.applyAddressFilter(searchText, currentFolder);

        walletPage_AddressFolderList.applyFolderFilter(folders);
    }
}
