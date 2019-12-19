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

#include "svgimageprovider.h"


/// ***  				*** ///
///	SvgImageProvider
/// ***					*** ///

SvgImageProvider::SvgImageProvider() : QQuickImageProvider(QQmlImageProviderBase::Image)
{
}

SvgImageProvider::~SvgImageProvider()
{
}

QImage SvgImageProvider::requestImage(const QString& id, QSize* size, const QSize& requestedSize)
{
    /*  Look in cache  */
    auto it = _cache.find(id);
    if(it != _cache.end())
    {
        QMessageLogger().debug("[SvgImageProvider] Image '%s' found in cache", qUtf8Printable(id));
        return _scaleImage(it.value(), size, requestedSize);
    }

    QColor color;

    /*  Parse id    */
    const QStringList list = id.split(" ", QString::SkipEmptyParts);
    if(list.size() == 0)
    {
        QMessageLogger().warning("[SvgImageProvider] requestImage() failure: empty image id");
        return QImage();
    }
    for(int i = 1; i < list.size(); ++i)
    {
        const QString s = list[i];
        if(s[0] == '#')     /*  color   */
        {
            color.setNamedColor(s);
            if(!color.isValid())
            {
                QMessageLogger().warning("[SvgImageProvider] requestImage() warning: invalid color '%s'", qUtf8Printable(s));
            }
        }
    }

    QFile file;
    file.setFileName(list[0]);

    if(!file.open(QIODevice::ReadOnly))
    {
        QMessageLogger().warning("[SvgImageProvider] requestImage() failure: failed to load image file '%s'", qUtf8Printable(list[0]));
        return QImage();
    }

    QMessageLogger().debug("[SvgImageProvider] Rendering '%s'", qUtf8Printable(id));
    const QImage rendered = _renderSvg(file, color);

    _cache.insert(id, rendered);

    return _scaleImage(rendered, size, requestedSize);
}

QImage SvgImageProvider::_renderSvg(QFile& file, const QColor& color)
{
    /*  Based on https://stackoverflow.com/questions/15123544/change-the-color-of-an-svg-in-qt  */

    const QByteArray data = file.readAll();

    QDomDocument doc;
    doc.setContent(data);

    /*  Recursively change the color */
    if(color.isValid())
    {
        _setXmlAttrRecursive(doc, "path", "fill", color.name(QColor::QColor::HexRgb));
    }

    QSvgRenderer renderer(doc.toByteArray());

    QPixmap pixmap(renderer.defaultSize());
    pixmap.fill(Qt::transparent);

    /*  Paint   */
    QPainter painter;
    painter.begin(&pixmap);

    renderer.render(&painter);
    painter.end();

    return pixmap.toImage();
}

void SvgImageProvider::_setXmlAttrRecursive(QDomNode node, const QString& tagname, const QString& attr, const QString& attrVal)
{
    /*  If it has the tagname then overwritte desired attribute */
    QDomElement element = node.toElement();
    if(element.toElement().tagName().compare(tagname) == 0)
    {
        element.setAttribute(attr, attrVal);
    }

    /*  Loop all children   */
    QDomNodeList list = node.childNodes();
    for(int i = 0; i < list.count(); i++)
    {
        if(!list.at(i).isElement())
        {
            continue;
        }
        _setXmlAttrRecursive(list.at(i), tagname, attr, attrVal);
    }
}

QImage SvgImageProvider::_scaleImage(const QImage& img, QSize* size, const QSize& requestedSize)
{
    if(size != nullptr)
    {
        *size = img.size();
    }

    if(requestedSize == img.size())
    {
        return img;
    }
    else
    {
        const QImage scaled = img.scaled(requestedSize);
        return scaled;
    }
}
