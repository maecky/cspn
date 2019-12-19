/**
 * @file
 *
 * @brief       Customized QML Switch
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

import QtQuick 2.5
import QtQuick.Controls 2.2
import "config.js" as Config

Switch {
    indicator: Rectangle {
        width: parent.width
        height: parent.height

        x: parent.leftPadding
        y: (parent.height / 2) - (height / 2)

        radius: parent.height / 2

        color: parent.checked ? Config.color.success : Config.color.danger

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor;
        }

        Rectangle {
            x: parent.parent.checked ? parent.width-(width-1) : 1
            y: 1

            width: parent.parent.height - 2
            height: width

            radius: width / 2

            color: Config.color.light
            border.width: 0

            Image {
                source: Config.dir.icons + "lock-64px.svg"
                x: width * 0.1
                y: x
                width: parent.width * 0.8
                height: width
            }

//            transitions: Transition {
//                NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
//            }
        }
    }
}
