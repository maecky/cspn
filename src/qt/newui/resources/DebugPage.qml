/**
 * @file
 *
 * @brief       Debug Page
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
    id: debugPage
    objectName: "debugPage"

    width: 950
    height: 500

    Row {
        id: row
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        spacing: 20
        anchors.topMargin: 0
        anchors.fill: parent

        Column {
            id: firstColumn
            width: 280

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10

            Text {
                width: 246
                text: qsTr("Debug Console")
                anchors.left: parent.left
                anchors.leftMargin: 16
                font.pointSize: 27
            }
        }

        Column {
            id: column
            width: parent.width - 300
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20


            Rectangle {
                y: 0
                width: parent.width
                height: parent.height - 30

                color: Style.style_light

                TextEdit {
                    id: consoleText
                    anchors.fill: parent

                    readOnly: true
                    cursorVisible: false

                    leftPadding: 20
                    topPadding: 20
                    bottomPadding: 20
                    rightPadding: 10

                    font.pointSize: 12
                }
            }

            Rectangle {
                id: rectangle
                y: 440
                width: parent.width
                height: 30

                color: Style.style_grey_light


                TextInput {
                    id: consoleInput

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left

                    anchors.rightMargin: 5
                    anchors.leftMargin: 5

                    cursorVisible: true
                    font.pointSize: 15
                    selectionColor: Style.style_grey_dark

                    verticalAlignment: TextInput.AlignVCenter

                    onAccepted: {
                        if(text.length > 0)
                        {
                            var t = text;
                            text = "";    /*  clear text edit */

                            executeRpcCommand(t);
                        }
                    }
                }
            }
        }
    }

    signal rpcCommandRequested(string cmd)

    function executeRpcCommand(cmd)
    {
        /*  TODO: Make output prettier */

        consoleText.append(cmd);

        rpcCommandRequested(cmd);
    }

    Connections {
        target: cDebugConsole
        onResponseReceived: {
            handleRpcReply(category, message);
        }
    }

    function handleRpcReply(category, message)
    {
        consoleText.append(message);
    }
}
