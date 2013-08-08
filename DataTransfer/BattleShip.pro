<<<<<<< HEAD:DataTransfer/DataTransfer.pro
#-------------------------------------------------
#
# Project created by QtCreator 2013-06-18T12:23:40
#
#-------------------------------------------------

QT       += core gui network widgets
QT += quick qml

QMAKE_LFLAGS += -static-libgcc -lpthread

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = DataTransfer
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    client.cpp \
    server.cpp \
    socketconnection.cpp \
    Ship.cpp \
    Fleet.cpp \
    qmlaccess.cpp

HEADERS  += mainwindow.h \
    client.h \
    server.h \
    socketconnection.h \
    status.h \
    Ship.h \
    Fleet.h \
    qmlaccess.h

FORMS    += mainwindow.ui

RESOURCES += \
    resources/res.qrc

OTHER_FILES += \
    resources/qml/Ship.qml \
    resources/qml/main.qml \
    resources/qml/GameGrid.qml \
    resources/qml/Button.qml \
    resources/qml/Startup.qml

=======
#-------------------------------------------------
#
# Project created by QtCreator 2013-06-18T12:23:40
#
#-------------------------------------------------

QT       += core gui network widgets
QT += quick qml

QMAKE_LFLAGS += -static-libgcc -lpthread

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = BattleShip
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    client.cpp \
    server.cpp \
    socketconnection.cpp \
    Ship.cpp \
    Fleet.cpp

HEADERS  += mainwindow.h \
    client.h \
    server.h \
    socketconnection.h \
    status.h \
    Ship.h \
    Fleet.h

FORMS    += mainwindow.ui

RESOURCES += \
    resources/res.qrc

OTHER_FILES += \
    resources/qml/Ship.qml \
    resources/qml/GameGrid.qml \
    resources/qml/Button.qml \
    resources/qml/MainView.qml

>>>>>>> 49d8efa4f2b22001e562bbff9ee27f8c887c5179:DataTransfer/BattleShip.pro