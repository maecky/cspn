/**
 * @file
 *
 * @brief       Customized QML Calendar Item
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

import QtQuick 2.6
import QtQml 2.1
import QtQuick.Controls 1.4 as QQC1
import QtQuick.Controls.Styles 1.4 as QQC1S
import "style.js" as Style

QQC1.Calendar {
    id: calendar

    frameVisible: false
    navigationBarVisible: true

    style: QQC1S.CalendarStyle {

        gridVisible: false

        navigationBar: Rectangle {
            height: 33

            color: "transparent"

            HoverButton {
                id: calendar_NavigationBar_Previous

                width: 20
                height: width

                anchors.top: parent.top
                anchors.left: parent.left

                imageTopAnchor: 0
                imageWidth: width
                imageHeight: height
                imageSource: "icons/keyboard-left-24px.svg"

                onActivated: {
                    calendar.showPreviousMonth()
                }
            }

            Text {
                id: calendar_NavigationBar_Month

                width: contentWidth
                height: contentHeight

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                text: Qt.locale().monthName(calendar.visibleMonth)
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 10
            }

            Text {
                width: contentWidth
                height: contentHeight

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: calendar_NavigationBar_Month.bottom
                anchors.topMargin: 1
                anchors.bottom: parent.bottom

                text: calendar.visibleYear
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 9
                color: Style.style_grey_light
            }

            HoverButton {
                id: calendar_NavigationBar_Next

                width: 20
                height: width

                anchors.top: parent.top
                anchors.right: parent.right

                imageTopAnchor: 0
                imageWidth: width
                imageHeight: height
                imageSource: "icons/keyboard-right-24px.svg"

                onActivated: {
                    calendar.showNextMonth()
                }
            }
        }

        dayDelegate: Rectangle {
            color: (styleData.selected ? Style.style_green_light : "transparent")

            width: height
            radius: width / 2

            Text {
                anchors.centerIn: parent

                text: styleData.date.getDate()
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 9

                color: (styleData.visibleMonth ? (styleData.selected ? Style.style_light : Style.style_black) : Style.style_grey_light)
            }

        }

        dayOfWeekDelegate: Text {
            anchors.centerIn: parent

            text: Qt.locale().dayName(styleData.index, Locale.ShortFormat)
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 9
            color: Style.style_grey_dark
        }
    }

}
