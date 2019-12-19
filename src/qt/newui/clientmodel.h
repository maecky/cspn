/**
 * @file
 *
 * @brief       Client Model
 *
 * 
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

/*  include guard */
#ifndef _CLIENTMODEL_H_
#define _CLIENTMODEL_H_

/*  BitGreen    */
#include "masternodelist.h"


/*********************************************/
/****			 ClientModel      		  ****/
/*********************************************/

class ClientModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int numMasternodes READ numMasternodes NOTIFY numMasternodesChanged)
    Q_PROPERTY(int numMasternodesEnabled READ numMasternodesEnabled NOTIFY numMasternodesEnabledChanged)

public:
    explicit ClientModel();

    ClientModel(QObject* parent);

    ~ClientModel();

public:

    /**
     * @brief           Create a new Masternode List Model
     */
    MasternodeListModel* masternodeModel();

    /**
     * @brief           Number of masternodes on the Network
     */
    int numMasternodes() const;

    /**
     * @brief           Number of masternodes on the Network that are ENABLED
     */
    int numMasternodesEnabled() const;

Q_SIGNALS:
    void masternodeUpdated(int index, MasternodeListItem item);

    void numMasternodesChanged();

    void numMasternodesEnabledChanged();

private:
};

#endif  /*  include guard */