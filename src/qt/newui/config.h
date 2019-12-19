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

/*  include guard */
#ifndef _CONFIG_H_
#define _CONFIG_H_

/*  Qt */
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

#include <QFile>
#include <QStandardPaths>


#define _CONFIG_FILENAME "config.json"


/*********************************************/
/****			    GuiConfig      		  ****/
/*********************************************/

class GuiConfig
{
public:
    GuiConfig();

    ~GuiConfig();

public:

    QString newsResourcesHost() const;
    void setNewsResourcesHost(const QString& v);


    /**
     * @brief               Query the Write bit
     */
    bool getWriteBit() const;

    /**
     * @brief               Set the Write bit
     */
    void setWrite();

private:
    bool _writeBit;

    /** Attributes **/
    QString _newsResourcesHost;
};


/**
 * @brief                   Get the Application wide config
 */
GuiConfig& globalconfig();


/**
 * @brief                   Try loading up the Config from a JSON document
 * 
 * If any values are missing, defaults will remain.
 * 
 * @param doc               JSON document
 * @param out               Output config
 */
void loadConfig_FromJson(const QJsonDocument& doc, GuiConfig* out);

/**
 * @brief                   Try loading up the Config from a file
 * 
 * See loadConfig_FromJson()
 * 
 * @param path              Path to config file
 * @param out               Output config
 */
void loadConfig_FromFile(const QString& path, GuiConfig* out);

/**
 * @brief                   Save the config to a JSON document
 * 
 * @param config            Config data
 * @param doc               Output document
 * 
 * @return                  Always True
 */
bool storeConfig_ToJson(const GuiConfig& config, QJsonDocument* doc);

/**
 * @brief                   Save the config to File
 *
 * See storeConfig_ToJson()
 * 
 * @param config            Config data
 * @param path              Path to file
 * 
 * @return                  True on success, False on error
 */
bool storeConfig_ToFile(const GuiConfig& config, const QString& path);



/*********************************************/
/****			    Qt Json      		  ****/
/*********************************************/

/**
 * @brief                   Load a JSON document from file
 * 
 * @param path              Path to file
 * @param doc               Output document
 * 
 * @return                  True on success, false on failure
 */
bool loadJson_FromFile(const QString& path, QJsonDocument* doc);

/**
 * @brief                   Store a JSON document to file
 * 
 * @param doc               Input Document
 * @param path              Path to file
 * 
 * @return                  True on success, false on failure
 */
bool storeJson_ToFile(const QJsonDocument& doc, const QString& path);



/*********************************************/
/****			   FileSystem      		  ****/
/*********************************************/

/**
 * @brief                   Get the Application Data location
 * 
 * @param out               Output path
 * 
 * @return                  True on success, False on failure
 */
bool appDataLocation(QString* out);


#endif  /*  include guard */