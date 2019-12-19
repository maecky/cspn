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

/*  include guard */
#ifndef _WALLETCONTROLLER_H_
#define _WALLETCONTROLLER_H_

/*  BitGreen    */
#include "walletmodel.h"


/*********************************************/
/****           WalletController       	  ****/
/*********************************************/

class WalletController : public QObject
{
    Q_OBJECT

public:
    WalletController(QObject* parent);

    virtual ~WalletController();

public:
    
    /**
     * @brief           Get the wallet model currently open
     */
    WalletModel* getOpenWallet() const;

private:
    QVector<WalletModel*>        _wallets;
};

#endif  /*  include guard */