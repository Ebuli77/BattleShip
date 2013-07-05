#-------------------------------------------------
#
# Project created by QtCreator 2013-06-18T12:23:40
#
#-------------------------------------------------

QT       += core gui network widgets

QMAKE_LFLAGS += -static-libgcc -lpthread

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = DataTransfer
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    client.cpp \
    server.cpp \
    socketconnection.cpp

HEADERS  += mainwindow.h \
    client.h \
    server.h \
    socketconnection.h \
    status.h

FORMS    += mainwindow.ui
