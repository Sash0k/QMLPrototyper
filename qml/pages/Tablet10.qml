import QtQuick 2.6
import Sailfish.Silica 1.0
import QtQuick.Window 2.2
import Sailfish.Pickers 1.0
import ru.mastercond.QmlPrototyper 1.0

import "components"

Page { 
id: mypage
allowedOrientations: Orientation.Landscape
backgroundColor: Theme.overlayBackgroundColor

property string selectedQMLFile

Prototyper {id: prototyper}

SilicaItem {
id: consolebox
visible:false
width: mypage.width*0.74
height: mypage.height*0.74
x: mypage.width*0.13
y: mypage.height*0.1
z: 1

Rectangle {
        x:-3
        y:-3
        width: consolebox.width+6
        height: consolebox.height+6
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
    font.pixelSize: Theme.fontSizeSmall
}
}
}


Rectangle {
id:rectangle1
width: mypage.width/7
height: mypage.height
gradient: Gradient {
        GradientStop { position: 0.0; color: "#EEEEEE" }
        GradientStop { position: 1.0; color: "#DDDDDD" }
}

Column {
id: column1
width: rectangle1.width
y: Theme.paddingLarge

Label {
id:label1
text:"<b>Команды</b>"
color: Theme.primaryColor
font.pixelSize: Theme.fontSizeMedium
width:rectangle1.width
wrapMode: Text.WordWrap
x: 2*Theme.paddingLarge
y: Theme.paddingLarge
scale: 0.93
z:2
}


SilicaFlickable {
id: flickableleft
clip: true
width: rectangle1.width
height: rectangle1.height
contentHeight: columnflickleft.height
y: label1.y+label1.height+Theme.paddingLarge
VerticalScrollDecorator {}

Column {
id:columnflickleft
width: parent.width

ComboBox {
label: "Файл"
width: parent.width
x: Theme.paddingLarge
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Открыть"
    onClicked: {
        codearea.visible=true
        textfilename.text="";
        textfilename.visible=false;
        textfilenameopen.visible=true;
        runbuttonopen.visible=true;
        runbutton.visible=false;
        pageStack.push(filePickerPage);
    }
}

MenuItem
{
    text: "Новый"
    onClicked:  {
        codearea.visible=true;
        textfilenameopen.text="";
        textfilename.visible=true;
        textfilenameopen.visible=false;
        runbuttonopen.visible=false;
        runbutton.visible=true;
        if (codearea.text!=="") { codearea.text=""; textfilename.text=""; textfilenameopen.text=""; }
        else {textfilename.text=""; textfilenameopen.text="";}
    }
}



}
}

    Component {
    id: filePickerPage
    FilePickerPage {
        allowedOrientations: Orientation.All
        backgroundColor: Theme.overlayBackgroundColor
        nameFilters: ['*.qml']
        onSelectedContentPropertiesChanged: {
                mypage.selectedQMLFile=selectedContentProperties.filePath;
                Notices.show("Загружен файл <b>"+selectedQMLFile+"</b>", Notice.Long);
                codearea.text=prototyper.loadQMLsourceFile(selectedQMLFile);
                textfilenameopen.text=selectedQMLFile;
        }
    }
    }

Label {
text: " "
height: 150
}

ButtonLayout {

Button {
id:buttonconsole
text:"Консоль"
x: Theme.paddingLarge
scale:0.9 
onClicked: {
    if (consolebox.visible==false) {consolebox.visible=true; consoleoutput.text=prototyper.qDebugOutputfromLogfile(); } else
    if (consolebox.visible==true) {consolebox.visible=false; consoleoutput.text=prototyper.qDebugOutputfromLogfile(); }
}
}

Button {
id:runbutton
text:"▶"
x: Theme.paddingLarge
scale:0.9
onClicked:
{
   prototyper.savePageQMLdefaultfolder(codearea.text,textfilename.text);
   runqmlPage();
}
}

Button {
id:runbuttonopen
visible: false
text:"▶"
x: Theme.paddingLarge
scale:0.9
onClicked:
{
    prototyper.savePageQML(codearea.text,textfilenameopen.text);
    runqmlPage();
}
}

}

}

}

}

}

