/**
 * @file
 * 
 * @brief       Custom QML SVG-Image Provider
 * 
 * 
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 * 
 */

/*  include guard */
#ifndef _SVGIMAGEPROVIDER_H_
#define _SVGIMAGEPROVIDER_H_

/*  Qt  */

#if 0
#include <QQuickImageProvider>
#include <QDomElement>
#endif

#include <QColor>
#include <QFile>
#include <QImage>
#include <QPainter>

#if 0
#include <QSvgRenderer>
#endif

/*********************************************/
/****	       SvgImageProvider  	      ****/
/*********************************************/

class SvgImageProvider : public QQuickImageProvider
{
public:

    SvgImageProvider();

    virtual ~SvgImageProvider();

public:

    virtual QImage requestImage(const QString& id, QSize* size, const QSize& requestedSize);

private:

    static QImage _renderSvg(QFile& file, const QColor& color);

    static void _setXmlAttrRecursive(QDomNode node, const QString& tagname, const QString& attr, const QString& attrVal);

    static QImage _scaleImage(const QImage& img, QSize* size, const QSize& requestedSize);

private:
    QMap<QString, QImage>       _cache;
};


#endif  /*  include guard */
