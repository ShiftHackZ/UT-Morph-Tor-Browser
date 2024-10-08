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
import webbrowserapp.private 0.1
import ".." as Common
import "." as Local

Common.BrowserPage {
    id: historyView

    signal seeMoreEntriesClicked(var model)
    signal newTabRequested()

    title: domainsListView.ViewItems.selectMode ? "" : i18n.tr("History")

    showBackAction: !domainsListView.ViewItems.selectMode
    leadingActions: [closeAction]
    trailingActions: domainsListView.ViewItems.selectMode ? [selectAllAction, deleteAction] : [editAction]

    Timer {
        // Set the model asynchronously to ensure
        // the view is displayed as early as possible.
        id: loadModelTimer
        interval: 1
        onTriggered: historyDomainListModel.sourceModel = HistoryModel
    }

    function loadModel() { loadModelTimer.restart() }

    ListView {
        id: domainsListView
        objectName: "domainsListView"

        focus: true
        currentIndex: 0

        anchors.fill: parent

        model: HistoryDomainListModel {
            id: historyDomainListModel
        }

        section.property: "lastVisitDate"
        section.delegate: HistorySectionDelegate {
            width: parent.width - units.gu(2)
            anchors.left: parent.left
            anchors.leftMargin: units.gu(2)
        }

        delegate: UrlDelegate {
            id: urlDelegate
            objectName: "historyViewDomainDelegate"
            width: parent.width
            height: units.gu(5)

            readonly property int modelIndex: index

            title: model.domain
            url: lastVisitedTitle
            icon: model.lastVisitedIcon

            onClicked: {
                if (selectMode) {
                    selected = !selected
                } else {
                    historyView.seeMoreEntriesClicked(model.entries)
                }
            }
            onRemoved: HistoryModel.removeEntriesByDomain(model.domain)
            onPressAndHold: {
                selectMode = !selectMode
                if (selectMode) {
                    domainsListView.ViewItems.selectedIndices = [index]
                }
            }
        }

        Keys.onDeletePressed: currentItem.removed()
    }

    Action {
        id: closeAction
        objectName: "close"
        iconName: "close"
        onTriggered: domainsListView.ViewItems.selectMode = false
    }
    
    
    Action {
        id: editAction
        objectName: "edit"
        iconName: "edit"
        onTriggered: domainsListView.ViewItems.selectMode = true
    }

    Action {
        id: selectAllAction
        objectName: "selectAll"
        iconName: "select"
        onTriggered: {
            if (domainsListView.ViewItems.selectedIndices.length === domainsListView.count) {
                domainsListView.ViewItems.selectedIndices = []
            } else {
                var indices = []
                for (var i = 0; i < domainsListView.count; ++i) {
                    indices.push(i)
                }
                domainsListView.ViewItems.selectedIndices = indices
            }
        }
    }

    Action {
        id: deleteAction
        objectName: "delete"
        iconName: "delete"
        enabled: domainsListView.ViewItems.selectedIndices.length > 0
        onTriggered: {
            var indices = domainsListView.ViewItems.selectedIndices
            var domains = []
            for (var i in indices) {
                domains.push(domainsListView.model.get(indices[i]).domain)
            }
            domainsListView.ViewItems.selectMode = false
            for (var j in domains) {
                HistoryModel.removeEntriesByDomain(domains[j])
            }
        }
    }
}
