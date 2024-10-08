/*
 * Copyright 2020 UBports Foundation
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

import QtQuick 2.6
import QtGraphicalEffects 1.0
import Lomiri.Components 1.3

Item {
    id: iconWithColorOverlay
    property string overlayColor
    property string name

    Icon {
        id: icon
        name: iconWithColorOverlay.name
        width: iconWithColorOverlay.width
        height: iconWithColorOverlay.height
    }

    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: overlayColor
    }
    
}
