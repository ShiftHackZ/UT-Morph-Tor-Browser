/*
 * Copyright 2013-2016 Canonical Ltd.
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

ModalDialog {
    objectName: "alertDialog"
    title: i18n.tr("JavaScript Alert")

    signal accept()
    
    onAccept: hide()

    Button {
        text: i18n.tr("OK")
        color: theme.palette.normal.positive
        objectName: "okButton"
        onClicked: accept()
    }
}
