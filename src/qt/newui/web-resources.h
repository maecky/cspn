/**
 * @file
 *
 * @brief       BitGreen Web Resources
 *
 * Resources include:
 * - BitGreen news feed
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

/*  include guard */
#ifndef _WEB_RESOURCES_H_
#define _WEB_RESOURCES_H_

/*  BitGreen */
#include <qt/bitcoingui.h>

/*  Qt */
#include <QObject>
#include <QString>
#include <QMap>
#include <QPointer>
#include <QDir>
#include <QImage>
#include <QTimer>

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

#if 0
#include <QQmlListProperty>
#include <QAbstractItemModel>
#include <QQuickImageProvider>
#endif

#define _WEB_RESOURCES_DIRECTORY "web"



/*********************************************/
/****	       WebImageProvider  	      ****/
/*********************************************/

class WebImageProvider : public QQuickImageProvider
{
public:

    WebImageProvider();

    WebImageProvider(const WebImageProvider& src);

    virtual ~WebImageProvider();

public:

    virtual QImage requestImage(const QString& id, QSize* size, const QSize& requestedSize);

    void registerImage(const QString& name, const QImage& image);

private:
    QMap<QString, QImage> _images;
};


/*********************************************/
/****	            News_Item  		      ****/
/*********************************************/

class News_Item : public QObject
{
    Q_OBJECT

public:

    News_Item();

    News_Item(const News_Item& src);
    
    virtual ~News_Item();


public:

    QString title() const;

    void setTitle(const QString& v);

    QString url() const;

    void setUrl(const QString& v);

    QString source() const;

    void setSource(const QString& v);

    QString image() const;

    void setImage(const QString& v);

    QDateTime datetime() const;

    void setDatetime(const QDateTime& v);


    static bool fromJson(const QJsonObject& json, News_Item* out);

    void operator=(const News_Item& rhs);

    bool operator==(const News_Item& rhs) const;

private:
    QString _title;

    QString _url;

    QString _source;        /**<    Media source, i.e. "medium" or "twitter" */

    QString _image;

    QDateTime _datetime;
};


/*********************************************/
/****	    CommunityNews_Item  		  ****/
/*********************************************/

class CommunityNews_Item : public News_Item
{
    Q_OBJECT

public:
    CommunityNews_Item();

    CommunityNews_Item(const CommunityNews_Item& src);

    virtual ~CommunityNews_Item();

public:

    static bool fromJson(const QJsonObject& json, CommunityNews_Item* out);

private:
};



/*********************************************/
/****              NewsModel    		  ****/
/*********************************************/

/* More information regarding using C++ models with Qt Quick views
 * can be found at:
 *
 * https://doc.qt.io/qt-5/qtquick-modelviewsdata-cppmodels.html#qabstractitemmodel
 * https://doc.qt.io/qt-5/qtqml-cppintegration-exposecppattributes.html#
 */
class NewsModel : public QAbstractListModel
{
    Q_OBJECT

public:
    NewsModel(QObject* parent);

    virtual ~NewsModel();

public:
    virtual QVariant data(const QModelIndex& index, int role) const;

    virtual int rowCount(const QModelIndex& parent) const;

    enum NewsRoles
    {
        TitleRole = Qt::UserRole + 1,
        UrlRole,
        SourceRole,
        ImageRole,
        DatetimeRole
    };

    virtual QHash<int, QByteArray> roleNames() const;

public Q_SLOTS:
    void setNews(QVector<News_Item> items);

private:
    QVector<News_Item>          _items;
};


/*********************************************/
/****		    GuiWebResources    		  ****/
/*********************************************/

class GuiWebResources : public QObject
{
    Q_OBJECT

public:

    GuiWebResources();

    ~GuiWebResources();

public:

    void setImageProvider(WebImageProvider* imageProvider);

    /**
     * @brief                       Schedule updates to update the resources from the internet
     */
    void scheduleUpdates();

    NewsModel* newsModel();

public Q_SLOTS:
    void updateResources();

    void handleNews();

    void handleReplyError(QNetworkReply::NetworkError error);

    void handleSslErrors(QList<QSslError> errors);

Q_SIGNALS:
    void newsUpdated(QVector<News_Item>);

private:
    QTimer* _timer;

    WebImageProvider* _qmlImageProvider;

    QPointer<QNetworkReply> _communityNewsReply;

    QPointer<QNetworkReply> _newsReply;
    QVector<News_Item>       _newsItems;
};


/**
 * @brief                           Get the Global QNetworkAccessManager
 */
QNetworkAccessManager* globalNetworkManager();

/**
 * @brief                           Initialize the Global QNetworkAccessManager
 */
void initGlobalNetworkManager();

QString networkReplyError_To_String(const QNetworkReply::NetworkError& error);


#endif  /*  include guard */
