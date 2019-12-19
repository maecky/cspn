/**
 * @file
 *
 * @brief       Search Overlay
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
import "config.js" as Config

Popup {
    id: searchPopup

    width: applicationWindow.width * 0.45
    height: applicationWindow.height

    background: Rectangle {
        //opacity: 0.94
        color: Style.style_white
    }

    /*-------------------------------------------
      FUNCTIONALITY
      ------------------------------------------*/

    function closePopup() {
        this.close()
    }
    function forceFocus() {
        searchOverlay_Input.forceFocus();
    }

    /*-------------------------------------------
      ELEMENTS
      ------------------------------------------*/

    /*
        Primary search bar
    */
    AdvancedTextInput {
        id: searchOverlay_Input
        x: sDim(Config.ui.margin.lg)
        y: x
        width: parent.width - (x * 3)
        height: remToPx(2.5)

        fontSize: remToPx(1.6)
        placeholderText: "Search anything..."

        onTextChanged: {
            searchOverlay_ResultsModel.applySearch(text);
        }
    }
    /*
        Help text
    */
    Text {
        width: searchOverlay_Input.width
        height: remToPx(1)
        x: searchOverlay_Input.x

        anchors.top: searchOverlay_Input.bottom
        anchors.topMargin: sDim(Config.ui.margin.xs)

        text: "Type an address or find a menu item"
        font.pixelSize: remToPx(0.85)
        font.italic: true
        color: Config.color.gray.dark
    }
    /*
        Search icon
    */
    Image {
        width: searchOverlay_Input.height * 0.8
        height: width

        anchors.left: searchOverlay_Input.right
        anchors.leftMargin: -1 * width
        anchors.verticalCenter: searchOverlay_Input.verticalCenter

        source: "icons/search-24px.svg"
        fillMode: Image.PreserveAspectFit
    }
    /*
        Close icon
    */
    Image {
        width: searchOverlay_Input.height * 0.8
        height: width

        anchors.left: searchOverlay_Input.right
        anchors.leftMargin: sDim(Config.ui.margin.sm)
        anchors.verticalCenter: searchOverlay_Input.verticalCenter

        source: "icons/clear-24px.svg"
        fillMode: Image.PreserveAspectFit

        MouseArea {
            anchors.fill: parent
            onClicked: {
                closePopup();
            }
        }
    }
    /*
        Begin list of results
    */
    ListView {
        id: searchOverlay_List
        x: searchOverlay_Input.x
        width: searchOverlay_Input.width

        spacing: sDim(Config.ui.padding.xs)

        anchors.top: searchOverlay_Input.bottom
        anchors.topMargin: sDim(Config.ui.margin.lg) * 1.5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: sDim(Config.ui.margin.lg)

        model: searchOverlay_ResultsModel

//        addDisplaced: Transition {
//            NumberAnimation { properties: "x,y"; duration: 1000 }
//        }
//        removeDisplaced: Transition {
//            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
//            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
//        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }
        }
    }

    ListModel {
        id: searchOverlay_SourceModel;

        ListElement {
            role_name: "overview home"

            role_displayname: "Overview"
            role_description: "Open the BitGreen overview"
            role_icon: "icons/bitgreen64.png"

            role_page: "home"
            role_pagedetails: ""
        }

        ListElement {
            role_name: "wallet"

            role_displayname: "Wallet"
            role_description: "Open the Wallet page"
            role_icon: "icons/page-wallet-64px.svg"

            role_page: "wallet"
            role_pagedetails: ""
        }

        ListElement {
            role_name: "send transactions"

            role_displayname: "Send"
            role_description: "Open the Send page"
            role_icon: "icons/page-send-64px.svg"

            role_page: "send"
            role_pagedetails: ""
        }

        ListElement {
            role_name: "network info"

            role_displayname: "Network"
            role_description: "Open the Network page"
            role_icon: "icons/page-network-64px.svg"

            role_page: "network"
            role_pagedetails: ""
        }

        ListElement {
            role_name: "settings configuration"

            role_displayname: "Settings"
            role_description: "Open the Settings page"
            role_icon: "icons/settings-24px.svg"

            role_page: "settings"
            role_pagedetails: ""
        }

        ListElement {
            role_name: "debug console"

            role_displayname: "Debug Console"
            role_description: "Open the Debug Console"
            role_icon: "icons/settings-24px.svg"

            role_page: "debug"
            role_pagedetails: ""
        }

        ListElement {
            role_name: "masternodes"

            role_displayname: "Manage Masternodes"
            role_description: "Open Masternode management"
            role_icon: "icons/page-rewards-64px.svg"

            role_page: "masternodes"
            role_pagedetails: ""
        }

        ListElement {
            role_name: "transactions history"

            role_displayname: "Transaction History"
            role_description: "Open the Transaction History"
            role_icon: "icons/page-wallet-64px.svg"

            role_page: "transactionhistory"
            role_pagedetails: ""
        }
    }

    DelegateModel {
        id: searchOverlay_ResultsModel;

        delegate: Item {
            width: searchOverlay_List.width
            height: 50

            UiItemLink {
                anchors.fill: parent

                text: role_displayname
                description: role_description
                iconSource: role_icon
                buttonText: "Open"

                onActivated: {
                    /*
                        role_pagedetails could for example be an address, extra
                        data passed when opening the page.
                    */
                    switchPage(role_page, role_pagedetails);
                    closePopup();
                }
            }
        }
        model: searchOverlay_SourceModel

        groups: [
            DelegateModelGroup {
                name: "searchGroup"
                includeByDefault: false
            }
        ]
        filterOnGroup: "searchGroup"

        function applySearch(text)
        {
            var searchTerm = text.toLowerCase();

            var count = searchOverlay_SourceModel.count;
            for(var i = 0; i < count; ++i)
            {
                var item = searchOverlay_SourceModel.get(i);
                if(itemMatches(item, searchTerm))
                {
                    items.addGroups(i, 1, "searchGroup");
                }
                else
                {
                    items.removeGroups(i, 1, "searchGroup");
                }
            }
        }

        function itemMatches(item, searchTerm)
        {
            if(searchTerm.length === 0)
            {
                return false;
            }

            var name = item.role_name;
            var n = name.search(searchTerm);
            if(n !== -1)
            {
                return true;
            }
            return false;
        }
    }

}







/*##^## Designer {
    D{i:3;anchors_x:0;anchors_y:39}D{i:6;anchors_height:489;anchors_y:85}
}
 ##^##*/
