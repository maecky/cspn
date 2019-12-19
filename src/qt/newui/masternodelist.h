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

/*  include guard */
#ifndef _MASTERNODELIST_H_
#define _MASTERNODELIST_H_

/*  Qt  */
#include <QVector>
#include <QObject>
#include <QAbstractListModel>



/*********************************************/
/****         MasternodeListItem    	  ****/
/*********************************************/

class MasternodeListItem
{
public:
    MasternodeListItem();

    MasternodeListItem(const QString& name, const bool& status, const QString& address, const QString& ipAddress);

    virtual ~MasternodeListItem();

public:
    QString name() const;

    bool status() const;

    QString address() const;

    QString ipAddress() const;

private:
    QString             _name;
    bool                _status;
    QString             _address;
    QString             _ipAddress;
};


/*********************************************/
/****         MasternodeListModel    	  ****/
/*********************************************/

class MasternodeListModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int numMasternodes READ numMasternodes NOTIFY numMasternodesChanged)

public:
    MasternodeListModel(QObject* parent);

    virtual ~MasternodeListModel();

public:
    virtual QVariant data(const QModelIndex& index, int role) const;

    virtual int rowCount(const QModelIndex& parent) const;

    enum MasternodeRoles
    {
        NameRole = Qt::UserRole + 1,
        StatusRole,
        AddressRole,
        IpAddressRole
    };

    virtual QHash<int, QByteArray> roleNames() const;

    int numMasternodes() const;

public Q_SLOTS:
    void setMasternodes(QVector<MasternodeListItem> items);

    void updateMasternode(int index, MasternodeListItem item);

Q_SIGNALS:
    void numMasternodesChanged();

private:
    QVector<MasternodeListItem>          _items;
};

#endif  /*  include guard */