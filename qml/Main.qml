import VPlayApps 1.0
import QtQuick 2.0
import QtQuick.Controls 2.1 as Q

App {

    id:app
    property var n: 0
    property var a : 0


    function getDate(n)
    {
        var d = new Date();
        var week;
        switch (d.getDay()){
        case 1: week="周一"; return 1;
        case 2: week="周二"; return 2;
        case 3: week="周三"; return 3;
        case 4: week="周四"; return 4;
        case 5: week="周五"; return 5;
        case 6: week="周六"; return 6;
        case 7: week="周天"; return 7;
        }
    }

    function getCurDate(n)
    {
        //        var d = new Date();
        var week;
        switch (n){
        case 1: week="周一"; return week;
        case 2: week="周二"; return week;
        case 3: week="周三"; return week;
        case 4: week="周四"; return week;
        case 5: week="周五"; return week;
        case 6: week="周六"; return week;
        case 7: week="周天"; return week;
        case 8: week="周一"; return week;
        case 9: week="周二"; return week;
        case 10: week="周三"; return week;
        case 11: week="周四"; return week;
        case 12:week="周五"; return week;
        case 13:week="周六"; return week;
        case 14:week="周天"; return week;
        }
    }

    Component.onCompleted: {
        WeatherInfo.startInquiry(search.text.toString());
    }

    //        contentWidth: width
    //        contentHeight: content.height


    Page{
        id:mainPage
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: tem < 20 ? "blue" : "lightblue"

                    Behavior on color { ColorAnimation { duration: 1500 } }
                }
                GradientStop {
                    position: 1
                    color: tem< 20 ? "#1D62F0" : "blue"
                    Behavior on color { ColorAnimation { duration: 1000 } }
                }
            }

        }

        Column {
            anchors.bottom:column.top
            //y: dp(20)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: dp(10)
            AppText {
                id: timeLabel
                color: "white"
                font.pixelSize: sp(14)
                anchors.horizontalCenter: parent.horizontalCenter

                Timer {
                    running: true
                    interval: 1000 * 30
                    triggeredOnStart: true
                    repeat: true
                    onTriggered: {
                        timeLabel.text = new Date().toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
                    }
                }
            }

            // Current time
        }

        AppFlickable {
            anchors.fill: parent
            anchors.centerIn: parent
            contentHeight: 1200

            SearchBar{
                id:search
                icon:IconType.search
                barBackgroundColor:"transparent"
                inputBackgroundColor: "transparent"
                placeHolderText: "请输入城市名"
                onAccepted:{
                    WeatherInfo.startInquiry(search.text.toString())
                }
            }

            AppImage{
                id:weatherIcon
                Connections{
                    target: WeatherInfo
                    onFinished:{
                        weatherIcon.source ="../assets/" + weatherData["HeWeather5"][0]["now"]["cond"]["code"] + ".png";
                    }
                }
                anchors.fill: parent.Center
                anchors.top: column.bottom
                anchors.margins: dp(10)
                y:dp(150)
                anchors.right: wordC.left
                width: dp(50)
                height: dp(50)
            }
            Connections{
                target: WeatherInfo;
                onFinished:{
                    if(message == "OK")
                    {
                        labelName.text =weatherData["HeWeather5"][0]["basic"]["city"];
                        tem.text =weatherData["HeWeather5"][0]["now"]["tmp"]+"℃";
                        dam.text ="湿度  "+weatherData["HeWeather5"][0]["now"]["hum"]

                    }
                }
            }

            Column{
                id:column
                y:dp(70)
                anchors.horizontalCenter: parent.horizontalCenter
                //            anchors.margins: dp(30)
                Text{
                    font.pixelSize: sp(30)
                    id:tem
                    text:"waiting..."
                    color: "white"
                }
                Row{
                    spacing: dp(10)
                    AppText {
                        font.pixelSize:sp(15)
                        id: labelName
                        text: qsTr("wait...")
                        color: "white"

                    }
                    AppText{
                        font.pixelSize:sp(15)
                        id:weather
                        text:"waiting..."
                        color: "white"
                        Connections{
                            target: WeatherInfo
                            onFinished:{
                                weather.text =weatherData["HeWeather5"][0]["now"]["cond"]["txt"];
                            }
                        }
                    }
                }
                AppText{
                    id:dam

                    color:"white"
                    font.pixelSize: sp(15)
                }
            }

            Column{
                id:wordC
                anchors.left: parent.horizontalCenter
                anchors.margins: dp(30)
                y:dp(58)
            }


            Component.onCompleted: {
                n = getDate(n);
            }


            Grid{
                id:bottomGrid
                rows: 7
                spacing: 2
                height: Math.min(parent.width - dp(150), dp(450))
                y:dp(300)
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater{
                    model: [
                        {day:"今天",i:0},
                        {day:getCurDate(n+1),i:1},
                        {day:getCurDate(n+2),i:2},
                        {day:getCurDate(n+2),i:2},
                        {day:getCurDate(n+2),i:2},
                        {day:getCurDate(n+2),i:2},
                        {day:getCurDate(n+2),i:2},
                    ]

                    Row{
                        //                    width:bottomGrid.width
                        spacing: dp(40)
                        height: bottomGrid.height/3
                        AppText {
                            text: modelData.day
                            font.pixelSize: sp(14)
                        }

                        AppImage{
                            id:gridImage
                            Connections{
                                target: WeatherInfo
                                onFinished:{
                                    var n = modelData.i
                                    gridImage.source ="../assets/" + weatherData["HeWeather5"][0]["daily_forecast"][n]["cond"]["code_d"] + ".png";
                                }
                            }
                            height: dp(30)
                            width: dp(30)
                        }

                        AppText{
                            id:gridText
                            Connections{
                                target: WeatherInfo
                                onFinished:{
                                    var n = modelData.i
                                    gridText.text = (weatherData["HeWeather5"][0]["daily_forecast"][n]["tmp"]["max"])+"℃" + "/" +(weatherData["HeWeather5"][0]["daily_forecast"][n]["tmp"]["min"])+"℃"
                                }
                            }
                            color: "lightblue"
                            font.pixelSize: sp(14)
                        }
                    }
                }
            }

            AppText{
                id:weatherText
                text: "3天天气预报"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom:bottomGrid.top
                anchors.margins: 5
                font.pixelSize: dp(12)
                x:Math.min(parent.width - dp(170), dp(450))
                color: "white"
            }

//            Column{

//            }
        }

    }
}

