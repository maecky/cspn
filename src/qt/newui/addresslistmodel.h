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

/*  include guard */
#ifndef _ADDRESSLISTMODEL_H_
#define _ADDRESSLISTMODEL_H_


/*  Qt  */
#include <QVector>
#include <QObject>
#include <QAbstractListModel>


class AddressListModel;
class AddressListItem;

/*********************************************/
/****           FolderListItem    	      ****/
/*********************************************/

class FolderListItem
{
public:
    FolderListItem();

    FolderListItem(const QString& name, const int& count);

    ~FolderListItem();

public:
    QString name() const;

    void setName(const QString& v);

    int count() const;

    void setCount(const int& v);

private:
    QString         _name;

    int             _count;
};


/*********************************************/
/****           FolderListModel    	      ****/
/*********************************************/

class FolderListModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)

public:
    FolderListModel(AddressListModel* parent);

    virtual ~FolderListModel();

public:
    virtual QVariant data(const QModelIndex& index, int role) const;

    Q_INVOKABLE QVariantMap get(int row);

    virtual int rowCount(const QModelIndex& parent = QModelIndex()) const;

    enum FolderRoles
    {
        NameRole = Qt::UserRole + 1,
        CountRole       /**<    Number of addresses in this folder  */
    };

    virtual QHash<int, QByteArray> roleNames() const;


    /**
     * @brief           Build the Folder List Model from scratch, based on addresses
     */
    void buildModel(const QVector<AddressListItem>& addresses);

Q_SIGNALS:
    void countChanged();

private:
    void add(const QString& folder);

private:
    QVector<FolderListItem>         _items;
};


/*********************************************/
/****           AddressListItem    	      ****/
/*********************************************/

class AddressListItem
{
public:
    AddressListItem();

    AddressListItem(const QString& address, const QString& label, const QString& folder);

    virtual ~AddressListItem();

public:
    QString address() const;

    QString label() const;

    QString folder() const;


private:
    QString             _address;

    QString             _label;
    QString             _folder;
};


/*********************************************/
/****           AddressListModel    	  ****/
/*********************************************/

class AddressListModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)

public:
    AddressListModel(QObject* parent);

    virtual ~AddressListModel();

public:
    virtual QVariant data(const QModelIndex& index, int role) const;

    virtual bool setData(const QModelIndex& index, const QVariant& value, int role);

    Q_INVOKABLE QVariantMap get(int row);

    virtual int rowCount(const QModelIndex& parent = QModelIndex()) const;

    enum AddressRoles
    {
        AddressRole = Qt::UserRole + 1,
        LabelRole,
        FolderRole
    };

    virtual QHash<int, QByteArray> roleNames() const;

    virtual Qt::ItemFlags flags(const QModelIndex& index) const;


    FolderListModel* folderListModel();

    /**
     * @brief               Build the initial Folder List Model
     */
    void buildFolderListModel();

Q_SIGNALS:
    void countChanged();

private:
    QVector<AddressListItem>            _items;

    FolderListModel*                    _folderListModel;
};


#endif  /*  include guard   */
