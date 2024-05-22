/*******************************************************************************
**
** Copyright (C) 2024 ru.mastercond
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

import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Pickers 1.0
import ru.mastercond.QmlPrototyper 1.0

import "components"

Page {
    id:pagepage
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    backgroundColor: Theme.overlayBackgroundColor


    property string selectedQMLFile

    Prototyper {id: prototyper}




    SilicaItem {
    id: consolebox
    visible:false
    width: pagepage.width*0.74
    height: pagepage.height*0.74
    x: pagepage.width*0.13
    y: pagepage.height*0.1
    z: 1

    Rectangle {
            x:-3
            y:-3
            width: addcodebox.width+6
            height: addcodebox.height+6
            color: "#999999"
            opacity: 1
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "#BBBBBB"
        opacity: 1

    Label {
    id: consolelabel
    x: Theme.paddingLarge
    y: Theme.paddingLarge
    text: "<b>Вывод консоли:</b>"
    color: "#222222"
    }

    TextArea
    {
        readOnly: true
        id:consoleoutput
        width: consolebox.width-2*Theme.paddingMedium
        height: consolebox.height-consolelabel.height-2*Theme.paddingLarge
        y: consolelabel.height+Theme.paddingLarge
        x: Theme.paddingMedium
        wrapMode: TextEdit.WordWrap
        color: "#222222"
        clip: true
        //font.pixelSize: Theme.fontSizeSmall
    }
    }
    }

    SilicaItem {
    id: addcodebox
    visible:false
    width: pagepage.width*0.74
    height: pagepage.height*0.74
    x: pagepage.width*0.13
    y: pagepage.height*0.1
    z: 2

    Rectangle {
            x:-3
            y:-3
            width: addcodebox.width+6
            height: addcodebox.height+6
            color: "#999999"
            opacity: 1
    }

    Rectangle {
        width: addcodebox.width
        height: addcodebox.height
        color: "#BBBBBB"
        opacity: 1

     Column {
         width: addcodebox.width
         height: addcodebox.height
         y:Theme.paddingLarge

    Label {
    id: addcodecaptionLabel
    x: Theme.paddingLarge
    y: Theme.paddingLarge
    text: "<b>Вставить пример кода</b>"
    color: "#222222"
    }

    ComboBox {
        id: comboboxaddcodedialog
        label: "Добавить код Аврора 4:"
        anchors.topMargin: Theme.paddingLarge
        labelColor:  "#222222"
        valueColor: "#222222"
        menu: ContextMenu {

            MenuItem {
                text: "Page - шаблон страницы"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "import QtQuick 2.6\nimport Sailfish.Silica 1.0\n\nPage { \nid: mypage\nallowedOrientations: Orientation.All\nbackgroundColor: Theme.overlayBackgroundColor\n\nSilicaFlickable {\nid: flickable\nwidth:parent.width\n\nVerticalScrollDecorator {}\n\nColumn {\nid: column\nwidth: parent.width\n\nPageHeader {\ntitle: \"QML страница\"\n}\n\n//ваш код здесь\n\n}\n}\n}\n"); addcodebox.visible=false;}
            }

            MenuItem {
                text: "Column - элементы по вертикали"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Column {\nid:column1\n\n}\n\n"); addcodebox.visible=false;}
            }

            MenuItem {
                text: "Row - элементы в ряд"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Row {\nid:row1\n\n}\n\n"); addcodebox.visible=false;}
            }

            MenuItem {
                text: "Button - кнопка"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Button {\nid:button1\ntext:\"Button 1\"\n\n\n}\n\n"); addcodebox.visible=false;}
            }

            MenuItem {
                text: "Label - текстовая метка"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Label {\nid:label1\ntext:\"Какой-то текст\"\ncolor: Theme.primaryColor\nfont.pixelSize: Theme.fontSizeMedium\ntextFormat: Text.PlainText\nwidth:parent.width\nwrapMode: Text.WordWrap\n\n}\n\n"); addcodebox.visible=false;}
            }

            MenuItem {
                text: "TextSwitch - радиокнопка"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "TextSwitch {\nid: textSwitch1\ntext: \"Радиокнопка\"\n\n}\n\n"); addcodebox.visible=false; }
            }


            MenuItem {
                text: "TextArea - многострочное поле ввода"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "TextArea {\nid:textarea1\nlabel: \"Под текстовым полем\"\nplaceholderText: \"Текст-заполнитель\"\n\n}\n"); addcodebox.visible=false; }
            }

            MenuItem {
                text: "TextField - однострочное поле ввода"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "TextField {\nid:textfield1\nlabel: \"Под текстовым полем\"\nplaceholderText: \"Текст-заполнитель\"\n\n}\n"); addcodebox.visible=false; }
                }

            MenuItem {
                text: "Rectangle - прямоугольник"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Rectangle {\nid:rectangle1\ncolor: Theme.secondaryColor\n\n}\n\n"); addcodebox.visible=false; }
            }

            MenuItem {
                text: "Combobox - выбора варианта из выпадающего списка"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "ComboBox {\nwidth: parent.width\nlabel: \"Пример Combobox\"\n\nmenu: ContextMenu {\nMenuItem { text: \"вариант 1\" }\nMenuItem { text: \"вариант 2\" }\nMenuItem { text: \"вариант 3\" }\n}\n}\n\n"); addcodebox.visible=false; }
            }


            MenuItem {
                text: "IconButton - графическая кнока"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "IconButton {\nicon.source: \"имя_файла.png\"\nonClicked: console.log(\"Нажатие на IconButton\")\n\n}\n\n"); addcodebox.visible=false; }
            }

            MenuItem {
                text: "ButtonLayout - компонент для нескольких кнопок"
                onClicked:{ codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "ButtonLayout {\n\nButton {\ntext: \"Button1\"\n}\n\nButton {\ntext: \"Button2\"\n}\n\nButton {\ntext: \"Button3\"\n}\n}\n\n"); addcodebox.visible=false; }
            }


            MenuItem {
                text: "ValueButton - кнопка с выбором значения"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "ValueButton {\nlabel: \"Date\"\nvalue: \"Select\"\nonClicked: {\n\nvar dialog = pageStack.push(\"Sailfish.Silica.DatePickerDialog\")\ndialog.accepted.connect(function() {\nvalue = dialog.dateText\n})\n}\n}\n\n"); addcodebox.visible=false; }
            }

           /* MenuItem {
                text:   "Dialog - диалог"
                onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Dialog {\n\nproperty string name\n\nColumn {\nwidth: parent.width\n\nDialogHeader { }\n\nTextField {\nid: nameField\nwidth: parent.width\nplaceholderText: \"Как вас зовут?\"\nlabel: \"Имя\"\n}\n}\n\nonDone: {\nif (result == DialogResult.Accepted) {\nname = nameField.text\n}\n}\n}\n"); addcodebox.visible=false; }
        }*/
    }   
    }

    ComboBox {
        id: comboboxaddcodedialog5
        label: "Добавить код Аврора 5:"
        anchors.topMargin: Theme.paddingLarge
        labelColor:  "#222222"
        valueColor: "#222222"
        opacity: 1
        y: 10
        menu: ContextMenu {

            MenuItem {
                text: "Page - шаблон страницы"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "import QtQuick 2.6\nimport Sailfish.Silica 1.0\nimport Aurora.Controls 1.0\n\nPage { \nid: mypage\nallowedOrientations: Orientation.All\nbackgroundColor: Theme.overlayBackgroundColor\n\nSilicaFlickable {\nid: flickable\nwidth:parent.width\n\nVerticalScrollDecorator {}\n\nColumn {\nid: column\nwidth: parent.width\n\nPageHeader {\ntitle: \"QML страница\"\n}\n\n//ваш код здесь\n\n}\n}\n}\n"); addcodebox.visible=false;}
            }
        }
    }

    ComboBox {
        id: comboboxworkpages
        label: "Примеры страниц:"
        anchors.topMargin: Theme.paddingLarge
        labelColor:  "#222222"
        valueColor: "#222222"
        opacity: 1
        y: 10
        menu: ContextMenu {

            MenuItem {
                text: "Страница организации"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, ""); addcodebox.visible=false;}
            }

            MenuItem {
                text: "Страница со списком контрагентов"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, ""); addcodebox.visible=false;}
            }

            MenuItem {
                text: "Страница с палитрой цветов"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, ""); addcodebox.visible=false;}
            }

            MenuItem {
                text: "Страница с QPainter"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, ""); addcodebox.visible=false;}
            }

            MenuItem {
                text: "Страница организации"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, ""); addcodebox.visible=false;}
            }

            MenuItem {
                text: "Страница организации"
                onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, ""); addcodebox.visible=false;}
            }
        }
    }

    }
    }
    }

    SilicaFlickable {
                id: flickable
                contentHeight: column.height + Theme.paddingLarge
                anchors.margins: 20
                width: parent.width
                height: parent.height
                z:0

                VerticalScrollDecorator {}

                Button {
                id: rightButton
                text:"⟪"
                y: flickable.height/3
                x: flickable.width-rightButton.width+1
                width:38
                onClicked: {
                    if (consolebox.visible==false) {consolebox.visible=true; addcodebox.visible=false; rightButton.text="⟫"; consoleoutput.text=prototyper.qDebugOutputfromLogfile(); } else
                    if (consolebox.visible==true) {consolebox.visible=false; addcodebox.visible=false; rightButton.text="⟪"; consoleoutput.text=prototyper.qDebugOutputfromLogfile(); }
                }
                }


                Button {
                id: addsamplecodeButton
                text:"+"
                y: flickable.height/3+flickable.height/5
                x: flickable.width-rightButton.width+1
                width:38
                anchors.topMargin: 20

                onClicked: {
                                    if (addcodebox.visible==false) {addcodebox.visible=true; consolebox.visible=false; rightButton.text="⟪"; } else
                                    if (addcodebox.visible==true) {addcodebox.visible=false; consolebox.visible=false; rightButton.text="⟪"; }
                                }
                }


    Column {
        id: column
        width: parent.width-2*Theme.paddingLarge
        x:Theme.paddingLarge


            PullDownMenu {
                id: pulldownmenuinapp

                             MenuItem {
                                text: qsTr("Редактор QML страниц")
                                onClicked: pageStack.push(Qt.resolvedUrl("QMLEditPage.qml"))
                             }

                             MenuItem {
                                text: qsTr("Редактор QML компонентов")
                                onClicked: pageStack.push(Qt.resolvedUrl("QMLEditComponents.qml"))
                             }

                            // MenuItem {
                           //     text: qsTr("Настройки")
                           //     onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
                           //}

                             MenuItem {
                                text: qsTr("О приложении")
                                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                             }



            }



            PageHeader {
                        id: pageheaderCaption
                        title: "Редактор QML страниц"
                    }

            ComboBox {
                id:fileComboBox
                label: "Действия с файлом"
                menu: ContextMenu {

                    MenuItem {
                        text: "Открыть"
                        onClicked:  {
                            textfilename.text="";
                            rowfileopenadd.visible=false;
                            textfilenameopen.visible=true;
                            runbuttonopen.visible=true;
                            runbutton.visible=false;
                            pageStack.push(filePickerPage);
                        }
                    }

                    MenuItem {
                        text: "Новый"
                        onClicked:
                        {
                            textfilenameopen.text="";
                            textfilenameopen.visible=false;
                            rowfileopenadd.visible=true;
                            buttonloadsource.visible=false;
                            runbuttonopen.visible=false;
                            runbutton.visible=true;
                            if (codearea.text!=="") { codearea.text=""; textfilename.text=""; textfilenameopen.text=""; }
                            else {textfilename.text=""; textfilenameopen.text="";}
                         }
                    }

                  /*  MenuItem {
                        text: qsTrId("Последние файлы")
                    } */

                }
            }

           //Button {
           //id: open_qml_file
          //text:"Открыть"
          //width:35
         //onClicked: pageStack.push(filePickerPage)
         //   }

            Component {
            id: filePickerPage
            FilePickerPage {
                allowedOrientations: Orientation.All
                backgroundColor: Theme.overlayBackgroundColor
                nameFilters: ['*.qml']
                onSelectedContentPropertiesChanged: {
                        pagepage.selectedQMLFile=selectedContentProperties.filePath;
                        Notices.show("Загружен файл <b>"+selectedQMLFile+"</b>", Notice.Long);
                        codearea.text=prototyper.loadQMLsourceFile(selectedQMLFile);
                        textfilenameopen.text=selectedQMLFile;
                }
            }
            }



            TextField  {
                id: textfilenameopen
                width: parent.width-40
                focus: true
                placeholderText: "например, page.qml (будет в папке Documents/QML прототипы/)."
                visible: false
            }

            Row {
                id: rowfileopenadd
                width:parent.width
                visible: false

            TextField  {
                id: textfilename
                width: parent.width-40
                focus: true
                placeholderText: "например, page.qml (файл из папки Documents/QML прототипы/)."
            }

            Button {
            id:buttonloadsource
            text: "📂"
            width:110
            x: textfilename.width+25
            onClicked: codearea.text=prototyper.loadQMLsourceFile(prototyper.pathDocuments()+"/QML прототипы/"+textfilename.text)
            }
          }


            MyTextArea {
                 id: codearea
                 width: parent.width
                 height: flickable.height/3*2
                 textTopMargin: Theme.horizontalPageMargin
                 focus: true
                 clip: true
                 label: "QML-код"
                 placeholderText: "Код QML-страницы\n\nНажмите на \"+\" и сначала добавьте код Page" //текст, который пропадет при начале ввода текста
                 wrapMode: Text.WordWrap
             }

    ComboBox {
        id: fontsizeComboBox
        label: "Шрифт:"
        anchors.topMargin: 10
        //labelColor:  "#222222"
        //valueColor: "#222222"
        menu: ContextMenu {


            MenuItem {
                text: "Нормальный"
                onClicked:  {
                    pageheaderCaption.scale=1
                    consolelabel.font.pixelSize=Theme.fontSizeMedium;
                    codearea.font.pixelSize=Theme.fontSizeMedium;
                    consoleoutput.font.pixelSize=Theme.fontSizeMedium;
                    textfilenameopen.font.pixelSize=Theme.fontSizeMedium;
                    textfilename.font.pixelSize=Theme.fontSizeMedium;
                    addcodecaptionLabel.font.pixelSize=Theme.fontSizeMedium;
                    fontsizeComboBox.scale=1
                    fileComboBox.scale=1
                    comboboxaddcodedialog.scale=1
                    comboboxaddcodedialog5.scale=1
                    comboboxworkpages.scale=1
                    pulldownmenuinapp.scale=1
                }
            }

            MenuItem {
                text: "Мелкий"
                onClicked:  {
                    pageheaderCaption.scale=0.93
                    consolelabel.font.pixelSize=Theme.fontSizeSmall;
                    codearea.font.pixelSize=Theme.fontSizeSmall;
                    consoleoutput.font.pixelSize=Theme.fontSizeSmall;
                    textfilenameopen.font.pixelSize=Theme.fontSizeSmall;
                    textfilename.font.pixelSize=Theme.fontSizeSmall;
                    addcodecaptionLabel.font.pixelSize=Theme.fontSizeSmall;
                    fontsizeComboBox.scale=0.95
                    fileComboBox.scale=0.95
                    comboboxaddcodedialog.scale=0.95
                    comboboxaddcodedialog5.scale=0.95
                    comboboxworkpages.scale=0.95
                    pulldownmenuinapp.scale=0.97
                }
            }

        }
        }



    Button {
        id: runbutton
        text: "▶"
        x: Theme.paddingLarge
        onClicked:
        {
            prototyper.savePageQMLdefaultfolder(codearea.text,textfilename.text);
           runqmlPage();
        }
    }

    Button {
        id: runbuttonopen
        text: "▶"
        x: Theme.paddingLarge
        visible: false
        onClicked:
        {
           prototyper.savePageQML(codearea.text,textfilenameopen.text);
           runqmlPage();
        }
    }





        }
    Component.onCompleted: prototyper.createWorkFiles()
    }



    function runqmlPage()
        {
             pageStack.push(Qt.resolvedUrl(prototyper.pathAppLocalFolder()+"/cache/page_preview_"+prototyper.returnFileCounter()+".qml"));
        }

        function runqmlComponent()
        {
             pageStack.push(Qt.resolvedUrl(prototyper.pathAppLocalFolder()+"/cache/component_preview_"+prototyper.returnFileCounter()+".qml"));
        }





}
