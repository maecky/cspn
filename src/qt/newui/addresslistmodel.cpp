/**
 * @file
 * 
 * @brief       Address List Model
 * 
 * 
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 * 
 */

#include "addresslistmodel.h"

/// ***  				*** ///
///	FolderListItem
/// ***					*** ///

FolderListItem::FolderListItem()
{
}

FolderListItem::FolderListItem(const QString& name, const int& count) : _name(name), _count(count)
{
}

FolderListItem::~FolderListItem()
{
}

QString FolderListItem::name() const
{
    return _name;
}

void FolderListItem::setName(const QString& v)
{
    _name = v;
}

int FolderListItem::count() const
{
    return _count;
}

void FolderListItem::setCount(const int& v)
{
    _count = v;
}


/// ***  				*** ///
///	FolderListModel
/// ***					*** ///

FolderListModel::FolderListModel(AddressListModel* parent) : QAbstractListModel(parent)
{
}

FolderListModel::~FolderListModel()
{
}

QVariant FolderListModel::data(const QModelIndex& index, int role) const
{
    if(index.row() >= 0 && index.row() < _items.size())
    {
        const FolderListItem& item = _items[index.row()];
        if(role == NameRole)
        {
            return item.name();
        }
        else if(role == CountRole)
        {
            return item.count();
        }
        else
        {
            QMessageLogger().warning("[FolderListModel] data() failure: role '%i' not recognized", role);
            return QVariant::Invalid;
        }
    }
    else
    {
        QMessageLogger().warning("[FolderListModel] data() failure: out of bounds item '%i' requested", index.row());
        return QVariant::Invalid;
    }
}

QVariantMap FolderListModel::get(int row)
{
    const QModelIndex idx = index(row, 0);
    QHashIterator<int, QByteArray> i(roleNames());

    QVariantMap res;
    while (i.hasNext())
    {
        i.next();

        res[i.value()] = idx.data(i.key());
    }
    return res;
}

int FolderListModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent)

    const int s = _items.size();
    return s;
}

QHash<int, QByteArray> FolderListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "role_name";
    roles[CountRole] = "role_count";
    return roles;
}

void FolderListModel::buildModel(const QVector<AddressListItem>& addresses)
{
    beginResetModel();

    for(int i = 0; i < addresses.size(); ++i)
    {
        const QString folder = addresses[i].folder();
        add(folder);
    }

    endResetModel();
}

void FolderListModel::add(const QString& folder)
{
    for(int i = 0; i < _items.size(); ++i)
    {
        FolderListItem& t = _items[i];
        if(t.name() == folder)
        {
            t.setCount(t.count() + 1);
            return;
        }
    }
}



/// ***  				*** ///
///	AddressListItem
/// ***					*** ///

AddressListItem::AddressListItem()
{
}

AddressListItem::AddressListItem(const QString& address, const QString& label, const QString& folder)
        : _address(address), _label(label), _folder(folder)
{
}

AddressListItem::~AddressListItem()
{
}

QString AddressListItem::address() const
{
    return _address;
}

QString AddressListItem::label() const
{
    return _label;
}

QString AddressListItem::folder() const
{
    return _folder;
}


/// ***  				*** ///
///	AddressListModel
/// ***					*** ///

AddressListModel::AddressListModel(QObject* parent) : QAbstractListModel(parent)
{
    _folderListModel = new FolderListModel(this);
    _folderListModel->buildModel(_items);
}

AddressListModel::~AddressListModel()
{
}

QVariant AddressListModel::data(const QModelIndex& index, int role) const
{
    Q_UNUSED(role)

    if(index.row() >= 0 && index.row() < _items.size())
    {
        const AddressListItem& item = _items[index.row()];
        if(role == AddressRole)
        {
            return item.address();
        }
        else if(role == LabelRole)
        {
            return item.label();
        }
        else if(role == FolderRole)
        {
            return item.folder();
        }
        else
        {
            QMessageLogger().warning("[AddressListModel] data() failure: role '%i' not recognized", role);
            return QVariant::Invalid;
        }
    }
    else
    {
        QMessageLogger().warning("[AddressListModel] data() failure: out of bounds item '%i' requested", index.row());
        return QVariant::Invalid;
    }
}

bool AddressListModel::setData(const QModelIndex& index, const QVariant& value, int role)
{
    if(index.row() >= 0 && index.row() < _items.size())
    {
        AddressListItem& item = _items[index.row()];
        if(role == LabelRole)
        {
        }
        else
        {
            QMessageLogger().warning("[AddressListModel] setData() failure: role '%i' not recognized", role);
            return false;
        }

        emit dataChanged(index, index, QVector<int>(role));
        return true;
    }
    else
    {
        QMessageLogger().warning("[AddressListModel] setData() failure: out of bounds item '%i' requested", index.row());

        return false;
    }
}

QVariantMap AddressListModel::get(int row)
{
    const QModelIndex idx = index(row, 0);
    QHashIterator<int, QByteArray> i(roleNames());

    QVariantMap res;
    while (i.hasNext())
    {
        i.next();

        res[i.value()] = idx.data(i.key());
    }
    return res;
}

int AddressListModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent)

    const int s = _items.size();
    return s;
}

QHash<int, QByteArray> AddressListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[AddressRole] = "role_address";
    roles[LabelRole] = "role_label";
    roles[FolderRole] = "role_folder";
    return roles;
}

Qt::ItemFlags AddressListModel::flags(const QModelIndex& index) const
{
    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

FolderListModel* AddressListModel::folderListModel()
{
    return _folderListModel;
}
