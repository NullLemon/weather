import QtQuick 2.0
import VPlayApps 1.0

NavigationStack{
    id:stac
    ListPage {
        id: page

        title: qsTr("City")
        leftBarItem:IconButtonBarItem{
            icon: IconType.close
            onClicked: {var object=Qt.createComponent("MainPage.qml").createObject(app)
                WeatherInfo.startInquiry(a)
            }
        }

        rightBarItem: IconButtonBarItem {
            icon: IconType.plus

            onClicked: {
                InputDialog.inputTextMultiLine(page,qsTr("New city"), qsTr("Enter text..."),
                                               function(ok, text) {
                                                   page.model.push({ text:text })
                                                   page.modelChanged()
                                                   var db = openDatabaseSync(text)
                                               })


            }
        }


        model: []

        delegate: SwipeOptionsContainer {
            id: container

            rightOption: AppButton {
                text: qsTr("Delete")
                onClicked: {
                    container.hideOptions()
                    page.model.splice(index, 1)
                    page.modelChanged()
                }
            }

            SimpleRow {
                onSelected: {
                    var object=Qt.createComponent("MainPage.qml").createObject(app);
                    WeatherInfo.startInquiry(page.model[index].text)
                }
            }
        }
    }
}