Rectangle {
id:rectangle2
color: "#FFFFFE"
width: mypage.width-mypage.width/5-mypage.width/7
height: mypage.height
x: mypage.width/7

Column {
id:column2
width: rectangle2.width
y: Theme.paddingLarge 

Row {
id:row1
x: Theme.paddingLarge
y: Theme.paddingLarge

Label {
id:label2
text:"<b>Файл:</b>"
color: Theme.primaryColor
font.pixelSize: Theme.fontSizeMedium
wrapMode: Text.WordWrap
x: Theme.paddingLarge
scale:0.93
z: 2
}

TextField {
id: textfilename
placeholderText: "путь до файла"
width: rectangle2.width-label2.width-3*Theme.paddingLarge
x: label2.x+label2.width+Theme.paddingLarg
font.pixelSize: Theme.fontSizeSmall
y:-8
}


TextField {
id: textfilenameopen
visible: false
placeholderText: "путь до файла"
width: rectangle2.width-label2.width-3*Theme.paddingLarge
x: label2.x+label2.width+Theme.paddingLarg
font.pixelSize: Theme.fontSizeSmall
y:-8
}
}
}

MyTextArea {
id:codearea
visible: false
label: "QML код"
placeholderText: "QML код"
//color: Theme.primaryColor
font.pixelSize: Theme.fontSizeSmall
width:parent.width
height: rectangle2.height-row1.height-2*Theme.paddingLarge
wrapMode: Text.WordWrap
x: Theme.paddingLarge
y: label2.y+label2.height+Theme.paddingLarge
}

}


Rectangle {
id:rectangleup3
color: "#DDDDDD"
width: mypage.width
height: label56.height+1.5*Theme.paddingLarge 
z:1
opacity:0.3
}

Rectangle {
id:rectangle3
//color: "#DDDDDD"
width: mypage.width/5
height: mypage.height
x: mypage.width*4/5
gradient: Gradient {
        GradientStop { position: 0.0; color: "#EEEEEE" }
        GradientStop { position: 1.0; color: "#DDDDDD" }
}

Column {
id:column3
width: rectangle3.width
y: Theme.paddingLarge

Label {
id:label56
text:"<b>Добавить элемент</b>"
color: Theme.primaryColor
font.pixelSize: Theme.fontSizeMedium
width:parent.width
wrapMode: Text.WordWrap
x: Theme.paddingLarge
y: Theme.paddingLarge
scale: 0.93
z: 2
}

SilicaFlickable {
id: flickableright
clip: true
width: rectangle3.width-10
height: rectangle3.height
contentHeight: columnflickright.height+100
y: label1.y+label1.height+Theme.paddingLarge

VerticalScrollDecorator {}

Column {
id:columnflickright
width: flickableright.width 

ComboBox {
label: "Page"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Page Аврора 4"
    onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "import QtQuick 2.6\nimport Sailfish.Silica 1.0\n\nPage { \nid: mypage\nallowedOrientations: Orientation.All\nbackgroundColor: Theme.overlayBackgroundColor\n\nSilicaFlickable {\nid: flickable\nwidth:parent.width\n\nVerticalScrollDecorator {}\n\nColumn {\nid: column\nwidth: parent.width\n\nPageHeader {\ntitle: \"QML страница\"\n}\n\n//ваш код здесь\n\n}\n}\n}\n"); }
}

MenuItem {
    text: "Page Аврора 5"
    onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "import QtQuick 2.6\nimport Sailfish.Silica 1.0\nimport Aurora.Controls 1.0\n\nPage { \nid: mypage\nallowedOrientations: Orientation.All\nbackgroundColor: Theme.overlayBackgroundColor\n\nSilicaFlickable {\nid: flickable\nwidth:parent.width\n\nVerticalScrollDecorator {}\n\nColumn {\nid: column\nwidth: parent.width\n\nPageHeader {\ntitle: \"QML страница\"\n}\n\n//ваш код здесь\n\n}\n}\n}\n"); }
}

}
}


ComboBox {
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "SilicaFlickable"
    onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "SilicaFlickable {\nid: \nclip:true\nwidth:parent.width\nheight: \ncontentHeight:\n\n}\n\n"); }
}

MenuItem {
    text: "VerticalScrollDecorator"
    onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "VerticalScrollDecorator {}\n\n"); }
}

