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

#include "browser-utils.h"

#include <QtWebEngineCore/QWebEngineCookieStore>
#include <QtWebEngine/QQuickWebEngineProfile>

BrowserUtils::BrowserUtils(QObject* parent) : QObject(parent)
{
}

void BrowserUtils::deleteAllCookiesOfProfile(QObject * profileObject) const
{
    QQuickWebEngineProfile * profile = qobject_cast<QQuickWebEngineProfile *>(profileObject);
    profile->cookieStore()->deleteAllCookies();
}
