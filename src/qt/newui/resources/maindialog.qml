/**
 * @file
 *
 * @brief       Main Dialog
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
import QtQuick.Window 2.2
import "style.js" as Style
import "config.js" as Config

ApplicationWindow {
    id: applicationWindow
    visible: true
    title: qsTr("BitGreen Hub")

    width: 1000
    height: 600
    minimumWidth: 900
    minimumHeight: 550

    Rectangle {
        id: main_TopBar

        x: 0
        y: 0
        width: applicationWindow.width
        height: sDim(85)

        color: Config.color.white

        /*  Open Home Page

            Icon
        */
        Image {
            id: main_OpenHomePage

            width: parent.height * 0.75
            height: width

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Config.ui.margin.lg

            source: "icons/bitgreen64.png"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor;
                onClicked: {
                    switchPage('Home');
                }
            }
        }

        /*
            Network indicator
        */
        Image {
            id: main_NetworkIndicator

            width: sDim(16)
            height: width

            anchors.left: main_OpenHomePage.right
            anchors.leftMargin: 0
            anchors.bottom: main_OpenHomePage.bottom

            source: "icons/network-mid-64px.svg"
            fillMode: Image.PreserveAspectFit
        }

        /*  Lock/Unlock switch
        */
        CustomSwitch {
            width: sDim(height * 1.6)
            height: sDim(16)

            anchors.left: main_NetworkIndicator.right
            anchors.leftMargin: 0//sDim(Config.ui.margin.xs)
            anchors.bottom: main_NetworkIndicator.bottom

            onToggled: main_WalletLockOverlay.open()
        }

        /*  Open Wallet Page

            Icon + Text
        */
        HoverButton {
            id: main_OpenWalletPage

            width: height * 1.4
            height: parent.height * 0.75

            anchors.left: main_OpenHomePage.right
            anchors.leftMargin: sDim(Config.ui.margin.xl) * 2.5
            anchors.verticalCenter: parent.verticalCenter

            text: "Wallet"

            imageSource: "icons/page-wallet-64px.svg"

            onActivated: {
                switchPage('Wallet');
            }
        }

        /*  Open Send Page

            Icon + Text
        */
        HoverButton {
            id: main_OpenSendPage

            width: height * 1.4
            height: parent.height * 0.75

            anchors.left: main_OpenWalletPage.right
            //anchors.leftMargin: sDim(Config.ui.margin.md)
            anchors.verticalCenter: parent.verticalCenter

            text: "Send"

            imageSource: "icons/page-send-64px.svg"

            onActivated: {
                switchPage('Send');
            }
        }

        /*  Open Rewards Page

            Icon + Text
        */
        HoverButton {
            id: main_OpenRewardsPage

            width: height * 1.4
            height: parent.height * 0.75

            anchors.left: main_OpenSendPage.right
            //anchors.leftMargin: sDim(Config.ui.margin.md)
            anchors.verticalCenter: parent.verticalCenter

            text: "Masternodes"

            imageSource: "icons/page-rewards-64px.svg"

            onActivated: {
                switchPage('Masternodes');  /*  Temporary: go straight to masternodes page */
            }
        }

        /*  Open Participate Page

            Icon + Text
        */
        HoverButton {
            id: main_OpenParticipatePage

            width: height * 1.4
            height: parent.height * 0.75

            anchors.left: main_OpenRewardsPage.right
            //anchors.leftMargin: sDim(Config.ui.margin.md)
            anchors.verticalCenter: parent.verticalCenter

            text: "Participate"

            imageSource: "icons/page-participate-64px.svg"

            onActivated: {
                switchPage('Participate');
            }
        }

        /*  Open Network Page

            Icon + Text
        */
        HoverButton {
            id: main_OpenNetworkPage

            width: height * 1.4
            height: parent.height * 0.75

            anchors.left: main_OpenParticipatePage.right
            //anchors.leftMargin: sDim(Config.ui.margin.md)
            anchors.verticalCenter: parent.verticalCenter

            text: "Network"

            imageSource: "icons/page-network-64px.svg"

            onActivated: {
                switchPage('Network');
            }
        }


        /*  Open Search Overlay

            Icon
        */
        HoverButton {
            id: main_OpenSearch

            width: 30
            height: 30

            anchors.right: main_OpenSettingsPage.left
            anchors.rightMargin: 10
            anchors.verticalCenterOffset: 13
            anchors.verticalCenter: parent.verticalCenter

            imageWidth: 24
            imageHeight: imageWidth
            imageSource: "icons/search-24px.svg"

            onActivated: {
                main_SearchOverlay.open();
                main_SearchOverlay.forceFocus();
            }
        }

        /*  Open Settings Page

            Icon
        */
        HoverButton {
            id: main_OpenSettingsPage

            width: 30
            height: 30

            anchors.right: main_OpenHelpPage.left
            anchors.rightMargin: 10
            anchors.verticalCenterOffset: 13
            anchors.verticalCenter: parent.verticalCenter

            imageWidth: 24
            imageHeight: imageWidth
            imageSource: "icons/settings-24px.svg"

            onActivated: {
                switchPage('Settings');
            }
        }

        /*  Open Help Page

            Icon
        */
        HoverButton {
            id: main_OpenHelpPage

            width: 30
            height: 30

            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.verticalCenterOffset: 13
            anchors.verticalCenter: parent.verticalCenter

            imageWidth: 24
            imageHeight: imageWidth
            imageSource: "icons/help-24px.svg"

            onActivated: {
                //switchPage('Help');
            }
        }
    }

    SearchOverlay {
        id: main_SearchOverlay

        x: applicationWindow.width / 2
        y: 0
        width: applicationWindow.width / 2
        height: applicationWindow.height

        modal: true
        focus: true
    }

    WalletLockOverlay {
        id: main_WalletLockOverlay

        x: Math.round((applicationWindow.width - width) / 2)
        y: Math.round((applicationWindow.height - height) / 2)

        modal: true
        focus: true
    }

    Rectangle {
        id: main_InformationBar

        width: main_TopBar.width
        height: sDim(20)

        anchors.top: main_TopBar.bottom
        anchors.left: main_TopBar.left

        color: Config.color.gray.light

        Text {
            id: main_SyncText

            text: "Synchronizing"
            color: Config.color.gray.dark
            font.pixelSize: remToPx(0.85)

            anchors.right: main_SyncProgressBar.left
            anchors.rightMargin: sDim(Config.ui.margin.sm)
            anchors.verticalCenter: parent.verticalCenter
        }

        CustomProgressBar {
            id: main_SyncProgressBar

            height: parent.height * 0.6
            width: parent.width * 0.2

            value: 0.8  /*  TODO: use actual sync value */

            anchors.right: parent.right
            anchors.rightMargin: sDim(Config.ui.margin.md)
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    StackLayout {
        id: pageStack

        anchors.top: main_InformationBar.bottom
        anchors.topMargin: sDim(Config.ui.padding.lg)
        anchors.right: parent.right
        anchors.rightMargin: sDim(Config.ui.padding.lg)
        anchors.left: parent.left
        anchors.leftMargin: sDim(Config.ui.padding.lg)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: sDim(Config.ui.padding.lg)

        currentIndex: 0

        HomePage {
            id: homePage
            property string idAlias: 'homePage'
            anchors.fill: parent
        }
        WalletPage {
            id: walletPage
            property string idAlias: 'walletPage'
            anchors.fill: parent
        }
        SendPage {
            id: sendPage
            property string idAlias: 'sendPage'
            anchors.fill: parent
        }
        RewardsPage {
            id: rewardsPage
            property string idAlias: 'rewardsPage'
            anchors.fill: parent
        }
        ParticipatePage {
            id: participatePage
            property string idAlias: 'participatePage'
            anchors.fill: parent
        }
        NetworkPage {
            id: networkPage
            property string idAlias: 'networkPage'
            anchors.fill: parent
        }
        SettingsPage {
            id: settingsPage
            property string idAlias: 'settingsPage'
            anchors.fill: parent
        }
        DebugPage {
            id: debugPage
            property string idAlias: 'debugPage'
            anchors.fill: parent
        }
        MasternodesPage {
            id: masternodesPage
            property string idAlias: 'masternodesPage'
            anchors.fill: parent
        }
        TransactionHistoryPage {
            id: transactionHistoryPage
            property string idAlias: 'transactionHistoryPage'
            anchors.fill: parent
        }

        function getIndexById(pageId) {
            var stackPageIndex = -1;
            for (var i = 0; i < this.children.length; i++) {
                if(this.children[i].idAlias === pageId) {
                    stackPageIndex = i;
                    break;
                }
            }
            return stackPageIndex;
        }
        function setPage(index, data) {
            // Do anything with data?
            this.currentIndex = index;
        }
    }

    // Application loaded
    Component.onCompleted: {
//        console.log('App loaded');

//        var activeColor = Qt.darker(Config.color.primary, 2);
//        console.log(Config.color.primary);
//        console.log(activeColor);

//        console.log(homePage.parent.currentIndex);
//        console.log(pageStack.children[0]);
//        console.log(typeof eval('homePage'));
//        console.log(homePage);
//        console.log(eval('homePage') === pageStack.children[0]);
//        console.log(eval('homePage') === pageStack.children[0]);
//        var temp = eval('homePage');
//        console.log(temp === pageStack.children[0]);
//        console.log(pageStack.children[0].idAlias);
//        console.log(pageStack.getIndexById('homePage'));
//        console.log(this[somePage]);
    }

    /*-------------------------------------------
      FUNCTIONS
      ------------------------------------------*/

    function switchPage(pageName, data, callback) {
        // Ensure first char of an id name is lowercase
        var stackPageId = pageName.charAt(0).toLowerCase() + pageName.slice(1) + "Page";
        var stackPageIndex = pageStack.getIndexById(stackPageId);

        if(stackPageIndex > -1) {
            console.info('Opening ' + pageName + ' page');
            pageStack.setPage(stackPageIndex, data);
            if(typeof callback === "function") callback();
        }
        else console.log("switchPage() warning: page '" + pageName + "' not recognized.");
    }

    function intToStringPad(v)
    {
        return (v < 10 ? "0" + v : v);
    }

    function niceDateTimeString(dt)
    {
        var out = "";
        var d = new Date(dt);
        var today = new Date();
        if(d.setHours(0, 0, 0, 0) === today.setHours(0, 0, 0, 0))   /*  Today   */
        {
            out = "Today at " + intToStringPad(dt.getHours()) + ":" + intToStringPad(dt.getMinutes());
        }
        else
        {
            out = intToStringPad(dt.getFullYear()) + "/" + intToStringPad(dt.getMonth() + 1) + "/" + intToStringPad(dt.getDate()) + "  "
                    + intToStringPad(dt.getHours()) + ":" + intToStringPad(dt.getMinutes());
        }
        return out;
    }

    function formatAmount(v)
    {
        var a = Math.abs(v);
        return (v > 0 ? "+ " + a.toFixed(4) : "- " + a.toFixed(4));
    }

    /**
     * Convert a REM value to it's equivalent pixel value for the
     * user's current screen, considerate to pixel density etc.
     *
     * @param {number} px REM value
     * @return {number} The equivalent pixel value
     */
    function remToPx(rem) {
        var scaledBase = scaleDimension(Config.type.base);
        return Math.round(rem * scaledBase);
    }

    /**
     * Convert a pixel value into REM units.
     * @Note: REM units are calculated as a relative value
     * to the base (usually font) size.
     * @Ref: https://stackoverflow.com/questions/11352783/how-to-calculate-rem-for-type
     *
     * @param {number} px Original pixel value.
     * @return {number} The REM value
     */
    function pxToRem(px) {
        return px / Config.type.base;
    }

    /**
     * Get a transformed dimension that is relative to
     * the user's screen, considerate of pixel density.
     *
     * @param {number} px Pixel value
     * @return {number} Transformed pixel value
     */
    function scaleDimension(px) {
        if(typeof px === "undefined") {
            console.log("Pixel value not provided.");
            return;
        }
        px = (px<1) ? 1 : px;
        return Math.round(px * Screen.devicePixelRatio);
    }
    // Alias
    function sDim(px) {return scaleDimension(px)}
}
