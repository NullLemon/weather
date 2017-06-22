#include "weather.h"

weatherInfo::weatherInfo(void)
{
    connect(&manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(onGetWeather(QNetworkReply*)));
}

void weatherInfo::fetchWeather(const QString &cityName)
{
    //Actually, we can set cnt number to show how many citys wo want to get, but it shoud not go beyond 16.
    manager.get(QNetworkRequest(QUrl(QString("http://api.openweathermap.org/data/2.5/forecast?q=%1&lang=zh_cn&cnt=5&APPID=b17da5e7262350abbce791732057902d").arg(cityName))));
}

void weatherInfo::startInquiry(const QString &cityName)
{
    this->fetchWeather(cityName);
}


void weatherInfo::onGetWeather(QNetworkReply *reply)
{
    QJsonObject data = QJsonDocument::fromJson(reply->readAll()).object();

    //we just use the value that can't directly read from json, but it should exist.
    if(!data.contains("name"))
    {
        emit finished("OK", data);
    }
    else
    {
        qDebug("Get weather fail");
        emit finished("Get weather fail: " +
                      data.value("name").toString(), QJsonObject());
    }

}

