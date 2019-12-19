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

/*  include guard */
#ifndef _UI_CORE_H_
#define _UI_CORE_H_

/*  BitGreen  */
#include "clientmodel.h"
#include "walletcontroller.h"


/*********************************************/
/****            BitgreenCore        	  ****/
/*********************************************/

class BitgreenCore : public QObject
{
    Q_OBJECT

public:
    BitgreenCore();

    virtual ~BitgreenCore();


public:
    ClientModel* clientModel();

    WalletController* walletController();

private:
    ClientModel*            _clientModel;

    WalletController*       _walletController;
};

#endif  /*  include guard */