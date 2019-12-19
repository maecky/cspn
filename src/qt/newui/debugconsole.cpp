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

#include "debugconsole.h"

/// ***  				*** ///
///	RpcExecutor
/// ***					*** ///

RpcExecutor::RpcExecutor(QObject* parent) : QObject(parent)
{
}

RpcExecutor::~RpcExecutor()
{
}

void RpcExecutor::request(QString cmd)
{
    QVector<QString> args;
    /*  TODO: parse cmd
        for now just add to args list for development purposes
    */
    args.push_back(cmd);

    if(args.size() == 0)
    {
        return;
    }

    /*  Execute command */
    try
    {
        QString resultStr;

        resultStr = "Example response for '" + args[0] + "' for development purposes \n";
        emit reply(RPC_MESSAGE_REPLY, resultStr);
    }
    catch(const std::exception& e)
    {
        emit reply(RPC_MESSAGE_ERROR, "Error: " + QString::fromStdString(e.what()));
    } 
}


/// ***  				*** ///
///	DebugConsole
/// ***					*** ///

DebugConsole::DebugConsole(QObject* parent) : QObject(parent), _executorThread(nullptr), _executor(nullptr)
{
}

DebugConsole::~DebugConsole()
{
    _executorThread->quit();
    _executor->deleteLater();
}

void DebugConsole::startExecutor()
{
    _executorThread = new QThread();
    QObject::connect(_executorThread, SIGNAL(finished()), _executorThread, SLOT(deleteLater()));

    _executor = new RpcExecutor(nullptr);
    _executor->moveToThread(_executorThread);

    QObject::connect(this, SIGNAL(commandRequest(QString)), _executor, SLOT(request(QString)));
    QObject::connect(_executor, SIGNAL(reply(int, QString)), this, SLOT(handleRpcReply(int, QString)));

    _executorThread->start();
}

void DebugConsole::executeCommand(QString cmd)
{
    if(cmd.length() == 0)
    {
        return;
    }
    emit commandRequest(cmd);
}

void DebugConsole::handleRpcReply(int c, QString r)
{
    emit responseReceived(c, r);
}