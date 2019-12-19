/**
 * @file
 * 
 * @brief       BitGreen Qt-Qml main application
 * 
 * 
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 * 
 */

/*  include guard */
#ifndef _BITGREEN_QT_QML_H_
#define _BITGREEN_QT_QML_H_

/*  BitGreen */
#include "web-resources.h"
#include "config.h"
#include "debugconsole.h"
#include "clipboardproxy.h"
#include "ui-core.h"
#include "transactionmodel.h"
#include "svgimageprovider.h"

/*  Qt  */
#include <QGuiApplication>
//#include <QQmlApplicationEngine>
//#include <QQmlContext>
#include <QSurfaceFormat>

/*  C++ */
#include <csignal>


/*********************************************/
/****			GuiApplication     ***/
/*********************************************/

class GuiApplication : public QGuiApplication
{
    Q_OBJECT
public:
    GuiApplication(int& argc, char* argv[]);

    /**
     * @brief               Copy Constructor. Not defined.
     */
    explicit GuiApplication(const GuiApplication& src);

    virtual ~GuiApplication();

protected:
private:
};

#endif  /*  include guard */
