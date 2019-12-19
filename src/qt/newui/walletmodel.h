/**
 * @file
 * 
 * @brief       Wallet Model
 * 
 * 
 * Copyright (c) 2011-2019 The Bitcoin Core developers
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 * 
 */

/*  include guard */
#ifndef _WALLETMODEL_H_
#define _WALLETMODEL_H_

/*  Qt  */
#include <QObject>

/*  BitGreen    */
#include "transactionmodel.h"
#include "addresslistmodel.h"

/*********************************************/
/****              WalletModel       	  ****/
/*********************************************/

class WalletModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString primaryAddress READ primaryAddress NOTIFY primaryAddressChanged)

public:
    WalletModel(QObject* parent);

    virtual ~WalletModel();

public:

    TransactionListModel* transactionModel();

    /**
     * @brief               Wallet Address list model
     */
    AddressListModel* addressModel();

    /**
     * @brief               Address Book model (i.e. sending addresses)
     */
    AddressListModel* addressBookModel();


    /**
     * @brief               Wallet 'primary address'
     */
    QString primaryAddress();

Q_SIGNALS:
    void primaryAddressChanged();

private:
    TransactionListModel*               _transactionModel;

    AddressListModel*                   _addressModel;
    QString                             _primaryAddress;

    AddressListModel*                   _addressBookModel;
};

#endif  /*  include guard */