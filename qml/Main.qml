import VPlayApps 1.0
import QtQuick 2.0


App {

    id:app
    property var n: 0
    property var a
    property var w: 0
    //    Component { id: listsPageComponent; CityList{}}

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
//                var d = new Date();
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
    function getWeatherCode(c){
        var code = Number(c);
//        console.log("this is is is is  " + code)

        if(code === 100){
            return 1;
        }
        if(code >=101 && code <= 103){
            return 2;
        }
        if (code === 104){
            return 3;
        }
        if(code >= 300 && code <= 313){
            return 4;
        }
        if(code >= 400 && code <= 407){
            return 5;
        }else{
            return 6;
        }
    }

    MainPage{}

}
