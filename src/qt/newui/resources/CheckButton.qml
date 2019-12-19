/**
 * @file
 *
 * @brief       Button-Style / CheckBox item
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

Item {

    property bool checked: false

    property alias text: checkButton_Text.text
    property alias font: checkButton_Text.font
    property alias textHeight: checkButton_Text.contentHeight
    property alias textWidth: checkButton_Text.contentWidth

    Rectangle {
        id: checkButton_Background

        anchors.fill: parent

        color: (checked ? Style.style_green_light : Style.style_white)

        border.color: Style.style_grey_light
        border.width: (checked ? 0 : 2)

        radius: 17
    }

    Text {
        id: checkButton_Text

        anchors.fill: parent

        text: ""
        color: (checked ? Style.style_white : Style.style_grey_dark)

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        id: checkButton_MouseArea

        anchors.fill: parent

        onPressed: {
            checked = !checked;

            if(checked)
            {
                selected();
            }
            else
            {
                deselected();
            }
        }
    }

    signal selected();
    signal deselected();
}