MenuItem {
    text: "clip: true"
    onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "clip:true\n\n");}
}

}
}


ComboBox {
label: "Разметка"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Column"
    onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Column {\nid: \n\n}\n\n"); }
}

MenuItem {
    text: "Row"
    onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Row {\nid: \n\n}\n\n"); }
}

MenuItem {
    text: "SilicaGridView"
    onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "SilicaGridView {\nid: \ncellWidth: \ncellHeight: \n}\n\n"); }
}

MenuItem {
    text: "GridItem"
    onClicked:  { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "GridItem {\n\n}\n\n"); }
}

}
}




ComboBox {
label: "Текст"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Label"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Label {\nid: \ntext:\"Какой-то текст\"\ncolor: Theme.primaryColor\nfont.pixelSize: Theme.fontSizeMedium\ntextFormat: Text.PlainText\nwidth:parent.width\nwrapMode: Text.WordWrap\n\n}\n\n"); }
}

MenuItem {
    text: "TextField"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "TextField {\nid: \nlabel: \"Под текстовым полем\"\nplaceholderText: \"Текст-заполнитель\"\n\n}\n"); }
}

MenuItem {
    text: "TextArea"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "TextArea {\nid: \nlabel: \"Под текстовым полем\"\nplaceholderText: \"Текст-заполнитель\"\n\n}\n"); }
}

}
}



ComboBox {
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Combobox"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "ComboBox {\nwidth: parent.width\nlabel: \"Пример Combobox\"\n\nmenu: ContextMenu {\nMenuItem { text: \"вариант 1\" }\nMenuItem { text: \"вариант 2\" }\nMenuItem { text: \"вариант 3\" }\n}\n}\n\n"); }
}
MenuItem {
    text: "MenuItem"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "MenuItem { text: \"вариант\" }\n\n"); }
}

}
}


ComboBox {
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem { text: "ListView"}
MenuItem { text: "Пример ListView"}

}
}


ComboBox {
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Rectangle"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Rectangle {\nid:\ncolor: Theme.secondaryColor\n\n}\n\n"); }
}

MenuItem {
    text: "Пример Rectangle"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Rectangle {\nid:rectangle1\ncolor: Theme.secondaryColor\n\n}\n\n"); }
}

}
}


ComboBox {
label: "Кнопки"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Button"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Button {\nid:\ntext:\"Button\"\nonClicked: \n\n}\n\n"); }
}
MenuItem {
    text: "ButtonLayout"
    onClicked:{ codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "ButtonLayout {\n\nButton {\ntext: \"Button1\"\n}\n\nButton {\ntext: \"Button2\"\n}\n\nButton {\ntext: \"Button3\"\n}\n}\n\n");}
}

MenuItem {
    text: "ValueButton"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "ValueButton {\nlabel: \"Date\"\nvalue: \"Select\"\nonClicked: {\n\nvar dialog = pageStack.push(\"Sailfish.Silica.DatePickerDialog\")\ndialog.accepted.connect(function() {\nvalue = dialog.dateText\n})\n}\n}\n\n"); }
}

MenuItem {
    text: "IconButton"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "IconButton {\nicon.source: \"имя_файла.png\"\nonClicked: console.log(\"Нажатие на IconButton\")\n\n}\n\n"); }
}

MenuItem {
    text: "TextSwitch"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "TextSwitch {\nid: \ntext: \"Радиокнопка\"\nonCheckedChanged: \n\n}\n\n"); }
}

}
}

ComboBox {
label: "Anchors"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

    MenuItem {
        text: "anchors.fill"
        onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.fill: \n"); }
    }

MenuItem {
    text: "anchors.top"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.top: \n"); }
}

MenuItem {
    text: "anchors.bottom"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.bottom: \n"); }
 }

MenuItem {
    text: "anchors.left"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.left: \n"); }
}

MenuItem {
    text: "anchors.right"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.right: \n"); }
}

MenuItem {
    text: "anchors.margins"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.margins: \n"); }
}

MenuItem {
    text: "anchors.topMargin"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.topMargin: \n"); }
}

MenuItem {
    text: "anchors.bottomMargin"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.bottomMargin: \n"); }
}

MenuItem {
    text: "anchors.rightMargin"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.rightMargin: \n"); }
}

MenuItem {
    text: "anchors.leftMargin"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "anchors.leftMargin: \n"); }
}



}
}

