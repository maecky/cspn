/**
 * @file
 *
 * @brief       Gui Core
 *
 * 
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

#include "ui-core.h"

/// ***  				*** ///
///	BitgreenCore
/// ***					*** ///

BitgreenCore::BitgreenCore() : QObject(nullptr)
{
    _clientModel = new ClientModel(this);

    _walletController = new WalletController(this);
}

BitgreenCore::~BitgreenCore()
{
    delete _clientModel;

    delete _walletController;
}

ClientModel* BitgreenCore::clientModel()
{
    return _clientModel;
}

WalletController* BitgreenCore::walletController()
{
    return _walletController;
}
