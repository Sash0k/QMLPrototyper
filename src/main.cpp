/*******************************************************************************
**
** Copyright (C) 2022 ru.mastercond
**
** This file is part of the Приложение для создания кода интерфейса на QML прямо на телефоне или планшете под управлением ОС Аврора project.
**
** Redistribution and use in source and binary forms,
** with or without modification, are permitted provided
** that the following conditions are met:
**
** * Redistributions of source code must retain the above copyright notice,
**   this list of conditions and the following disclaimer.
** * Redistributions in binary form must reproduce the above copyright notice,
**   this list of conditions and the following disclaimer
**   in the documentation and/or other materials provided with the distribution.
** * Neither the name of the copyright holder nor the names of its contributors
**   may be used to endorse or promote products derived from this software
**   without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
** THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
** FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
** IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
** FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
** OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
** PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS;
** OR BUSINESS INTERRUPTION)
** HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
** WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE)
** ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
** EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
*******************************************************************************/

#include <auroraapp.h>
#include <QtQuick>
#include "prototyper.h"
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QString>
#include <QStringList>
#include <QDebug>

#include <QScreen>
#include <QtCore/qmath.h>

#include "SyntaxHighlighter.h"

//region Для реализации вывода qDebug в файл использован сторонний код (источник - https://stacktuts.com/how-to-redirect-qdebug-qwarning-qcritical-etc-output-in-c )

void qdebugMessageOutputToFile(QtMsgType type, const QMessageLogContext& context, const QString& msg)
{
    QByteArray msgAry = msg.toLocal8Bit();

    QString msgTypeStr;
    switch (type) {
    case QtDebugMsg:
        msgTypeStr = QString("Debug");
        break;
    case QtInfoMsg:
        msgTypeStr = QString("Info");
        break;
    case QtWarningMsg:
        msgTypeStr = QString("Warning");
        break;
    case QtCriticalMsg:
        msgTypeStr = QString("Critical");
        break;
    case QtFatalMsg:
        msgTypeStr = QString("Fatal");
        break;
    }

    // Output string formatting
    QString dateTimeStr = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss.zzz");
    QString msgStr = QString("[%1][%2] [%3:%4:%5]:%6 \n").arg(dateTimeStr).arg(msgTypeStr)
                             .arg(context.file).arg(context.line).arg(context.function).arg(msgAry.constData());

    // Read and write files
    QFile file(QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation)+"/logqtdebug.txt");
    file.open(QIODevice::ReadWrite | QIODevice::Append);
    QTextStream stream(&file);
    stream << msgStr << "\r\n";
    file.flush();
    file.close();
}
//endregion

int main(int argc, char *argv[])
{
    qputenv("QML_DISABLE_DISK_CACHE", "true"); //запрет кеширования qml

    Prototyper::FILECOUNTERPREVIEW=0;

    //region Для реализации вывода qDebug в файл использован сторонний код (источник - https://stacktuts.com/how-to-redirect-qdebug-qwarning-qcritical-etc-output-in-c )

    qInstallMessageHandler(qdebugMessageOutputToFile); //эта штука перенаправляет qDebug в файл, содержимое которого будет отображаться в консоли в приложении

    //endregion

    qmlRegisterType<Prototyper>("ru.mastercond.QmlPrototyper", 1, 0, "Prototyper");

    QScopedPointer<QGuiApplication> application(Aurora::Application::application(argc, argv));
    application->setOrganizationName(QStringLiteral("ru.mastercond"));
    application->setApplicationName(QStringLiteral("QmlPrototyper"));

    QScopedPointer<QQuickView> view(Aurora::Application::createView());
    view->clearBeforeRendering();

    //СЕКЦИЯ ПОЛУЧЕНИЯ РАЗМЕРА ДИАГОНАЛИ ЭКРАНА УСТРОЙСТВА АВРОРА (после определения QGuiApplication)

    QScreen *screen=QGuiApplication::primaryScreen();
    qreal devicescreen_height=screen->physicalSize().rheight();
    qreal devicescreen_width=screen->physicalSize().rwidth();
    qreal screen_diagonal=qSqrt(devicescreen_height*devicescreen_height+devicescreen_width*devicescreen_width)/25.4; //размер диагонали экрана в дюймах

    qDebug() << "Физический размер экрана устройства: "+QString::number(screen_diagonal); //для R570E получилось 5.51097

    //КОНЕЦ СЕКЦИИ ПОЛУЧЕНИЯ РАЗМЕРА ДИАГОНАЛИ ЭКРАНА УСТРОЙСТВА АВРОРА

    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 1, "SyntaxHighlighter");


    if (screen_diagonal<7) {
    view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/QmlPrototyper.qml")));
    }
    else
    {
         view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/QmlPrototyper_tablet10.qml")));
    }

    view->show();
    return application->exec();
}

