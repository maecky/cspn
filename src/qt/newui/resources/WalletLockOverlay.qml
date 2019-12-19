/**
 * @file
 *
 * @brief       Wallet Lock/Unlock Overlay
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

Popup {
    id: lockPopup
    width: 480
    height: 320

    background: Rectangle {
        radius: 7
    }

    function closePopup()
    {
        lockPopup.close()
    }

    Text {
        id: lockOverlay_Title
        text: qsTr("Secure your wallet")
        font.pointSize: 27

        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: lockOverlay_Description
        width: 213
        height: 15
        text: qsTr("Lock or unlock your wallet")
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 12

        anchors.top: lockOverlay_Title.bottom
        anchors.topMargin: 11
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: lockOverlay_LockButton
        width: 70
        height: 35
        anchors.horizontalCenterOffset: -35

        anchors.top: lockOverlay_Description.bottom
        anchors.topMargin: 42
        anchors.horizontalCenter: parent.horizontalCenter

        clip: true

        property bool active: true

        Rectangle {
            anchors.fill: parent
            anchors.rightMargin: -radius
            radius: 12
            color: (parent.active ? Style.style_green_light : Style.style_light)
            border.width: (parent.active ? 0 : 2)
            border.color: Style.style_grey_light

            opacity: 1.0

            Text {
                text: qsTr("Lock")

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -3
            }
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                if(!parent.active)
                {
                    lockWallet();
                }
            }
        }
    }

    Item {
        id: lockOverlay_UnlockButton
        width: 70
        height: 35
        anchors.horizontalCenterOffset: 35

        anchors.top: lockOverlay_Description.bottom
        anchors.topMargin: 42
        anchors.horizontalCenter: parent.horizontalCenter

        clip: true

        property bool active: false

        Rectangle {
            anchors.fill: parent
            anchors.leftMargin: -radius
            radius: 12
            color: (parent.active ? Style.style_green_light : Style.style_light)
            border.width: (parent.active ? 0 : 2)
            border.color: Style.style_grey_light

            opacity: 1.0

            Text {
                text: qsTr("Unlock")

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 3
            }
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                if(!parent.active)
                {
                    /*  Shift focus to the password edit  */
                    lockOverlay_PasswordInput.forceFocus();
                }
            }
        }
    }

    Text {
        x: 36
        y: 177
        width: 100
        height: 19

        text: qsTr("Locked")
        color: (lockOverlay_LockButton.active ? "#66cc00" : "#ff3333")
        font.pointSize: 13

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Item {
        id: lockOverlay_UnlockItem
        x: 310
        y: 84
        width: 135
        height: 168

        enabled: !lockOverlay_UnlockButton.active

        Image {
            x: 26
            width: 59
            height: 61
            anchors.top: parent.top
            anchors.topMargin: 1
            anchors.horizontalCenter: parent.horizontalCenter
            source: ""
            fillMode: Image.PreserveAspectFit
        }

        AdvancedTextInput {
            id: lockOverlay_PasswordInput
            y: 68
            height: 25

            placeholderText: "Password"
            textColor: Style.style_grey_dark
            textEchoMode: TextInput.Password
            iconSource: "icons/search-24px.svg"

            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 1
        }

        CustomCheckBox {
            id: lockOverlay_StakingOnly

            y: 103
            height: 20

            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            text: qsTr("Staking only")
            font.pointSize: 8
        }


        Button {
            x: 18
            y: 134

            text: qsTr("Confirm")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 7
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter

            width: 80
            height: 25

            visible: (lockOverlay_PasswordInput.text.length > 0)

            onPressed: {
                /*  Try to unlock wallet */
                const password = lockOverlay_PasswordInput.text;
                const stakingOnly = lockOverlay_StakingOnly.checked;
                unlockWallet(password, stakingOnly);

                lockOverlay_PasswordInput.text = "";
            }
        }
    }

    function lockWallet()
    {
        console.log("[WalletLockOverlay] Locking wallet");

        lockOverlay_LockButton.active = true;
        lockOverlay_UnlockButton.active = false;
    }

    function unlockWallet(password, stakingOnly)
    {
        console.log("[WalletLockOverlay] Attempting to unlock wallet");

        lockOverlay_LockButton.active = false;
        lockOverlay_UnlockButton.active = true;
    }
}















/*##^## Designer {
    D{i:2;anchors_y:25}D{i:3;anchors_y:66}D{i:5;anchors_y:66}D{i:4;anchors_y:25}D{i:12;anchors_y:25}
D{i:14;anchors_y:0}D{i:15;anchors_x:51;anchors_y:0}D{i:16;anchors_width:87;anchors_x:53;anchors_y:97}
D{i:17;anchors_width:87;anchors_x:53;anchors_y:97}D{i:18;anchors_width:87;anchors_x:53;anchors_y:97}
D{i:13;anchors_y:66}
}
 ##^##*/