ComboBox {
label: "Шрифт"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Маленький"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "font.pixelSize: Theme.fontSizeSmall \n"); }
}

MenuItem {
    text: "Средний"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "font.pixelSize: Theme.fontSizeMedium \n"); }
}

MenuItem {
    text: "Большой"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "font.pixelSize: Theme.fontSizeLarge \n"); }
}

}
}

ComboBox {
label: "Медиа"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Изображение"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Image {\nsource:\"   \"\n}\n\n"); }
}

MenuItem {
    text: "Видео"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "//не забудьте import QtMultimedia 5.6\nVideo {\nsource:\"   \"\n}\n\n"); }
}

MenuItem {
    text: "HighlightImage"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "HighlightImage {\nsource:\"   \"\ncolor:\nhighlightColor: \nhighlighted: \n}\n\n"); }
}

}
}

ComboBox {
label: "Уведомления"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "Notices"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Notices.show(\"Текст уведомления\", Notice.Long);\n\n"); }
}


MenuItem {
    text: "Notices с положением на экране и временем показа"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Notices.show(\"Текст уведомления\", Notice.Long, Notice.Top);\n\n"); }
}

}
}


ComboBox {
label: "Экран"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem { text: "Ориентация проверка"}


}
}

ComboBox {
label: "Импорты"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "QtQuick.Window 2.0"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "import QtQuick.Window 2.0\n\n"); }
}

MenuItem {
    text: "QtMultimedia 5.6"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "import QtMultimedia 5.6\n\n"); }
}

MenuItem {
    text: "Aurora.Controls 1.0 (Аврора 5)"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "import Aurora.Controls 1.0\n\n"); }
}

MenuItem {
    text: "Sailfish.Pickers 1.0"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "import Sailfish.Pickers 1.0\n\n"); }
}


}
}

/*
ComboBox {
label: "Connections"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem { text: "Connections"}


}
}
*/

ComboBox {
label: "Pickers"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "FilePicker - выбор 1 файла с заданным разрешением (.txt в данном примере)"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "\n//Page id - mypage\n//не забудьте import Sailfish.Pickers 1.0\n//поместите property string selectedMyFile в компонент Page \n\nproperty string selectedMyFile\n\nComponent {\nid: filePickerPage\n\nFilePickerPage {\nallowedOrientations: Orientation.All\nbackgroundColor: Theme.overlayBackgroundColor\nnameFilters: ['*.txt']\nonSelectedContentPropertiesChanged: {\nmypage.selectedMyFile=selectedContentProperties.filePath;\nNotices.show(\"Выбран файл <b>\"+selectedMyFile+\"</b>\", Notice.Long);\n}\n}\n}\n\nButton {\ntext:\"Выбрать файл\"\nonClicked: pageStack.push(filePickerPage)\n}\n\n"); }
}

/*MenuItem {
    text: "ImageFilePicker"
    }
*/

}
}

ComboBox {
label: "Обработчики"
width: parent.width
anchors.topMargin: Theme.paddingLarge
scale: 0.9

menu: ContextMenu {

MenuItem {
    text: "onClicked"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "onClicked: "); }
}

MenuItem {
    text: "Component.onCompleted"
    onClicked: { codearea.text=prototyper.addTextTextAreaCursorPosition(codearea.cursorPosition, codearea.text, "Component.onCompleted: "); }
}


}
}

Text {
anchors.topMargin: Theme.paddingLarge
text:" "
height:130
scale: 0.9
}



}
}
} 
}

Button {
id:buttonhelp
text:"Справка"
x: Theme.paddingLarge
y: mypage.height-buttonhelp.height-Theme.paddingLarge
scale:0.9

}


function runqmlPage()
    {
         pageStack.push(Qt.resolvedUrl(prototyper.pathAppLocalFolder()+"/cache/page_preview_"+prototyper.returnFileCounter()+".qml"));
    }

    function runqmlComponent()
    {
         pageStack.push(Qt.resolvedUrl(prototyper.pathAppLocalFolder()+"/cache/component_preview_"+prototyper.returnFileCounter()+".qml"));
    }

    Component.onCompleted: prototyper.createWorkFiles()

}
