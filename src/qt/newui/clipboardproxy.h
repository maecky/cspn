/**
 * @file
 * 
 * @brief       QML Clipboard Proxy
 * 
 * 
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 * 
 */

/*  include guard */
#ifndef _CLIPBOARDPROXY_H_
#define _CLIPBOARDPROXY_H_

/*  Qt  */
#include <QObject>
#include <QClipboard>


/*********************************************/
/****		    ClipboardProxy     		  ****/
/*********************************************/

class ClipboardProxy : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)

public:
    explicit ClipboardProxy();

    explicit ClipboardProxy(QWidget*);

    ClipboardProxy(QClipboard* clipboard, QObject* parent);

    ~ClipboardProxy();

public:
    QString text();

public Q_SLOTS:
    void setText(QString t);

Q_SIGNALS:
    void textChanged();

private:
    QClipboard*         _clipboard;
};


#endif  /*  include guard */