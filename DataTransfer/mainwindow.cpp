#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "client.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_clientButton_clicked()
{
    // Create Client
    client = new Client(ui->ipTextEdit->toPlainText(), ui->portTextEdit->toPlainText().toUInt());
}

void MainWindow::on_serverButton_clicked()
{
    // Create Server
    server = new Server(ui->serverportTextEdit->toPlainText());
}
