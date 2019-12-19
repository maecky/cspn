/**
 * @file
 *
 * @brief       Home Page providing an overview
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
    id: homePage
    width: 950
    height: 500

    Row {
        anchors.fill: parent
        clip: false

        Column {
            id: homePage_firstColumn

            width: parent.width / 3
            height: parent.height - 10
            y: 0

            spacing: 10

            /** Wallet Overview: balance, incoming/outgoing etc.
             */
            WalletOverview {
                id: homePage_WalletOverview

                height: 230

                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8
            }

            /** Brief history of recent transactions
             */
            ShortTransactionHistory {
                id: homePage_TransactionHistory

                height: parent.height - parent.spacing - homePage_WalletOverview.height

                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8
            }
        }

        Column {
            id: homePage_secondColumn

            width: parent.width / 3
            height: parent.height - 10
            y: 0

            spacing: 20

            /** Community Updates
             */
            Item {
                id: homePage_CommunityUpdatesItem

                height: (parent.height - parent.spacing) / 3

                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 5

                /** Title
                 */
                Text {
                    id: homePage_communityUpdates_Title

                    width: contentWidth
                    height: contentHeight

                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    text: "Community Updates"
                    font.pointSize: 13
                }
            }

            /** News Items
             */
            Item {
                id: homePage_NewsItem

                height: 2 * (parent.height - parent.spacing) / 3

                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5

                /** Title
                 */
                Text {
                    id: homePage_News_Title

                    width: contentWidth
                    height: contentHeight

                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5

                    text: "Latest from the team"
                    font.pointSize: 13
                }

                /** List with actual news items
                 */
                ListView {
                    id: homePage_News_List

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: homePage_News_Title.bottom
                    anchors.topMargin: 6
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 6

                    spacing: 6

                    flickableDirection: Flickable.VerticalFlick
                    boundsBehavior: Flickable.StopAtBounds
                    clip: true

                    model: cNewsModel

                    delegate: NewsDelegate {
                        width: parent.width
                        height: 55
                    }
                }
            }
        }

        Column {
            id: homePage_ThirdColumn

            width: parent.width / 3
            height: parent.height - 10

            y: 0

            spacing: 20

            /** Participation information item
             */
            Item {
                id: homePage_ParticipateItem

                height: 160

                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 8

                Rectangle {
                    color: Style.style_light
                    anchors.fill: parent
                }

                /** Header
                 */
                Text {
                    id: homePage_Participate_Text

                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: parent.top
                    anchors.topMargin: 10

                    text: "Participate in the BitGreen ecosystem today"

                    font.pointSize: 16

                    elide: Text.ElideNone
                    wrapMode: Text.WordWrap
                }

                /** Description
                 */
                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.top: homePage_Participate_Text.bottom
                    anchors.topMargin: 5

                    text: "There are a number of ways you can get involved and be an active member of the community."
                    color: Style.style_grey_dark

                    font.pointSize: 10

                    elide: Text.ElideNone
                    wrapMode: Text.WordWrap
                }

                CustomButton {
                    width: 130
                    height: 30

                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10

                    text: "Get Involved"
                    font.pointSize: 11

                    onPressed: {
                    }
                }
            }

            /** Security information item
             */
            Item {
                id: homePage_SecurityItem
                height: 150

                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8

                Rectangle {
                    id: homePage_SecurityItem_Top

                    x: 0
                    y: 0
                    width: parent.width
                    height: 35

                    color: Style.style_red

                    Image {
                        id: homePage_SecurityItem_Icon

                        height: 22
                        width: 19

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 12

                        sourceSize.width: width
                        sourceSize.height: height
                        source: "image://svg/:icons/lock-64px.svg #ffffff"
                    }

                    Text {
                        width: 193
                        height: 18

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: homePage_SecurityItem_Icon.right
                        anchors.leftMargin: 16

                        text: qsTr("Security Health Check")
                        color: Style.style_light
                        font.pointSize: 13
                    }
                }

                Rectangle {
                    x: 0
                    y: homePage_SecurityItem_Top.height
                    width: parent.width
                    height: parent.height - homePage_SecurityItem_Top.height

                    color: Style.style_light
                }
            }

            /** Reminders item
             */
            Item {
                id: homePage_RemindersItem
                height: 150

                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8

                Rectangle {
                    id: homePage_RemindersItem_Top

                    x: 0
                    y: 0
                    width: parent.width
                    height: 35

                    color: Style.style_yellow

                    Image {
                        id: homePage_RemindersItem_Icon

                        height: 22
                        width: 22

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 12

                        source: "icons/error-outline-24px.svg"
                    }

                    Text {
                        width: 193
                        height: 18

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: homePage_RemindersItem_Icon.right
                        anchors.leftMargin: 16

                        text: qsTr("Reminders")
                        color: Style.style_grey_dark
                        font.pointSize: 13
                    }
                }

                Rectangle {
                    x: 0
                    y: homePage_RemindersItem_Top.height
                    width: parent.width
                    height: parent.height - homePage_RemindersItem_Top.height

                    color: Style.style_light
                }
            }
        }
    }
}

