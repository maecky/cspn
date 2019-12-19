/**
 * @file
 *
 * @brief       Masternode List
 *
 * 
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

#include "masternodelist.h"


/// ***  				*** ///
///	MasternodeListItem
/// ***					*** ///

MasternodeListItem::MasternodeListItem() : _status(false)
{
}

MasternodeListItem::MasternodeListItem(const QString& name, const bool& status, const QString& address, const QString& ipAddress)
        : _name(name), _status(status), _address(address), _ipAddress(ipAddress)
{
}

MasternodeListItem::~MasternodeListItem()
{
}

QString MasternodeListItem::name() const
{
    return _name;
}

bool MasternodeListItem::status() const
{
    return _status;
}

QString MasternodeListItem::address() const
{
    return _address;
}

QString MasternodeListItem::ipAddress() const
{
    return _ipAddress;
}


/// ***  				*** ///
///	MasternodeListModel
/// ***					*** ///

MasternodeListModel::MasternodeListModel(QObject* parent) : QAbstractListModel(parent)
{
}

MasternodeListModel::~MasternodeListModel()
{
}

QVariant MasternodeListModel::data(const QModelIndex& index, int role) const
{
    Q_UNUSED(role)

    if(index.row() >= 0 && index.row() < _items.size())
    {
        const MasternodeListItem& item = _items[index.row()];
        if(role == NameRole)
        {
            return item.name();
        }
        else if(role == StatusRole)
        {
            return item.status();
        }
        else if(role == AddressRole)
        {
            return item.address();
        }
        else if(role == IpAddressRole)
        {
            return item.ipAddress();
        }
        else
        {
            QMessageLogger().warning("[MasternodeListModel] data() failure: role '%i' not recognized", role);
            return QVariant::Invalid;
        }
    }
    else
    {
        QMessageLogger().warning("[MasternodeListModel] data() failure: out of bounds item '%i' requested", index.row());
        return QVariant::Invalid;
    }
}

int MasternodeListModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent)

    const int s = _items.size();
    return s;
}

QHash<int, QByteArray> MasternodeListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "role_name";
    roles[StatusRole] = "role_status";
    roles[AddressRole] = "role_address";
    roles[IpAddressRole] = "role_ipaddress";
    return roles;
}

void MasternodeListModel::setMasternodes(QVector<MasternodeListItem> items)
{
    const int s = _items.size();

    QAbstractItemModel::beginResetModel();

    _items = items;

    QAbstractItemModel::endResetModel();

    if(_items.size() != s)
    {
        emit numMasternodesChanged();
    }
}

void MasternodeListModel::updateMasternode(int index, MasternodeListItem item)
{
    if(index < 0 || index >= _items.size())
    {
        QMessageLogger().warning("[MasternodeListModel] updateMasternode() failure: out of bounds index '%i'", index);
        return;
    }

    _items[index] = item;

    QModelIndex topLeft = createIndex(index, 0);
    emit dataChanged(topLeft, topLeft);
}

int MasternodeListModel::numMasternodes() const
{
    return _items.size();
}