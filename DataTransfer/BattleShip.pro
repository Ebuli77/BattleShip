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
    resources/qml/MainView.qml \
    resources/qml/GameGrid.qml \
    resources/qml/Button.qml \




