/**
 * @file
 *
 * @brief       Address List
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
    property alias addressSourceModel: addressList_Model.model

    ListView {
        id: addressList_View

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        model: addressList_Model

        clip: true
    }

    DelegateModel {
        id: addressList_Model

        delegate: AddressListDelegate {
            width: addressList_View.width
            height: 40
        }

        groups: [
            DelegateModelGroup {
                name: "filterGroup"
                includeByDefault: false
            }
        ]
        filterOnGroup: "filterGroup"

        function applyFilter(searchTerm, folder)
        {
            var s = searchTerm.toLowerCase();
            var list = [];

            var count = model.count;
            for(var i = 0; i < count; ++i)
            {
                var item = model.get(i);

                if(itemMatches(item, s))
                {
                    list.push(item.role_folder);
                }
                else
                {
                    continue;
                }

                if(item.role_folder === folder)
                {
                    items.addGroups(i, 1, "filterGroup");
                }
                else
                {
                    items.removeGroups(i, 1, "filterGroup");
                }
            }

            return list;
        }

        function itemMatches(item, searchTerm)
        {
            if(searchTerm.length === 0)
            {
                return true;
            }

            /*  Match label */
            var label = item.role_label.toLowerCase();
            var n = label.search(searchTerm);
            if(n !== -1)
            {
                return true;
            }
            return false;
        }
    }

    /**
     * @brief           Apply a filter to the address list;
     *
     * @param searchTerm      Search term
     * @param folder    Current folder
     *
     * @return          List with filtered folders
     */
    function applyAddressFilter(searchTerm, folder)
    {
        var l = addressList_Model.applyFilter(searchTerm, folder);
        return l;
    }
}
