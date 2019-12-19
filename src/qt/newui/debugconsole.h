/**
 * @file
 * 
 * @brief       Debug Console (RPC)
 * 
 * 
 * Copyright (c) 2011-2019 The Bitcoin Core developers
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 * 
 */

/*  include guard */
#ifndef _DEBUGCONSOLE_H_
#define _DEBUGCONSOLE_H_

/*  Qt  */
#include <QObject>
#include <QVector>
#include <QString>
#include <QThread>


/*********************************************/
/****			 RpcExecutor      		  ****/
/*********************************************/

enum RpcMessageClass
{
    RPC_MESSAGE_NONE = 0,

    RPC_MESSAGE_ERROR,              /**<    Local Gui error, i.e. could not parse command */

    RPC_MESSAGE_REPLY,              /**<    Valid RPC reply received */
    RPC_MESSAGE_REPLY_ERROR         /**<    Received an RPC reply, but is an RPC error */
};

class RpcExecutor : public QObject
{
    Q_OBJECT

public:
    explicit RpcExecutor();

    RpcExecutor(QObject* parent);

    ~RpcExecutor();

public Q_SLOTS:
    void request(QString cmd);

Q_SIGNALS:
    void reply(int c, QString r);

private:
};


/*********************************************/
/****			 DebugConsole      		  ****/
/*********************************************/

class DebugConsole : public QObject
{
    Q_OBJECT

public:
    explicit DebugConsole();

    DebugConsole(QObject* parent);

    ~DebugConsole();

public:
    void startExecutor();

private Q_SLOTS:
    void executeCommand(QString cmd);

    void handleRpcReply(int c, QString r);

Q_SIGNALS:
    void commandRequest(QString cmd);

    /**
     * @brief                   Signal emitted when an RPC reply was received
     * 
     * @param category          Message class
     * @param text              Text
     */
    void responseReceived(int category, QString message);

private:
    /**     Executor    **/
    QThread*        _executorThread;
    RpcExecutor*    _executor;
};


#endif  /*  include guard */
