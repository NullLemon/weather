#include "weather.h"

weatherInfo::weatherInfo(void)
{
    connect(&manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(onGetWeather(QNetworkReply*)));
}

void weatherInfo::fetchWeather(const QString &cityName)
{
    manager.get(QNetworkRequest(QUrl(QString("http://api.openweathermap.org/data/2.5/weather?q=%1&lang=zh_cn&APPID=b17da5e7262350abbce791732057902d").arg(cityName))));
}

void weatherInfo::startInquiry(const QString &cityName)
{
    this->fetchWeather(cityName);
}


void weatherInfo::onGetWeather(QNetworkReply *reply)
{
    QJsonObject data = QJsonDocument::fromJson(reply->readAll()).object();


    if(!data.contains("message"))
    {
        emit finished("OK", data);
    }
    else
    {
        qDebug("Get weather fail");
        emit finished("Get weather fail: " +
                      data.value("message").toString(), QJsonObject());
    }

}

