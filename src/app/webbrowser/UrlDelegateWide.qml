/*
 * Copyright 2015-2017 Canonical Ltd.
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
import ".."

ListItem {
    id: urlDelegate

    property alias icon: icon.source
    property alias title: title.text
    property alias url: url.text
    property bool removable: true

    divider.visible: false
    height: units.gu(5)

    signal removed()

    Favicon {
        id: icon
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: units.gu(1.5)
        }
    }

    Column {
        width: parent.width - icon.width - parent.spacing
        anchors {
            left: icon.right
            leftMargin: units.gu(1)
            verticalCenter: parent.verticalCenter
        }

        Label {
            id: title

            textSize: Label.Small
            color: theme.palette.normal.backgroundSecondaryText
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            maximumLineCount: 1
        }

        Label {
            id: url

            textSize: Label.XSmall
            color: theme.palette.normal.backgroundTertiaryText
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            maximumLineCount: 1
        }
    }

    property var _deleteAction: Action {
        objectName: "leadingAction.delete"
        iconName: "delete"
        onTriggered: urlDelegate.removed()
    }

    leadingActions: ListItemActions {
        actions: removable ? [_deleteAction] : []
    }
}
