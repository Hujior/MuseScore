/*
 * SPDX-License-Identifier: GPL-3.0-only
 * MuseScore-CLA-applies
 *
 * MuseScore
 * Music Composition & Notation
 *
 * Copyright (C) 2021 MuseScore BVBA and others
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
import QtQuick 2.15
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.15

import MuseScore.UiComponents 1.0
import MuseScore.Inspector 1.0

import "../../common"
import "internal"

TabPanel {
    id: root

    property QtObject model: null

    objectName: "LineSettings"

    implicitHeight: Math.max(styleTab.visible ? styleTab.implicitHeight : 0,
                             textTab.visible ? textTab.implicitHeight : 0) + tabBarHeight + 24
    width: parent ? parent.width : 0

    Component {
        id: hairpinStyleSettings

        HairpinStyleSettings {
            anchors.top: parent.top
            anchors.topMargin: 24

            width: root.width

            model: root.model
        }
    }

    Component {
        id: voltaStyleSettings

        VoltaStyleSettings {
            anchors.top: parent.top
            anchors.topMargin: 24

            width: root.width

            model: root.model
        }
    }

    Component {
        id: ottavaStyleSettings

        OttavaStyleSettings {
            anchors.top: parent.top
            anchors.topMargin: 24

            width: root.width

            model: root.model
        }
    }

    Component {
        id: commonStyleSettings

        LineWithHooksCommonStyleSettings {
            anchors.top: parent.top
            anchors.topMargin: 24

            width: root.width

            model: root.model
        }
    }

    Tab {
        id: styleTab

        title: qsTrc("inspector", "Style")

        sourceComponent: {
            var modelType = root.model ? root.model.modelType : -1

            switch(modelType) {
            case Inspector.TYPE_HAIRPIN: return hairpinStyleSettings
            case Inspector.TYPE_VOLTA: return voltaStyleSettings
            case Inspector.TYPE_OTTAVA: return ottavaStyleSettings
            }

            return commonStyleSettings
        }
    }

    Tab {
        id: textTab

        title: qsTrc("inspector", "Text")

        LineTextSettingsTab {
            anchors.top: parent.top
            anchors.topMargin: 24

            width: root.width

            model: root.model
        }
    }
}
