/**
 * @file
 *
 * @brief       Settings Page
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

Item {
    id: settingsPage
    width: 950
    height: 500

    Text {
        id: titleText
        width: 310
        height: 36
        text: qsTr("Configuration and Utilities")
        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.top: parent.top
        anchors.topMargin: 16
        font.pointSize: 27
    }

    Row {
        id: row
        anchors.top: titleText.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 10

        Column {
            id: column
            width: 400
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 19
            anchors.top: parent.top
            anchors.topMargin: 0

            Item {
                id: element
                height: 150
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10

                Text {
                    id: element1
                    x: 97
                    y: 22
                    width: 207
                    height: 29
                    text: qsTr("Debug Console")
                    font.pointSize: 20
                }

                Button {
                    id: debugButton
                    x: 97
                    y: 98
                    width: 123
                    height: 29
                    text: qsTr("Go")
                    font.pointSize: 11

                    onPressed: {
                        switchPage("Debug");
                    }
                }

                Text {
                    id: element2
                    x: 97
                    y: 50
                    width: 272
                    height: 42
                    text: qsTr("Use the console to execute commands within the wallet")
                    wrapMode: Text.WordWrap
                    font.pointSize: 12
                }
            }
        }
    }



}







/*##^## Designer {
    D{i:1;anchors_height:464;anchors_width:624;anchors_x:8;anchors_y:16}D{i:4;anchors_width:200}
D{i:2;anchors_height:410;anchors_width:901;anchors_x:32;anchors_y:77}
}
 ##^##*/
