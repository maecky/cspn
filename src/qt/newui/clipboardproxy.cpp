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

#include "clipboardproxy.h"

/// ***  				*** ///
///	ClipboardProxy
/// ***					*** ///

ClipboardProxy::ClipboardProxy(QClipboard* clipboard, QObject* parent) : QObject(parent), _clipboard(clipboard)
{
    QObject::connect(_clipboard, SIGNAL(dataChanged()), this, SIGNAL(textChanged()));
}

ClipboardProxy::~ClipboardProxy()
{
}

QString ClipboardProxy::text()
{
    return _clipboard->text();
}

void ClipboardProxy::setText(QString t)
{
    _clipboard->setText(t);
}
