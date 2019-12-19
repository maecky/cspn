/**
 * @file
 * 
 * @brief       Transaction List Model
 * 
 * 
 * Copyright (c) 2011-2019 The Bitcoin Core developers
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 * 
 */

#include "transactionmodel.h"


/// ***  				*** ///
///	TransactionListModel
/// ***					*** ///

TransactionListModel::TransactionListModel()
{
}

TransactionListModel::TransactionListModel(QObject* parent) : QAbstractListModel(parent)
{
}

TransactionListModel::~TransactionListModel()
{
}

QVariant TransactionListModel::data(const QModelIndex& index, int role) const
{
    Q_UNUSED(role)

    if(index.row() >= 0 && index.row() < _items.size())
    {
        const TransactionRecord& item = _items[index.row()];
        if(role == AddressRole)
        {
            return item.address();
        }
        else if(role == LabelRole)
        {
            return item.label();
        }
        else if(role == DatetimeRole)
        {
            return item.datetime();
        }
        else if(role == TypeRole)
        {
            return item.type();
        }
        else if(role == AmountRole)
        {
            return item.amount();
        }
        else if(role == TxIdRole)
        {
            return item.txId();
        }
        else if(role == StatusRole)
        {
            return item.status();
        }
        else if(role == DepthRole)
        {
            return item.depth();
        }
        else
        {
            QMessageLogger().warning("[TransactionListModel] data() failure: role '%i' not recognized", role);
            return QVariant::Invalid;
        }
    }
    else
    {
        QMessageLogger().warning("[TransactionListModel] data() failure: out of bounds item '%i' requested", index.row());
        return QVariant::Invalid;
    }
}

QVariantMap TransactionListModel::get(int row)
{
    /*
     * Based on
     * https://stackoverflow.com/questions/22711421/how-to-implement-qml-listmodel-like-get-method-for-an-qabstractlistmodel-derived
     */

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

int TransactionListModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent)

    const int s = _items.size();
    return s;
}

QHash<int, QByteArray> TransactionListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[AddressRole] = "role_address";
    roles[LabelRole] = "role_label";
    roles[DatetimeRole] = "role_datetime";
    roles[TypeRole] = "role_type";
    roles[AmountRole] = "role_amount";
    roles[TxIdRole] = "role_txid";
    roles[StatusRole] = "role_status";
    roles[DepthRole] = "role_depth";
    return roles;
}


/// ***  				*** ///
///	TransactionRecord
/// ***					*** ///

TransactionRecord::TransactionRecord() : _type(TransactionListModel::TYPE_OTHER), _amount(0.0), _status(TransactionListModel::STATUS_NONE), _depth(0)
{
}

TransactionRecord::TransactionRecord(const QString& address, const QString& label, const QDateTime& datetime, const TransactionListModel::TransactionType& type,
    const double& amount, const QString& txId, const TransactionListModel::TransactionStatus& status, const int& depth)
        : _address(address), _label(label), _datetime(datetime), _type(type), _amount(amount), _txId(txId), _status(status), _depth(depth)
{
}

TransactionRecord::~TransactionRecord()
{
}

QString TransactionRecord::address() const
{
    return _address;
}

QString TransactionRecord::label() const
{
    return _label;
}

QDateTime TransactionRecord::datetime() const
{
    return _datetime;
}

TransactionListModel::TransactionType TransactionRecord::type() const
{
    return _type;
}

double TransactionRecord::amount() const
{
    return _amount;
}

QString TransactionRecord::txId() const
{
    return _txId;
}

TransactionListModel::TransactionStatus TransactionRecord::status() const
{
    return _status;
}

int TransactionRecord::depth() const
{
    return _depth;
}
