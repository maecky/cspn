/**
 * @file
 *
 * @brief       Customized QML Checkbox
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

import QtQuick 2.5
import QtQuick.Controls 2.2
import "style.js" as Style

CheckBox {

    indicator: Rectangle {
        implicitWidth: parent.height
        implicitHeight: implicitWidth

        x: parent.leftPadding
        y: parent.height / 2 - height / 2
        radius: 3
        border.color: Style.style_green_light

        Rectangle {
            width: parent.width - 6
            height: parent.height - 6
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2
            radius: 2
            color: Style.style_green_light
            visible: parent.parent.checked
        }
    }
}
