/*
#include "mainwindow.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    
    return a.exec();
}
*/
#include <QGuiApplication>
#include <QtQuick/QQuickView>

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    QQuickView view;
    view.resize(800, 480);
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    //view.setSource(QUrl("resources/qml/main.qml"));
    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.show();
    return app.exec();
}
