/**
 * @file
 *
 * @brief       Masternode Management Page
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "style.js" as Style

Item {
    id: masternodesPage
    width: 950
    height: 500

    Text {
        id: masternodes_TitleText
        width: 310
        height: 36

        text: qsTr("Manage Masternodes")
        font.pointSize: 27
        color: Style.style_green_light

        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    ListView {
        id: masternodes_ListView

        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.right: masternodes_InfoColumn.left
        anchors.rightMargin: 50
        anchors.top: masternodes_TitleText.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50

        spacing: 5
        clip: true

        delegate: MasternodeDelegate {
            width: parent.width
            height: 75
        }

        model: cMasternodeModel
    }

    /*  If there are no masternodes, show a label...
    */
    Text {
        text: "It seems like you don't have any masternodes..."

        width: 100

        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.right: masternodes_InfoColumn.left
        anchors.rightMargin: 50
        anchors.top: masternodes_TitleText.bottom
        anchors.topMargin: 20

        elide: Text.ElideNone
        wrapMode: Text.WordWrap

        visible: cMasternodeModel.numMasternodes === 0
    }

    Item {
        id: masternodes_InfoColumn

        width: 280

        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10

        Rectangle {
            id: masternodes_GovernanceRectangle

            height: 200

            color: Style.style_light

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Image {
            width: 25
            height: width

            anchors.left: masternodes_GovernanceRectangle.left
            anchors.leftMargin: 5
            anchors.top: masternodes_GovernanceRectangle.top
            anchors.topMargin: 40

            source: ""
        }

        Text {
            id: masternodes_GovernanceText

            text: "Have your say"

            font.pointSize: 20
            color: Style.style_black

            elide: Text.ElideNone
            wrapMode: Text.WordWrap

            anchors.left: masternodes_GovernanceRectangle.left
            anchors.leftMargin: 50
            anchors.right:  masternodes_GovernanceRectangle.right
            anchors.rightMargin: 15
            anchors.top: masternodes_GovernanceRectangle.top
            anchors.topMargin: 15
        }

        Text {
            text: "As a masternode owner, you have the ability to vote for any network proposals."

            font.pointSize: 11
            color: Style.style_grey_dark

            elide: Text.ElideNone
            wrapMode: Text.WordWrap

            anchors.left: masternodes_GovernanceRectangle.left
            anchors.leftMargin: 50
            anchors.right:  masternodes_GovernanceRectangle.right
            anchors.rightMargin: 15
            anchors.top: masternodes_GovernanceText.bottom
            anchors.topMargin: 15
        }

        CustomButton {
            width: 120
            height: 35

            anchors.left: masternodes_GovernanceRectangle.left
            anchors.leftMargin: 50
            anchors.bottom: masternodes_GovernanceRectangle.bottom
            anchors.bottomMargin: 20

            text: "Vote now"

            onPressed: {
                /*  For now, go to the debug page. In the future we'll have
                    a proper governance tab...
                */
                switchPage("Debug");
            }
        }

        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: masternodes_GovernanceRectangle.bottom
            anchors.topMargin: 30

            Text {
                id: masternodes_CountText

                text: "Masternodes"

                font.pointSize: 13

                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.top: parent.top
            }

            CircularProgressBar {
                id: masternodes_EnabledProgressBar

                value: (cClientModel.numMasternodesEnabled / cClientModel.numMasternodes)
                centerText: "Total\n" + cClientModel.numMasternodes

                width: 90
                height: width

                anchors.top: masternodes_CountText.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 25
            }

            Rectangle {
                id: masternodes_EnabledRectangle

                width: 13
                height: width

                radius: width / 2

                color: Style.style_green_light

                anchors.top: masternodes_CountText.bottom
                anchors.topMargin: 25
                anchors.left: masternodes_EnabledProgressBar.right
                anchors.leftMargin: 15
            }

            Text {
                id: masternodes_EnabledText

                text: "Enabled"

                font.pointSize: 12

                anchors.top: masternodes_CountText.bottom
                anchors.topMargin: 22
                anchors.left: masternodes_EnabledRectangle.right
                anchors.leftMargin: 8
            }

            Text {
                text: cClientModel.numMasternodesEnabled

                font.pointSize: 20

                anchors.top: masternodes_EnabledText.bottom
                anchors.topMargin: 2
                anchors.left: masternodes_EnabledRectangle.right
                anchors.leftMargin: 8
            }
        }
    }
}
