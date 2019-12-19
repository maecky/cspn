/**
 * @file
 *
 * @brief       BitGreen Network Resources
 *
 * Resources include:
 * - BitGreen news feed
 *
 * Copyright (c) 2019, The BitGreen developers
 * Distributed under the MIT/X11 software license, see the accompanying
 * file COPYING or http://www.opensource.org/licenses/mit-license.php.
 *
 */

#include "web-resources.h"

/// ***  				*** ///
///	WebImageProvider
/// ***					*** ///

WebImageProvider::WebImageProvider() : QQuickImageProvider(QQmlImageProviderBase::Image)
{
}

WebImageProvider::WebImageProvider(const WebImageProvider& src) : QQuickImageProvider(src)
{
}

WebImageProvider::~WebImageProvider()
{
}

QImage WebImageProvider::requestImage(const QString& id, QSize* size, const QSize& requestedSize)
{
    auto it = _images.find(id);
    if(it == _images.end())
    {
        QMessageLogger().warning("[WebImageProvider] requestImage() failure: image '%s' not found", qUtf8Printable(id));
        return QImage();
    }
    QMessageLogger().warning("[WebImageProvider] requestImage() notice: image '%s' of size '%i x %i' requested", qUtf8Printable(id),
                             requestedSize.width(), requestedSize.height());

    const QImage& img = it.value();
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

void WebImageProvider::registerImage(const QString& name, const QImage& image)
{
    _images.insert(name, image);
}


/// ***  				*** ///
///	News_Item
/// ***					*** ///

News_Item::News_Item() : QObject()
{
}

News_Item::News_Item(const News_Item& src) : QObject(),
    _title(src._title), _url(src._url), _source(src._source), _image(src._image), _datetime(src._datetime)
{
}
    
News_Item::~News_Item()
{
}

QString News_Item::title() const
{
    return _title;
}

void News_Item::setTitle(const QString& v)
{
    _title = v;
}

QString News_Item::url() const
{
    return _url;
}

void News_Item::setUrl(const QString& v)
{
    _url = v;
}

QString News_Item::source() const
{
    return _source;
}

void News_Item::setSource(const QString& v)
{
    _source = v;
}

QString News_Item::image() const
{
    return _image;
}

void News_Item::setImage(const QString& v)
{
    _image = v;
}

QDateTime News_Item::datetime() const
{
    return _datetime;
}

void News_Item::setDatetime(const QDateTime& v)
{
    _datetime = v;
}

bool News_Item::fromJson(const QJsonObject& json, News_Item* out)
{
    const QJsonValue title = json.value("title");
    if(!title.isString())
    {
        QMessageLogger().info("[News_Item] fromJson() failure: missing title");
        return false;
    }
    out->_title = title.toString();


    const QJsonValue url = json.value("url");
    if(!url.isString())
    {
        QMessageLogger().info("[News_Item] fromJson() failure: missing url");
        return false;
    }
    out->_url = url.toString();


    const QJsonValue source = json.value("source");
    if(!source.isString())
    {
        QMessageLogger().info("[News_Item] fromJson() failure: missing source");
        return false;
    }
    if(source != "medium" && source != "twitter")
    {
        QMessageLogger().info("[News_Item] fromJson() failure: source '%s' not recognized", qUtf8Printable(source.toString()));
        return false;
    }
    out->_source = source.toString();


    const QJsonValue imageLocation = json.value("imageLocation");
    if(!imageLocation.isString())
    {
        QMessageLogger().info("[News_Item] fromJson() failure: missing image location");
        return false;
    }
    out->_image = imageLocation.toString();


    const QJsonValue datetime = json.value("datetime");
    if(!datetime.isString())
    {
        QMessageLogger().info("[News_Item] fromJson() failure: missing datetime");
        return false;
    }
    const QDateTime dt = QDateTime::fromString(datetime.toString(), "dd-MM-yyyy_hh:mm:ss");
    if(!dt.isValid())
    {
        QMessageLogger().info("[News_Item] fromJson() failure: invalid datetime");
        return false;
    }
    out->_datetime = dt;

    return true;
}

void News_Item::operator=(const News_Item& rhs)
{
    _title = rhs._title;

    _url = rhs._url;

    _source = rhs._source;

    _image = rhs._image;

    _datetime = rhs._datetime;
}

bool News_Item::operator==(const News_Item& rhs) const
{
    return (_title == rhs._title && _url == rhs._url && _source == rhs._source && _image == rhs._image && _datetime == rhs._datetime);
}


/// ***  				*** ///
///	CommunityNews_Item
/// ***					*** ///

CommunityNews_Item::CommunityNews_Item() : News_Item()
{
}

CommunityNews_Item::CommunityNews_Item(const CommunityNews_Item& src) : News_Item(src)
{
}

CommunityNews_Item::~CommunityNews_Item()
{
}

bool CommunityNews_Item::fromJson(const QJsonObject& json, CommunityNews_Item* out)
{
    return News_Item::fromJson(json, out);
}


/// ***  				*** ///
///	NewsModel
/// ***					*** ///

NewsModel::NewsModel(QObject* parent) : QAbstractListModel(parent)
{
}

NewsModel::~NewsModel()
{

}

QVariant NewsModel::data(const QModelIndex& index, int role) const
{
    Q_UNUSED(role)

    if(index.row() >= 0 && index.row() < _items.size())
    {
        const News_Item item = _items[index.row()];     /*  make copy */
        if(role == TitleRole)
        {
            return item.title();
        }
        else if(role == UrlRole)
        {
            return item.url();
        }
        else if(role == SourceRole)
        {
            return item.source();
        }
        else if(role == ImageRole)
        {
            return item.image();
        }
        else if(role == DatetimeRole)
        {
            return item.datetime();
        }
        else
        {
            QMessageLogger().warning("[NewsModel] data() failure: role '%i' not recognized", role);
            return QVariant::Invalid;
        }
    }
    else
    {
        QMessageLogger().warning("[NewsModel] data() failure: out of bounds item '%i' requested", index.row());
        return QVariant::Invalid;
    }
}

int NewsModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent)

    const int s = _items.size();
    return s;
}

