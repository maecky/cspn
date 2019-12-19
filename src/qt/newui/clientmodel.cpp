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

#include "clientmodel.h"

ClientModel::ClientModel(QObject* parent) : QObject(parent)
{

}

ClientModel::~ClientModel()
{

}

MasternodeListModel* ClientModel::masternodeModel()
{
    MasternodeListModel* model = new MasternodeListModel(this);

    QObject::connect(this, SIGNAL(masternodeUpdated(int, MasternodeListItem)), model, SLOT(updateMasternode(int, MasternodeListItem)));

    return model;
}

int ClientModel::numMasternodes() const
{
    /*  For now return dummy value  */
    return 2185;
}

int ClientModel::numMasternodesEnabled() const
{
    /*  For now return dummy value  */
    return 1850;
}
