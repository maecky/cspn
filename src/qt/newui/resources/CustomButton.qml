/**
 * @file
 *
 * @brief       Customized QML Button
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

Button {
    font.capitalization: Font.AllUppercase

    property int radius: 3

    contentItem: Text {
        text: parent.text
        font: parent.font
        elide: Text.ElideRight

        color: {
            if(!enabled) {
                return Config.color.gray.dark;
            }
            else {
                return Config.color.white;
            }
        }

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        color: {
            if(!enabled) {
                return Config.color.gray.light;
            }
            else if(parent.down) {
                return Qt.darker(Config.color.primary, 2);
            }
            else {
                return Config.color.primary;
            }
        }
        radius: parent.radius
    }
}
