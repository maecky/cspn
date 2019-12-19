/**
 * @file
 * 
 * @brief       Wallet Controller
 * 
 * 
 * Copyright (c) 2011-2019 The Bitcoin Core developers
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 * 
 */

#include "walletcontroller.h"

/// ***  				*** ///
///	WalletController
/// ***					*** ///

WalletController::WalletController(QObject* parent) : QObject(parent)
{
    _wallets.push_back(new WalletModel(this));  /*  TODO: load actual wallet */
}

WalletController::~WalletController()
{
}

WalletModel* WalletController::getOpenWallet() const
{
    return _wallets[0];
}