QHash<int, QByteArray> NewsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[UrlRole] = "url";
    roles[SourceRole] = "source";
    roles[ImageRole] = "image";
    roles[DatetimeRole] = "datetime";
    return roles;
}

void NewsModel::setNews(QVector<News_Item> items)
{
    QAbstractItemModel::beginResetModel();

    _items = items;

    QAbstractItemModel::endResetModel();
}

/// ***  				*** ///
///	GuiWebResources
/// ***					*** ///

GuiWebResources::GuiWebResources() : QObject(), _qmlImageProvider(nullptr)
{
    _timer = new QTimer(this);
    QObject::connect(_timer, SIGNAL(timeout()), this, SLOT(updateResources()));
}

GuiWebResources::~GuiWebResources()
{
    _timer->stop();
    delete _timer;
}

void GuiWebResources::setImageProvider(WebImageProvider* imageProvider)
{
    _qmlImageProvider = imageProvider;
}

void GuiWebResources::scheduleUpdates()
{
    /*  Load default images */
    {
        QMessageLogger().info("[GuiWebResources] Loading default media images");

        QImage medium;
        if(!medium.load(":icons/news/medium.png"))
        {
            QMessageLogger().warning("[GuiWebResources] scheduleUpdates() warning: failed to load internal 'medium' image");
        }
        _qmlImageProvider->registerImage("medium", medium);

        QImage twitter;
        if(!medium.load(":icons/news/twitter.png"))
        {
            QMessageLogger().warning("[GuiWebResources] scheduleUpdates() warning: failed to load internal 'twitter' image");
        }
        _qmlImageProvider->registerImage("twitter", twitter);
    }


    /*  regular timer: every 30 minutes */
    _timer->start(1800000);

    /*  update in 1 second  */
    QTimer::singleShot(1000, this, SLOT(updateResources()));
}

NewsModel* GuiWebResources::newsModel()
{
    NewsModel* model = new NewsModel(this);

    model->setNews(_newsItems);
    QObject::connect(this, SIGNAL(newsUpdated(QVector<News_Item>)), model, SLOT(setNews(QVector<News_Item>)));

    return model;
}

