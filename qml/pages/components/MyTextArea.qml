/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Andrew den Exter <andrew.den.exter@jollamobile.com>
** All rights reserved.
** 
** This file is part of Sailfish Silica UI component package.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
** 
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import SyntaxHighlighter 1.1

MyTextBase {
    id: textArea

    property alias text: textEdit.text
    property alias textWidth: textEdit.width
    property alias readOnly: textEdit.readOnly
    property alias inputMethodHints: textEdit.inputMethodHints
    property alias inputMethodComposing: textEdit.inputMethodComposing
    property alias cursorPosition: textEdit.cursorPosition
    property alias wrapMode: textEdit.wrapMode
    property alias verticalAlignment: textEdit.verticalAlignment
    property alias selectedText: textEdit.selectedText
    property alias selectionStart: textEdit.selectionStart
    property alias selectionEnd: textEdit.selectionEnd
    _editor: textEdit

    onReadOnlyChanged: _updateBackground()

    _flickableDirection: Flickable.VerticalFlick

    Column {
        id: lineNumbers
        spacing: isPortrait ? 1 : 0
        y: textEdit.y
        height: textEdit.height
        width: textEdit.font.pixelSize * 1.8
        z:textEdit.z + 1

        Repeater {
            model: textEdit.lineCount
            delegate: Text {
                horizontalAlignment: Text.AlignRight
                color: Theme.secondaryColor
                font.pixelSize: textEdit.font.pixelSize
                text: index + 1
            }
        }
    }

    TextEdit {
        id: textEdit
        objectName: "textEditor"

        property alias _preeditText: preeditText // for TextAutoScroller
        onHorizontalAlignmentChanged: textArea.setImplicitHorizontalAlignment(horizontalAlignment)

        x: -parent.contentX + lineNumbers.width
        y: -parent.contentY
        width: textArea.width - Theme.paddingSmall - textArea.textLeftMargin - textArea.textRightMargin
        focus: true
        activeFocusOnPress: false
        color: Theme.primaryColor//textArea.color
        selectionColor: Theme.highlightColor
        selectedTextColor: Theme.highlightText
        font: textArea.font
        cursorDelegate: Rectangle {
            color: textArea.cursorColor
            visible: parent.activeFocus && parent.selectedText == ""
            width: 2
        }
        wrapMode: TextEdit.Wrap

        // Note: need to disable if textFormat is ever allowed to be more than TextEdit.PlainText
        Text {
            id: preeditText
        }

        SyntaxHighlighter {
            id: syntaxHighlighter

            normalColor: Theme.primaryColor
            operatorColor: Theme.primaryColor
            numberColor: Theme.primaryColor
            commentColor: Theme.secondaryColor
            itemColor: Theme.highlightColor
            keywordColor: Theme.secondaryHighlightColor
            propertyColor: Theme.secondaryHighlightColor
            stringColor: Theme.errorColor
            //builtInColor:
            //markerColor:
        }

        Component.onCompleted: {
            syntaxHighlighter.setHighlighter(textEdit)
        }
    }
}
