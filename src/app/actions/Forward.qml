/*
 * Copyright 2013-2015 Canonical Ltd.
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

import Lomiri.Components 1.3
import Lomiri.Action 1.1 as LomiriActions

LomiriActions.Action {
    text: i18n.tr("Forward")
    // TRANSLATORS: This is a free-form list of keywords associated to the 'Forward' action.
    // Keywords may actually be sentences, and must be separated by semi-colons.
    keywords: i18n.tr("Newer Page")
}
