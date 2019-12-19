/**
 * @file
 *
 * @brief       Customized QML ProgressBar
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

ProgressBar {
//    padding: 1

    /*
        Default colors
    */
    property string color: Config.color.primary
    property string backgroundColor: Config.color.gray.dark

    background: Rectangle {
        color: parent.backgroundColor
        radius: parent.height / 2

        antialiasing: true
    }

    contentItem: Item {
        Rectangle {
            width: parent.parent.visualPosition * parent.width
            height: parent.height
            radius: height / 2
            color: parent.parent.color

            antialiasing: true
        }
    }
}
