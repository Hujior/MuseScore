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
import QtQuick.Controls 2.15

import MuseScore.Ui 1.0
import MuseScore.UiComponents 1.0

BaseSection {
    id: root

    title: qsTrc("appshell", "Auto save")

    navigation.direction: NavigationPanel.Horizontal

    property alias isAutoSave: autoSaveCheckBox.checked
    property alias autoSavePeriod: autoSavePeriodControl.currentValue

    signal autoSaveChanged(bool autoSave)
    signal periodChanged(int period)

    Row {
        spacing: 0

        CheckBox {
            id: autoSaveCheckBox

            width: root.columnWidth
            anchors.verticalCenter: parent.verticalCenter

            text: qsTrc("appshell", "Auto save every:")

            navigation.name: "AutoSaveCheckBox"
            navigation.panel: root.navigation
            navigation.column: 1

            onClicked: {
                root.autoSaveChanged(!checked)
            }
        }

        IncrementalPropertyControl {
            id: autoSavePeriodControl

            width: 96
            anchors.verticalCenter: parent.verticalCenter

            enabled: root.isAutoSave

            minValue: 1
            maxValue: 100
            step: 1
            decimals: 0

            measureUnitsSymbol: qsTrc("appshell", "min")

            navigation.name: "AutoSavePeriodControl"
            navigation.panel: root.navigation
            navigation.column: 2

            onValueEdited: {
                root.periodChanged(newValue)
            }
        }
    }
}
