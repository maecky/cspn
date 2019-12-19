/**
 * @file
 * 
 * @brief       BitGreen Gui Configuration
 * 
 * 
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 * 
 */

#include "config.h"


/// ***  				*** ///
///	GuiConfig
/// ***					*** ///

GuiConfig::GuiConfig() : _writeBit(false)
{
    /*  Set defaults */
    _newsResourcesHost = "https://news.bitg.blueg.org";
}

GuiConfig::~GuiConfig()
{
}

QString GuiConfig::newsResourcesHost() const
{
    return _newsResourcesHost;
}

void GuiConfig::setNewsResourcesHost(const QString& v)
{
    if(_newsResourcesHost != v)
    {
        setWrite();
        _newsResourcesHost = v;
    }
}

bool GuiConfig::getWriteBit() const
{
    return _writeBit;
}

void GuiConfig::setWrite()
{
    _writeBit = true;
}

GuiConfig& globalconfig()
{
    static GuiConfig s;
    return s;
}

void loadConfig_FromJson(const QJsonDocument& doc, GuiConfig* out)
{
    if(!doc.isObject())
    {
        QMessageLogger().critical("loadConfig_FromJson() failure: document is not Json-Object");
        return;
    }

    const QJsonObject obj = doc.object();
    
    /****   Fill up Config through JSON ****/
    
    /*  newsResourcesHost */
    const QJsonValue newsResourcesHost = obj.value("newsResourcesHost");
    if(newsResourcesHost.isString())
    {
        out->setNewsResourcesHost(newsResourcesHost.toString());
    }

}

void loadConfig_FromFile(const QString& path, GuiConfig* out)
{
    QJsonDocument doc;
    if(!loadJson_FromFile(path, &doc))
    {
        QMessageLogger().critical("loadJson_FromFile() failure: failed to load JSON file");
        out->setWrite();
        return;
    }

    loadConfig_FromJson(doc, out);
}

bool storeConfig_ToJson(const GuiConfig& config, QJsonDocument* doc)
{
    QJsonObject obj;

    /****   Fill up JSON through config ****/
    obj.insert("newsResourcesHost", config.newsResourcesHost());

    doc->setObject(obj);
    return true;    /*  always true */
}

bool storeConfig_ToFile(const GuiConfig& config, const QString& path)
{
    QJsonDocument doc;
    storeConfig_ToJson(config, &doc);

    if(!storeJson_ToFile(doc, path))
    {
        QMessageLogger().critical("loadJson_FromFile() failure: failed to write JSON file");
        return false;
    }

    return true;
}



/// ***  				*** ///
///	Qt Json
/// ***					*** ///

bool loadJson_FromFile(const QString& path, QJsonDocument* doc)
{
    QFile f;
    f.setFileName(path);

    if(!f.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QMessageLogger().warning("loadJson_FromFile() failure: failed to load file '%s'", qUtf8Printable(path));
        return false;
    }

    const QByteArray data = f.readAll();

    /****   Parse JSON  ****/
    QJsonParseError error;
    const QJsonDocument d = QJsonDocument::fromJson(data, &error);
    
    /*  Check if successfull */
    if(d.isNull())  /*  failure */
    {
        QMessageLogger().warning("loadJson_FromFile() failure: failed to load JSON file '%s': %s", qUtf8Printable(path), qUtf8Printable(error.errorString()));
        return false;
    }

    /****   Success ****/
    *doc = d;

    return true;
}

bool storeJson_ToFile(const QJsonDocument& doc, const QString& path)
{
    QFile f;
    f.setFileName(path);

    if(!f.open(QIODevice::WriteOnly))
    {
        QMessageLogger().warning("storeJson_ToFile() failure: failed to open file '%s'", qUtf8Printable(path));
        return false;
    }

    const QByteArray s = doc.toJson();
    if(f.write(s) < 0)
    {
        QMessageLogger().warning("storeJson_ToFile() warning: errors were encountered writing file '%s'", qUtf8Printable(path));
    }

    return true;
}



/// ***  				*** ///
///	FileSystem
/// ***					*** ///

bool appDataLocation(QString* out)
{
    /*
        Get the path to the Application Directory

        Windows: "C:/Users/<USER>/AppData/Roaming/<APPNAME>"
        MacOs: "~/Library/Application Support/<APPNAME>"
        Linux: "~/.local/share/<APPNAME>"
    */
    const QStringList locations = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation);

    if(locations.isEmpty())
    {
        QMessageLogger().critical("appDataLocation() failure: failed to determine standard data location");
        /*  normally this should not happen */
        return false;
    }
    else
    {
        QMessageLogger().info("appDataLocation() notice: using data location '%s'", qUtf8Printable(locations[0]));
    }

    /*  get first location */
    *out = locations[0];

    return true;
}