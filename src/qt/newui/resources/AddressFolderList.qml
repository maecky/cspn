/**
 * @file
 *
 * @brief       Address-Folder list
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
import QtQml.Models 2.3
import "style.js" as Style

Item {

    property alias folderSourceModel: addressFolderList_Model.model

    property alias currentFolderItem: addressFolderList_View.currentItem
    property int currentFolderItemY: addressFolderList_View.y + (addressFolderList_View.currentItem != null ? addressFolderList_View.currentItem.y : 0)

    property alias searchText: walletPage_AddressSearch.text

    /*  Address Search
     */
    AdvancedTextInput {
        id: walletPage_AddressSearch

        height: 28

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

        placeholderText: "Search an address name..."
        text: ""
        iconSource: "icons/search-24px.svg"
        underline: false
    }

    /*  Folder structure ListView
     */
    ListView {
        id: addressFolderList_View

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: walletPage_AddressSearch.bottom
        anchors.topMargin: 5
        anchors.bottom: addressFolderList_CreateItem.top
        anchors.bottomMargin: 5

        clip: true
        model: addressFolderList_Model

        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        currentIndex: 0
    }

    DelegateModel {
        id: addressFolderList_Model

        delegate: AddressFolderDelegate {
            width: addressFolderList_View.width
            height: 55
        }

        groups: [
            DelegateModelGroup {
                name: "filterGroup"
                includeByDefault: false
            }
        ]
        filterOnGroup: "filterGroup"

        function applyFilter(list, searchTerm)
        {
            var s = searchTerm.toLowerCase();

            var count = model.count;
            for(var i = 0; i < count; ++i)
            {
                var item = model.get(i);
                if(list.indexOf(item.role_name) !== -1 || itemNameMatches(item, s))
                {
                    items.addGroups(i, 1, "filterGroup");
                }
                else
                {
                    items.removeGroups(i, 1, "filterGroup");
                }
            }
        }

        function itemNameMatches(item, searchTerm)
        {
            if(searchTerm.length === 0)
            {
                return true;
            }

            /*  Match name */
            var name = item.role_name.toLowerCase();
            var n = name.search(searchTerm);
            if(n !== -1)
            {
                return true;
            }
            return false;
        }
    }

    /**
     * @brief           Apply a filter to the folder list;
     *
     * Typically, you can use the Search Input to search through addresses,
     * and if any is found to be matching, call this function with the corresponding
     * folder in order to show it.
     *
     * Additionally, if a folder directly matches the search term, it is
     * also shown.
     *
     * @param list      List with allowed folder names
     */
    function applyFolderFilter(list)
    {
        addressFolderList_Model.applyFilter(list, searchText);
    }


    /*  Button for adding new Folders
     */
    Item {
        id: addressFolderList_CreateItem

        height: 35

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Rectangle {
            anchors.fill: parent

            layer.enabled: true
            color: Style.style_grey_light

            visible: addressFolderList_MouseArea.containsMouse
        }

        Image {
            id: addressFolderList_Image

            height: (parent.height / 2)
            width: height

            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            source: "icons/folder-create-24px.svg"
        }

        Text {
            id: addressFolderList_Text

            height: contentHeight

            anchors.left: addressFolderList_Image.right
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "New folder"
            font.pixelSize: remToPx(0.6)
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
        }

        MouseArea {
            id: addressFolderList_MouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
            }
        }
    }
}