void GuiWebResources::updateResources()
{
    QMessageLogger().info("[GuiWebResources] Updating Web resources");

    QNetworkAccessManager* manager = globalNetworkManager();
    const GuiConfig& config = globalconfig();
    const QString host = config.newsResourcesHost();

    /****   Community News   ****/
    #if 0
    QNetworkRequest communityNewsRequest;
    communityNewsRequest.setUrl(QUrl(host + "/communitynews"));

    _communityNewsReply = manager->get(communityNewsRequest);
    QObject::connect(_communityNewsReply, SIGNAL(finished()), this, SLOT(handleCommunityNews()));
    #endif

    /****   News   ****/
    QNetworkRequest newsRequest;
    newsRequest.setUrl(QUrl(host + "/news"));

    _newsReply = manager->get(newsRequest);
    QObject::connect(_newsReply, SIGNAL(finished()), this, SLOT(handleNews()));
    QObject::connect(_newsReply, SIGNAL(sslErrors(QList<QSslError>)), this, SLOT(handleSslErrors(QList<QSslError>)));
    QObject::connect(_newsReply, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(handleReplyError(QNetworkReply::NetworkError)));
}

void GuiWebResources::handleNews()
{
    const QString data(_newsReply->readAll());
    _newsReply->deleteLater();
    if(data.length() == 0)
    {
        QMessageLogger().info("[GuiWebResources] handleNews() notice: error encountered / empty reply");
        return;
    }

    const QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8());
    if(!doc.isObject())
    {
        QMessageLogger().warning("[GuiWebResources] handleNews() warning: invalid reply, not a JSON object");
        return;
    }
    const QJsonObject obj = doc.object();

    const QJsonValue newsValue = obj.value("news");
    if(!newsValue.isArray())
    {
        QMessageLogger().warning("[GuiWebResources] handleNews() warning: invalid reply, 'news' not of type ARRAY");
        return;
    }
    const QJsonArray news = newsValue.toArray();

    QVector<News_Item> newNews;
    for(int i = 0; i < news.size(); ++i)
    {
        if(!news[i].isObject())
        {
            QMessageLogger().warning("[GuiWebResources] handleNews() warning: skipping invalid news item '%i'", i);
            continue;
        }
        const QJsonObject obj = news[i].toObject();
        News_Item item;
        if(!News_Item::fromJson(obj, &item))
        {
            continue;
        }

        if(item.image().length() == 0)  /*  default source image */
        {
            item.setImage(item.source());
        }
        else    /*  load image from web */
        {
            /*  TODO: Fetch image from web */
            item.setImage(item.source());   /*  for now use defaults */
        }
        newNews.push_back(item);
    }

    if(_newsItems != newNews)
    {
        _newsItems = newNews;
        QMessageLogger().info("[GuiWebResources] Received '%i' new news items", _newsItems.size());
        emit newsUpdated(_newsItems);
    }
}

void GuiWebResources::handleReplyError(QNetworkReply::NetworkError error)
{
    const QString msg = networkReplyError_To_String(error);
    QMessageLogger().info("[GuiWebResources] Got Network Reply error '%s'", qUtf8Printable(msg));
}

void GuiWebResources::handleSslErrors(QList<QSslError> errors)
{
    if(errors.size() == 1)
    {
        const QSslError& error = errors[0];
        QMessageLogger().info("[GuiWebResources] Got SSL error: '%s'", qUtf8Printable(error.errorString()));
    }
    else if(errors.size() > 1)
    {
        QMessageLogger().info("[GuiWebResources] Multiple SSL errors: %i", (int)errors.size());
        for(int i = 0; i < errors.size(); ++i)
        {
            const QSslError& error = errors[i];
            QMessageLogger().info("[GuiWebResources] -- SSL error: '%s'", qUtf8Printable(error.errorString()));
        }
    }
}

static QNetworkAccessManager** _globalNetworkManager()
{
    static QNetworkAccessManager* p = nullptr;
    return &p;
}

QNetworkAccessManager* globalNetworkManager()
{
    QNetworkAccessManager** p = _globalNetworkManager();
    return *p;
}

