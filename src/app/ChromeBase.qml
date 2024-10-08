/*
 * Copyright 2014-2016 Canonical Ltd.
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

// use styled item otherwise Drawer button will steal focus from the AddressBar
StyledItem {
    id: chrome

    readonly property real visibleHeight: y + height
    readonly property bool moving: (y < 0) && (y > -height)

    objectName: "chromeBase"

    property alias backgroundColor: backgroundRect.color

    property bool loading: false
    property real loadProgress: 0.0

    states: [
        State {
            name: "shown"
        },
        State {
            name: "hidden"
        }
    ]

    state: "shown"

    y: (state == "shown") ? 0 : -height
    Behavior on y {
        SmoothedAnimation {
            duration: LomiriAnimation.BriskDuration
        }
    }

    Rectangle {
        id: backgroundRect

        anchors.fill: parent
        color: theme.palette.normal.background

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: units.dp(1)
            color: theme.palette.normal.base
        }
    }

    ThinProgressBar {
        id: progressBar

        visible: chrome.loading
        value: chrome.loadProgress

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        objectName: "chromeProgressBar"

        z: 2
    }
}
