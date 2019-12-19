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

import QtQuick.Controls 1.4 as QQC1
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

import "style.js" as Style

QQC1.ProgressBar {
    id: control
    property string centerText: ""
    property string centerImage: ""

    property string activeColor: Style.style_green_light
    property string inactiveColor: "transparent"

    /*  Inspired by
        https://stackoverflow.com/questions/22873550/how-to-create-a-circular-progress-bar-in-pure-qmljs
    */
    style: ProgressBarStyle {

        panel: Item {
            Rectangle {
                id: outerRing

                z: 0
                anchors.fill: parent
                anchors.margins: 2

                color: "transparent"

                radius: Math.max(width, height) / 2
                border.color: Style.style_light
                border.width: 4
            }

            Rectangle {
                id: innerRing

                z: 1
                anchors.fill: parent
                anchors.margins: 4

                color: "transparent"

                radius: outerRing.radius
                border.color: Style.style_grey_light
                border.width: 8

                ConicalGradient {
                    source: innerRing
                    anchors.fill: parent

                    gradient: Gradient {
                        GradientStop {
                            position: 0.00;
                            color: (control.value < 1 ? control.inactiveColor : control.activeColor)
                        }
                        GradientStop {
                            position: 1.0 - control.value - 0.001
                            color: (control.value < 1 ? control.inactiveColor : control.activeColor)
                        }
                        GradientStop {
                            position: 1.0 - control.value
                            color: (control.value > 0 ? control.activeColor : control.inactiveColor)
                        }
                        GradientStop {
                            position: 1.00;
                            color: (control.value > 0 ? control.activeColor : control.inactiveColor)
                        }
                    }
                }
            }

            Text {
                anchors.centerIn: parent

                width: contentWidth
                height: contentHeight

                visible: text.length > 0

                color: Style.style_grey_dark
                text: control.centerText
            }

            Image {
                anchors.centerIn: parent

                width: innerRing.width * 0.5
                height: width

                fillMode: Image.PreserveAspectFit

                source: control.centerImage

                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
            }
        }
    }
}
