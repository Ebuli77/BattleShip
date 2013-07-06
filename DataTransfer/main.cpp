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
#include <QQuickView>

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    QQuickView view;
    view.resize(800, 480);
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl("qrc:///foo.qml"));
    view.show();
    return app.exec();
}
