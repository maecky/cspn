/**
 * @file
 *
 * @brief       News Item delegate
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

import QtQuick 2.0
import QtQml 2.0
import "style.js" as Style

Item {
    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("[NewsDelegate] Opening " + url.toString());
            Qt.openUrlExternally(url.toString());
        }
    }

    /** News Item Image
     */
    Image {
        id: newsItem_Image

        height: parent.height
        width: height * 1.5

        anchors.left: parent.left
        anchors.top: parent.top

        sourceSize.width: width
        sourceSize.height: height
        source: "image://webimages/" + image.toString()
    }

    /** News Item Title
     */
    Text {
        id: newsItem_Title

        anchors.left: newsItem_Image.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 2

        text: title.toString()
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        maximumLineCount: 2
        font.pointSize: 10
    }

    /** News Source
     */
    Text {
        id: newsItem_Source

        anchors.left: newsItem_Image.right
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4

        text: source.toString()
        font.pointSize: 9
        color: Style.style_grey_light
    }
}
