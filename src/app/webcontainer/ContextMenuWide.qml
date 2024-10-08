/*
 * Copyright 2015-2016 Canonical Ltd.
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
import Lomiri.Components.ListItems 1.3 as ListItems
import Lomiri.Components.Popups 1.3 as Popups
import Morph.Web 0.1

Popups.Popover {
    id: contextMenu

    objectName: "contextMenuWide"

    property QtObject contextModel: model
    property ActionList actions: null
    property var associatedWebview: null

    QtObject {
        id: internal

        readonly property int lastEnabledActionIndex: {
            var last = -1
            for (var i in actions.children) {
                if (actions.children[i].enabled) {
                    last = i
                }
            }
            return last
        }

        readonly property real locationBarOffset: contextMenu.associatedWebview.locationBarController.height
                                                  + contextMenu.associatedWebview.locationBarController.offset
    }

    Rectangle {
        anchors.fill: parent
        color: theme.palette.normal.background
    }

    Column {
        anchors {
            left: parent.left
            right: parent.right
        }

        Label {
            id: titleLabel
            objectName: "titleLabel"
            text: contextModel.srcUrl.toString() ? contextModel.srcUrl : contextModel.linkUrl
            anchors {
                left: parent.left
                leftMargin: units.gu(2)
                right: parent.right
                rightMargin: units.gu(2)
            }
            height: units.gu(5)
            visible: text
            fontSize: "x-small"
            color: theme.palette.normal.base
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }

        ListItems.ThinDivider {
            anchors {
                left: parent.left
                leftMargin: units.gu(2)
                right: parent.right
                rightMargin: units.gu(2)
            }
            visible: titleLabel.visible
        }

        Repeater {
            model: actions.children
            delegate: ListItems.Empty {
                action: modelData
                objectName: action.objectName + "_item"
                visible: action.enabled
                showDivider: false

                height: units.gu(5)

                Label {
                    anchors {
                        left: parent.left
                        leftMargin: units.gu(2)
                        right: parent.right
                        rightMargin: units.gu(2)
                        verticalCenter: parent.verticalCenter
                    }
                    fontSize: "small"
                    text: action.text
                }

                ListItems.ThinDivider {
                    visible: index < internal.lastEnabledActionIndex
                    anchors {
                        left: parent.left
                        leftMargin: units.gu(2)
                        right: parent.right
                        rightMargin: units.gu(2)
                        bottom: parent.bottom
                    }
                }

                onTriggered: contextMenu.hide()
            }
        }
    }

    Item {
        id: positioner
        visible: false
        parent: contextMenu.associatedWebview
        x: contextModel.position.x
        y: contextModel.position.y + internal.locationBarOffset
    }
    caller: positioner

    onVisibleChanged: {
        if (!visible) {
            contextModel.close()
        }
    }

    // Override default implementation to prevent context menu from stealing
    // active focus when shown (https://launchpad.net/bugs/1526884).
    function show() {
        visible = true
        __foreground.show()
    }

    Binding {
        // Ensure the context menu doesn’t steal focus from
        // the webview when one of its actions is activated
        // (https://launchpad.net/bugs/1526884).
        target: __foreground
        property: "activeFocusOnPress"
        value: false
    }
}
