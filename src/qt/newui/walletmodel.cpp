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

#include "walletmodel.h"

/// ***  				*** ///
///	WalletModel
/// ***					*** ///

WalletModel::WalletModel(QObject* parent) : QObject(parent)
{
    _transactionModel = new TransactionListModel(this);

    _addressModel = new AddressListModel(this);
    _primaryAddress = "";

    _addressBookModel = new AddressListModel(this);
}

WalletModel::~WalletModel()
{
}

TransactionListModel* WalletModel::transactionModel()
{
    return _transactionModel;
}

AddressListModel* WalletModel::addressModel()
{
    return _addressModel;
}

AddressListModel* WalletModel::addressBookModel()
{
    return _addressBookModel;
}

QString WalletModel::primaryAddress()
{
    return _primaryAddress;
}
