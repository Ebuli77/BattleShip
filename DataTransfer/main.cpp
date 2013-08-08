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
#include <QQuickItem>



#include "qmlaccess.h"

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    QQuickView view;

    view.resize(800, 480);
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    //view.setSource(QUrl("resources/qml/main.qml"));
    view.setSource(QUrl("qrc:/qml/MainView.qml"));

    //QObject *item = dynamic_cast<QObject *>(view.rootObject());
    QObject *item = view.rootObject();

    QMLAccess myTarget;

    myTarget.setQmlRoot(item);
    QObject::connect(item, SIGNAL(shipMovedSignal(int,int,int)),&myTarget, SLOT(shipMovement(int,int,int)) );
    QObject::connect(item, SIGNAL(startClientSignal(QString, QString)),&myTarget, SLOT(startClient(QString, QString)) );
    QObject::connect(item, SIGNAL(startServerSignal(QString)),&myTarget, SLOT(startServer(QString)) );


    view.show();
    return app.exec();
}