void initGlobalNetworkManager()
{
    QNetworkAccessManager** p = _globalNetworkManager();

    QNetworkAccessManager* manager = new QNetworkAccessManager(nullptr);
    *p = manager;
    
    manager->setStrictTransportSecurityEnabled(true);
}

QString networkReplyError_To_String(const QNetworkReply::NetworkError& error)
{
    if(error == QNetworkReply::ConnectionRefusedError)
    {
        return QString("connection refused");
    }
    else if(error == QNetworkReply::RemoteHostClosedError)
    {
        return QString("remote host closed");
    }
    else if(error == QNetworkReply::HostNotFoundError)
    {
        return QString("host not found");
    }
    else if(error == QNetworkReply::TimeoutError)
    {
        return QString("timeout error");
    }
    else if(error == QNetworkReply::OperationCanceledError)
    {
        return QString("operation canceled");
    }
    else if(error == QNetworkReply::SslHandshakeFailedError)
    {
        return QString("ssl handshake failed");
    }
    else if(error == QNetworkReply::TemporaryNetworkFailureError)
    {
        return QString("temporary network failure");
    }
    else if(error == QNetworkReply::NetworkSessionFailedError)
    {
        return QString("network session failed");
    }
    else if(error == QNetworkReply::BackgroundRequestNotAllowedError)
    {
        return QString("background request not allowed");
    }
    else if(error == QNetworkReply::TooManyRedirectsError)
    {
        return QString("too many redirects");
    }
    else if(error == QNetworkReply::InsecureRedirectError)
    {
        return QString("insecure redirect error");
    }
    else if(error == QNetworkReply::ProxyConnectionRefusedError)
    {
        return QString("proxy connection refused");
    }
    else if(error == QNetworkReply::ProxyConnectionClosedError)
    {
        return QString("proxy connection closed");
    }
    else if(error == QNetworkReply::ProxyNotFoundError)
    {
        return QString("proxy not found");
    }
    else if(error == QNetworkReply::ProxyTimeoutError)
    {
        return QString("proxy timeout");
    }
    else if(error == QNetworkReply::ProxyAuthenticationRequiredError)
    {
        return QString("proxy authentication required");
    }
    else if(error == QNetworkReply::ContentAccessDenied)
    {
        return QString("content access denied");
    }
    else if(error == QNetworkReply::ContentOperationNotPermittedError)
    {
        return QString("content operation not premitted");
    }
    else if(error == QNetworkReply::ContentNotFoundError)
    {
        return QString("content not found");
    }
    else if(error == QNetworkReply::AuthenticationRequiredError)
    {
        return QString("authentication required");
    }
    else if(error == QNetworkReply::ContentReSendError)
    {
        return QString("content resend error");
    }
    else if(error == QNetworkReply::ContentConflictError)
    {
        return QString("content conflict");
    }
    else if(error == QNetworkReply::ContentGoneError)
    {
        return QString("content gone");
    }
    else if(error == QNetworkReply::InternalServerError)
    {
        return QString("internal server error");
    }
    else if(error == QNetworkReply::OperationNotImplementedError)
    {
        return QString("operation not implemented");
    }
    else if(error == QNetworkReply::ServiceUnavailableError)
    {
        return QString("service unavailable");
    }
    else if(error == QNetworkReply::ProtocolUnknownError)
    {
        return QString("protocol-unknown error");
    }
    else if(error == QNetworkReply::ProtocolInvalidOperationError)
    {
        return QString("protocol-invalid operation");
    }
    else if(error == QNetworkReply::UnknownNetworkError)
    {
        return QString("unknown network error");
    }
    else if(error == QNetworkReply::UnknownProxyError)
    {
        return QString("unknown proxy error");
    }
    else if(error == QNetworkReply::UnknownContentError)
    {
        return QString("unknown content error");
    }
    else if(error == QNetworkReply::ProtocolFailure)
    {
        return QString("protocol failure");
    }
    else if(error == QNetworkReply::UnknownServerError)
    {
        return QString("unknown server error");
    }
    else
    {
        return QString("error not recognized");
    }
}
