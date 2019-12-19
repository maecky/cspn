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

#include "bitgreen-qt-qml.h"

/// ***  				*** ///
///	GuiApplication
/// ***					*** ///

GuiApplication::GuiApplication(int& argc, char* argv[]) : QGuiApplication(argc, argv)
{
}

GuiApplication::~GuiApplication()
{
}



/// ***  				*** ///
///	Main
/// ***					*** ///

static void handleSignal(int sig)
{
	Q_UNUSED(sig);

    QMessageLogger().info("[Main] Received signal. Stopping application");

    GuiApplication* app = (GuiApplication*)QGuiApplication::instance();
    app->quit();
}

int main(int argc, char* argv[])
{
	/****       Initialize Qt Application       ****/
	/****       						        ****/

	GuiApplication app(argc, argv);

	std::signal(SIGINT, handleSignal);
	std::signal(SIGTERM, handleSignal);

	QMessageLogger().info("[Main] BitGreen-Qt-Qml Application starting");

	qRegisterMetaType<MasternodeListItem>("MasternodeListItem");

	/****	            Load Config                 ****/
    /****                                           ****/

    QString appLocation;
    appDataLocation(&appLocation);

	GuiConfig& config = globalconfig();
	const QString configPath = appLocation + QDir::separator() + _CONFIG_FILENAME;
	loadConfig_FromFile(configPath, &config);

	initGlobalNetworkManager();	


	GuiWebResources webResources;

    DebugConsole debugConsole(&app);
    debugConsole.startExecutor();

	BitgreenCore core;
	ClientModel* clientModel = core.clientModel();


	/****           Load QML-based UI          	****/
	/****          					          	****/
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QSurfaceFormat format;
    format.setSamples(16);
    QSurfaceFormat::setDefaultFormat(format);

    QQmlApplicationEngine engine;
    QQmlContext* rootContext = engine.rootContext();

    rootContext->setContextProperty("cNewsModel", webResources.newsModel());
	rootContext->setContextProperty("cMasternodeModel", clientModel->masternodeModel());
	rootContext->setContextProperty("cClientModel", clientModel);
	rootContext->setContextProperty("cWalletModel", core.walletController()->getOpenWallet());
	rootContext->setContextProperty("cTransactionModel", core.walletController()->getOpenWallet()->transactionModel());
	rootContext->setContextProperty("cAddressListModel", core.walletController()->getOpenWallet()->addressModel());
	rootContext->setContextProperty("cAddressFolderListModel", core.walletController()->getOpenWallet()->addressModel()->folderListModel());
    rootContext->setContextProperty("cDebugConsole", &debugConsole);

	ClipboardProxy* clipboard = new ClipboardProxy(QGuiApplication::clipboard(), nullptr);
	rootContext->setContextProperty("cClipboard", clipboard);

	WebImageProvider* webImageProvider = new WebImageProvider();
	webResources.setImageProvider(webImageProvider);
	webResources.scheduleUpdates();
    engine.addImageProvider("webimages", webImageProvider);

	SvgImageProvider* svgImageProvider = new SvgImageProvider();
	engine.addImageProvider("svg", svgImageProvider);

	qmlRegisterType<TransactionListModel>("org.bitg", 1, 0, "TransactionListModel");

	/*	Load main dialog */
    engine.load(QUrl(QStringLiteral("qrc:/maindialog.qml")));
    const QList<QObject*> rootObjects = engine.rootObjects();
    if(rootObjects.isEmpty())
	{
		QMessageLogger().critical("[Main] Failed to Load QML: maindialog.qml");
		return 1;
	}
    QObject* qmlRootObject = rootObjects[0];

    QObject* qmlDebugPage = qmlRootObject->findChild<QObject*>("debugPage");
    QObject::connect(qmlDebugPage, SIGNAL(rpcCommandRequested(QString)), &debugConsole, SLOT(executeCommand(QString)));


	/****      	    Start Qt Application 	    ****/
	/****       							    ****/

	app.exec();

	

	/****      	    	Cleanup			 	    ****/
	/****       							    ****/

	if(config.getWriteBit())
	{
        QMessageLogger().info("[Main] Config changed, writing changes to disk");

		/*  Check whether directory exists */
        const QDir dir(appLocation);
        if(!dir.exists())
        {
            QMessageLogger().info("[Main] Application Data directory '%s' does not exist yet, creating it", qUtf8Printable(appLocation));
            QDir().mkpath(appLocation);
        }
        storeConfig_ToFile(config, configPath);
	}


	QMessageLogger().info("[Main] BitGreen-Qt-Qml Application exiting normally");
	return 0;
}
