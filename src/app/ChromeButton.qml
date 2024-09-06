/*
 * Copyright 2014-2015 Canonical Ltd.
 *
 * This file is part of morph-tor-browser.
 *
 * morph-tor-browser is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * morph-tor-browser is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import Lomiri.Components 1.3

AbstractButton {
    property real iconSize: width
    property alias iconName: icon.name
    property alias iconColor: icon.color
    property bool enableContextMenu: false
    property var contextMenu: null
    property bool pressedState: false

    signal showContextMenu

    onShowContextMenu: pressedState = true

    Connections {
        target: contextMenu
        onVisibleChanged: if (!target.visible) pressedState = false
    }

    Rectangle {
        anchors.fill: parent
        color: theme.palette.selected.background
        visible: parent.pressed || pressedState
    }

    Icon {
        id: icon
        anchors.centerIn: parent
        width: parent.iconSize
        height: width
        asynchronous: true
    }

    opacity: enabled ? 1.0 : 0.3

    Behavior on width {
        LomiriNumberAnimation {}
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: if (enableContextMenu) showContextMenu()
    }

    onPressAndHold: if (enableContextMenu) showContextMenu()
}
