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

/*  include guard */
#ifndef _TRANSACTIONMODEL_H_
#define _TRANSACTIONMODEL_H_

/*  Qt  */
#include <QVector>
#include <QDateTime>
#include <QObject>
#include <QAbstractListModel>


class TransactionRecord;

/*********************************************/
/****         TransactionListModel    	  ****/
/*********************************************/

class TransactionListModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)

public:
    TransactionListModel();

    TransactionListModel(QObject* parent);

    virtual ~TransactionListModel();


    enum TransactionType
    {
        TYPE_OTHER              =   0,

        TYPE_GENERATED,

        TYPE_SEND_TO_ADDRESS,

        TYPE_SEND_TO_OTHER,

        TYPE_RECV_WITH_ADDRESS,

        TYPE_RECV_FROM_OTHER,

        TYPE_SEND_TO_SELF,

        TYPE_STAKE_MINT
    };
    Q_ENUMS(TransactionType)

    enum TransactionStatus
    {
        STATUS_NONE             =   0,

        STATUS_CONFIRMED,

        STATUS_UNCONFIRMED,

        STATUS_CONFIRMING,

        STATUS_IMMATURE,

        STATUS_NOT_ACCEPTED
    };
    Q_ENUMS(TransactionStatus)

public:
    virtual QVariant data(const QModelIndex& index, int role) const;

    Q_INVOKABLE QVariantMap get(int row);

    virtual int rowCount(const QModelIndex& parent = QModelIndex()) const;

    enum TransactionRoles
    {
        AddressRole = Qt::UserRole + 1,

        LabelRole,

        DatetimeRole,

        TypeRole,

        AmountRole,

        TxIdRole,

        StatusRole,

        DepthRole
    };

    virtual QHash<int, QByteArray> roleNames() const;

Q_SIGNALS:
    void countChanged(int c);

private:
    QVector<TransactionRecord>          _items;
};


/*********************************************/
/****         TransactionRecord     	  ****/
/*********************************************/

class TransactionRecord
{
public:
    TransactionRecord();

    TransactionRecord(const QString& address, const QString& label, const QDateTime& datetime, const TransactionListModel::TransactionType& type,
                        const double& amount, const QString& txId, const TransactionListModel::TransactionStatus& status, const int& depth);

    virtual ~TransactionRecord();

public:
    /**
     * @brief               'Recipient' address
     */
    QString address() const;

    /**
     * @brief               Label associated with the address
     */
    QString label() const;

    /**
     * @brief               Date and time at which the transaction was created
     */
    QDateTime datetime() const;

    /**
     * @brief               Transaction 'type', i.e. sent received minted etc.
     */
    TransactionListModel::TransactionType type() const;

    /**
     * @brief               Net amount of transaction
     */
    double amount() const;
        
    /**
     * @brief               Unique transaction id, hash
     */
    QString txId() const;

    /**
     * @brief               Transaction confirmation status
     */
    TransactionListModel::TransactionStatus status() const;

    /**
     * @brief               Depth in chain
     */
    int depth() const;

private:
    QString             _address;
    QString             _label;

    QDateTime           _datetime;

    TransactionListModel::TransactionType       _type;

    double              _amount;

    QString             _txId;

    TransactionListModel::TransactionStatus     _status;

    int                 _depth;
};


#endif  /*  include guard */
