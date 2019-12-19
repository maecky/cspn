/**
 * @file
 *
 * @brief       Transaction History Page
 *
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import "style.js" as Style
import org.bitg 1.0

Item {
    id: transactionHistoryPage
    width: 950
    height: 500

    Text {
        id: transactionHistory_TitleText
        width: 310
        height: 36

        text: qsTr("Transaction History")
        font.pointSize: 27
        color: Style.style_green_light

        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    function handleFilterUpdate()
    {
        var minDate = new Date(transactionHistory_CalendarFrom.selectedDate);
        minDate.setHours(0, 0, 0, 0);
        var maxDate = new Date(transactionHistory_CalendarTo.selectedDate);
        maxDate.setHours(0, 0, 0, 0);

        transactionHistory_Model.applyFilter(transactionHistory_SearchInput.text.toLowerCase(), minDate, maxDate,
                                                transactionHistory_TypeAny.checked, transactionHistory_TypeStaking.checked, transactionHistory_TypeMasternode.checked,
                                                transactionHistory_TypeIncoming.checked, transactionHistory_TypeOutgoing.checked);

        /*  Ensure that update in the transaction model comes through */
        transactionHistory_StatisticsRatioBar.value = (transactionHistory_Model.totalTransactionValue > 0.0 ? transactionHistory_Model.totalIncoming / transactionHistory_Model.totalTransactionValue : 0.0);
    }

    Item {
        id: transactionHistory_FirstColumn

        width: 450

        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.top: transactionHistory_TitleText.bottom
        anchors.topMargin: 20

        /** Rectangle around Search Input
         */
        Rectangle {
            id: transactionHistory_SearchRectangle

            height: 40

            anchors.right: parent.right
            anchors.left: parent.left

            color: Style.style_light
            border.color: Style.style_grey_light
            radius: 5
        }

        /** Search Input: address, transaction hash
         */
        AdvancedTextInput {
            id: transactionHistory_SearchInput

            anchors.fill: transactionHistory_SearchRectangle
            anchors.margins: 5

            placeholderText: "Enter an address/label, or transaction hash"
            textColor: Style.style_grey_dark
            iconSource: "icons/search-24px.svg"
            fontSize: 11

            underline: false

            onTextChanged: {
                handleFilterUpdate();
            }
        }

        /** Transaction Type Selection
         */
        GridLayout {
            id: transactionHistory_TypeSelection

            height: 30

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: transactionHistory_SearchInput.bottom
            anchors.topMargin: 12

            rows: 1
            columns: 6

            columnSpacing: 4

            /** Transaction Type: Any
             */
            CheckButton {
                id: transactionHistory_TypeAny

                Layout.minimumHeight: textHeight * 1.1
                Layout.fillHeight: true
                Layout.fillWidth: true

                text: "Any"
                font.pointSize: 10

                checked: true
                onSelected: {
                    transactionHistory_TypeStaking.checked = false;
                    transactionHistory_TypeMasternode.checked = false;
                    transactionHistory_TypeIncoming.checked = false;
                    transactionHistory_TypeOutgoing.checked = false;

                    handleFilterUpdate();
                }

                onDeselected: {
                    handleFilterUpdate();
                }
            }

            Rectangle {
                Layout.fillWidth: true

                height: 1

                color: Style.style_grey_light
            }

            /** Transaction Type: Staking
             */
            CheckButton {
                id: transactionHistory_TypeStaking

                Layout.minimumHeight: textHeight * 1.1
                Layout.fillHeight: true
                Layout.fillWidth: true

                text: "Staking"
                font.pointSize: 10

                onSelected: {
                    transactionHistory_TypeAny.checked = false;

                    handleFilterUpdate();
                }

                onDeselected: {
                    handleFilterUpdate();
                }
            }

            /** Transaction Type: Masternode reward
             */
            CheckButton {
                id: transactionHistory_TypeMasternode

                Layout.minimumHeight: textHeight * 1.1
                Layout.fillHeight: true
                Layout.fillWidth: true

                text: "Masternode"
                font.pointSize: 10

                onSelected: {
                    transactionHistory_TypeAny.checked = false;

                    handleFilterUpdate();
                }

                onDeselected: {
                    handleFilterUpdate();
                }
            }

            /** Transaction Type: Incoming
             */
            CheckButton {
                id: transactionHistory_TypeIncoming

                Layout.minimumHeight: textHeight * 1.1
                Layout.fillHeight: true
                Layout.fillWidth: true

                text: "Incoming"
                font.pointSize: 10

                onSelected: {
                    transactionHistory_TypeAny.checked = false;

                    handleFilterUpdate();
                }

                onDeselected: {
                    handleFilterUpdate();
                }
            }

            /** Transaction Type: Outgoing
             */
            CheckButton {
                id: transactionHistory_TypeOutgoing

                Layout.minimumHeight: textHeight * 1.1
                Layout.fillHeight: true
                Layout.fillWidth: true

                text: "Outgoing"
                font.pointSize: 10

                onSelected: {
                    transactionHistory_TypeAny.checked = false;

                    handleFilterUpdate();
                }

                onDeselected: {
                    handleFilterUpdate();
                }
            }
        }


        /** Filter: starting date
         */
        CustomCalendar {
            id: transactionHistory_CalendarFrom

            width: 4 * parent.width / 9
            height: width

            anchors.left: parent.left
            anchors.top: transactionHistory_TypeSelection.bottom
            anchors.topMargin: 20

            onPressed: {
                var maxDate = transactionHistory_CalendarTo.selectedDate;

                if(date > maxDate)
                {
                    transactionHistory_CalendarTo.selectedDate = date;
                }

                handleFilterUpdate();
            }
        }

        Image {
            id: transactionHistory_DaysCountImage

            height: 80

            anchors.left: transactionHistory_CalendarFrom.right
            anchors.right: transactionHistory_CalendarTo.left
            anchors.top: transactionHistory_TypeSelection.bottom
            anchors.topMargin: 70

            source: ""
        }

        /** Difference between min and max date
         */
        Text {
            /*  1000 * 60 * 60 * 24 = 86400000  */
            text: Math.ceil(Math.abs(transactionHistory_CalendarTo.selectedDate.getTime() - transactionHistory_CalendarFrom.selectedDate.getTime()) / 86400000) + "\nDays"
            color: Style.style_grey_dark
            font.pointSize: 10

            horizontalAlignment: Text.AlignHCenter

            anchors.left: transactionHistory_CalendarFrom.right
            anchors.right: transactionHistory_CalendarTo.left
            anchors.top: transactionHistory_DaysCountImage.bottom
            anchors.topMargin: 10
        }

        /** Filter: End date
         */
        CustomCalendar {
            id: transactionHistory_CalendarTo

            width: 4 * parent.width / 9
            height: width

            anchors.right: parent.right
            anchors.top: transactionHistory_TypeSelection.bottom
            anchors.topMargin: 20

            onPressed: {
                var minDate = transactionHistory_CalendarFrom.selectedDate;

                if(date < minDate)
                {
                    transactionHistory_CalendarFrom.selectedDate = date;
                }

                handleFilterUpdate();
            }
        }

        Rectangle {
            id: transactionHistory_StatisticsSeparator

            height: 1

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: transactionHistory_CalendarTo.bottom
            anchors.topMargin: 5

            color: Style.style_grey_light
        }

        /** Item displaying various statistics
         */
        Row {
            id: transactionHistory_StatisticsItem

            height: 70

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: transactionHistory_StatisticsSeparator.bottom
            anchors.topMargin: 10

            spacing: 17

            /** Title
             */
            Text {
                id: transactionHistory_StatisticsTitle

                width: contentWidth
                height: contentHeight

                anchors.top: parent.top
                anchors.topMargin: 4

                text: "Activity"
                font.pointSize: 12
            }

            /** CircularProgressBar, comparing incoming with outgoing
             */
            CircularProgressBar {
                id: transactionHistory_StatisticsRatioBar

                width: transactionHistory_StatisticsTitle.width * 1.2
                height: width

                anchors.top: parent.top

                centerImage: "icons/import-export-24px.svg"

                activeColor: (transactionHistory_Model.totalTransactionValue > 0 ? Style.style_green_light : "transparent")
                /*  Only display a color if there are actually transactions */
                inactiveColor: (transactionHistory_Model.totalTransactionValue > 0 ? Style.style_orange : "transparent")
            }

            Item {
                width: 90

                anchors.top: parent.top
                anchors.bottom: parent.bottom

                /** Total: title
                 */
                Text {
                    id: transactionHistory_StatisticsTotalTitle

                    width: contentWidth
                    height: contentHeight

                    anchors.top: parent.top
                    anchors.left: parent.left

                    text: "Total"
                    color: Style.style_grey_dark
                    font.pointSize: 10
                }

                /** Total: value
                 */
                Text {
                    width: parent.width
                    height: font.pixelSize

                    anchors.top: transactionHistory_StatisticsTotalTitle.bottom
                    anchors.topMargin: 5
                    anchors.left: parent.left

                    text: transactionHistory_Model.totalTransactionValue
                    color: Style.style_black
                    font.pointSize: 14
                    elide: Text.ElideRight
                }
            }

            Item {
                width: 70

                anchors.top: parent.top
                anchors.bottom: parent.bottom

                /** Incoming: title
                 */
                Text {
                    id: transactionHistory_StatisticsIncomingTitle

                    width: contentWidth
                    height: contentHeight

                    anchors.top: parent.top
                    anchors.left: parent.left

                    text: "Incoming"
                    color: Style.style_grey_dark
                    font.pointSize: 10
                }

                /** Incoming: value
                 */
                Text {
                    width: parent.width
                    height: font.pixelSize

                    anchors.top: transactionHistory_StatisticsIncomingTitle.bottom
                    anchors.topMargin: 5
                    anchors.left: parent.left

                    text: transactionHistory_Model.totalIncoming
                    color: Style.style_black
                    font.pointSize: 10
                    elide: Text.ElideRight
                }
            }

            Item {
                width: 70

                anchors.top: parent.top
                anchors.bottom: parent.bottom

                /** Outgoing: title
                 */
                Text {
                    id: transactionHistory_StatisticsOutgoingTitle

                    width: contentWidth
                    height: contentHeight

                    anchors.top: parent.top
                    anchors.left: parent.left

                    text: "Outgoing"
                    color: Style.style_grey_dark
                    font.pointSize: 10
                }

                /** Incoming: value
                 */
                Text {
                    width: parent.width
                    height: font.pixelSize

                    anchors.top: transactionHistory_StatisticsOutgoingTitle.bottom
                    anchors.topMargin: 5
                    anchors.left: parent.left

                    text: transactionHistory_Model.totalOutgoing
                    color: Style.style_black
                    font.pointSize: 10
                    elide: Text.ElideRight
                }
            }
        }
    }

    ComboBox {
        id: transactionHistory_SortComboBox

        width: 150
        height: 35

        anchors.right: parent.right
        anchors.rightMargin: 32
        anchors.top: parent.top
        anchors.topMargin: 10

        currentIndex: 0

        model: [
            "None",
            "Date",
            "Type",
            "Address",
            "Amount"
        ]

        onCurrentIndexChanged: {
        }
    }


    /** List of transactions
     */
    ListView {
        id: transactionHistory_ListView

        anchors.right: parent.right
        anchors.rightMargin: 26
        anchors.left: transactionHistory_FirstColumn.right
        anchors.leftMargin: 26
        anchors.top: transactionHistory_SortComboBox.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20

        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        model: transactionHistory_Model
        spacing: 4

        clip: true

        /** Vertical scrollbar; Position to the right of the ListView (outside of the ListView)
         */
        ScrollBar.vertical: ScrollBar {
            parent: transactionHistory_ListView.parent

            anchors.left: transactionHistory_ListView.right
            anchors.leftMargin: 2
            anchors.top: transactionHistory_ListView.top
            anchors.bottom: transactionHistory_ListView.bottom

            policy: ScrollBar.AlwaysOn
        }
    }

    /** Delegate Model, used for filtering and sorting
     */
    DelegateModel {
        id: transactionHistory_Model

        delegate: TransactionRecordDelegate {
            width: transactionHistory_ListView.width
        }
        model: cTransactionModel

        groups: [
            DelegateModelGroup {
                name: "filterGroup"
                includeByDefault: false
            }
        ]
        filterOnGroup: "filterGroup"

        function applyFilter(searchTerm, minDate, maxDate, typeAny, typeStaking, typeMasternode, typeIncoming, typeOutgoing)
        {
            var _totalIncoming = 0.0;
            var _totalOutgoing = 0.0;

            var count = cTransactionModel.count;
            for(var i = 0; i < count; ++i)
            {
                var item = cTransactionModel.get(i);
                if(itemPasses(item, searchTerm, minDate, maxDate, typeAny, typeStaking, typeMasternode, typeIncoming, typeOutgoing))
                {
                    items.addGroups(i, 1, "filterGroup");

                    var type = item.role_type;

                    /*  Incoming    */
                    var amount = Math.abs(item.role_amount);
                    if(type === TransactionListModel.TYPE_STAKE_MINT || type === TransactionListModel.TYPE_GENERATED || type === TransactionListModel.TYPE_RECV_FROM_OTHER
                            || type === TransactionListModel.TYPE_RECV_WITH_ADDRESS)
                    {
                        _totalIncoming = _totalIncoming + amount;
                    }
                    /*  Outgoing    */
                    else
                    {
                        _totalOutgoing = _totalOutgoing + amount;
                    }
                }
                else
                {
                    items.removeGroups(i, 1, "filterGroup");
                }
            }

            /*  Set global properties only once to prevent unnecessary QML updates */
            totalIncoming = _totalIncoming;
            totalOutgoing = _totalOutgoing;
            totalTransactionValue = totalIncoming + totalOutgoing;
        }

        function itemPasses(item, searchTerm, minDate, maxDate, typeAny, typeStaking, typeMasternode, typeIncoming, typeOutgoing)
        {
            /*  Check Type */
            if(!typeAny)
            {
                var type = item.role_type;
                if( ((type === TransactionListModel.TYPE_STAKE_MINT || type === TransactionListModel.TYPE_GENERATED) && !typeStaking)
                    || ((type === TransactionListModel.TYPE_RECV_FROM_OTHER || type === TransactionListModel.TYPE_RECV_WITH_ADDRESS) && !typeIncoming)
                    || ((type === TransactionListModel.TYPE_SEND_TO_ADDRESS || type === TransactionListModel.TYPE_SEND_TO_OTHER || type === TransactionListModel.TYPE_SEND_TO_SELF) && !typeOutgoing))
                {
                    return false;
                }
            }

            /*  Check date range */
            var date = new Date(item.role_datetime);
            date.setHours(0, 0, 0, 0);
            if(date < minDate || date > maxDate)
            {
                return false;
            }

            /*  Check Search input */
            if(!itemSearchMatches(item, searchTerm))
            {
                return false;
            }

            return true;
        }

        function itemSearchMatches(item, searchTerm)
        {
            if(searchTerm.length === 0)
            {
                return true;
            }

            /*  Match Label */
            var label = item.role_label;
            if(label.length > 0)
            {
                var n = item.role_label.search(searchTerm);
                if(n !== -1)
                {
                    return true;
                }
            }
            /*  Match Address   */
            else
            {
                var address = item.role_address;

                if(address.startsWith(searchTerm))
                {
                    return true;
                }
            }

            /*  Match Tx ID */
            if(item.role_txid.startsWith(searchTerm))
            {
                return true;
            }

            return false;
        }

        /** Statistics  **/
        property double totalTransactionValue: 0.0
        property double totalIncoming: 0.0
        property double totalOutgoing: 0.0
    }


    Component.onCompleted: {
        handleFilterUpdate();
    }
}
