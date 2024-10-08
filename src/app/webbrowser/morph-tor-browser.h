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

#ifndef __WEBBROWSER_APP_H__
#define __WEBBROWSER_APP_H__

#include "browserapplication.h"

class WebbrowserApp : public BrowserApplication
{
    Q_OBJECT

public:
    WebbrowserApp(int& argc, char** argv);

    bool initialize();

private:
    void printUsage() const final;
    static int run_tor(const char *dir);
    static void *thread_tor(void *argument);

private Q_SLOTS:
    void onNewInstanceLaunched(const QStringList& arguments) const final;
};

#endif // __WEBBROWSER_APP_H__
