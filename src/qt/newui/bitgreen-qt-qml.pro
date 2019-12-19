##
## Brief: Main QMake project file
##
## Copyright (c) 2019, The BitGreen developers
## Distributed under the MIT/X11 software license, see the accompanying
## file COPYING or http://www.opensource.org/licenses/mit-license.php.
##

####    	Target
TARGET				=		bitgreen-qt-qml
TEMPLATE			=		app

DESTDIR             =       build
OBJECTS_DIR         =       build
MOC_DIR             =       build
UI_DIR              =       build
RCC_DIR             =       build


####		Qt
QT 					+= core gui svg xml quick qml quickcontrols2


####		Configuration
CONFIG              +=      warn_on c++14 debug

macx {
    CONFIG          +=      app_bundle
}


####        Compilation
CXXFLAGS            +=
LFLAGS              +=


####        Libraries
LIBS                +=



###############################################################
####               Sources & Resources
###############################################################

####        Resources
RESOURCES           +=      resources/qml.qrc           \
                            resources/icons.qrc


####        Sources
SOURCES 			+= 		bitgreen-qt-qml.cpp         \
                            web-resources.cpp           \
                            config.cpp                  \
                            debugconsole.cpp            \
                            clipboardproxy.cpp          \
                            masternodelist.cpp          \
                            clientmodel.cpp             \
                            ui-core.cpp                 \
                            walletmodel.cpp             \
                            walletcontroller.cpp        \
                            transactionmodel.cpp        \
                            svgimageprovider.cpp        \
                            addresslistmodel.cpp


HEADERS				+=		bitgreen-qt-qml.h           \
                            web-resources.h             \
                            config.h                    \
                            debugconsole.h              \
                            clipboardproxy.h            \
                            masternodelist.h            \
                            clientmodel.h               \
                            ui-core.h                   \
                            walletmodel.h               \
                            walletcontroller.h          \
                            transactionmodel.h          \
                            svgimageprovider.h          \
                            addresslistmodel.h