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
import MuseScore.Inspector 1.0
import "../../common"
import "../notes/internal"

Column {
    id: root

    property QtObject model: null

    objectName: "AmbitusSettings"

    spacing: 12

    readonly property var tpcListModel: [
        { text: "C♭♭", value: AmbitusTypes.TPC_C_BB },
        { text: "C♭", value: AmbitusTypes.TPC_C_B },
        { text: "C", value: AmbitusTypes.TPC_C },
        { text: "C♯", value: AmbitusTypes.TPC_C_S },
        { text: "C♯♯", value: AmbitusTypes.TPC_C_SS },
        { text: "D♭♭", value: AmbitusTypes.TPC_D_BB },
        { text: "D♭", value: AmbitusTypes.TPC_D_B },
        { text: "D", value: AmbitusTypes.TPC_D },
        { text: "D♯", value: AmbitusTypes.TPC_D_S },
        { text: "D♯♯", value: AmbitusTypes.TPC_D_SS },
        { text: "E♭♭", value: AmbitusTypes.TPC_E_BB },
        { text: "E♭", value: AmbitusTypes.TPC_E_B },
        { text: "E", value: AmbitusTypes.TPC_E },
        { text: "E♯", value: AmbitusTypes.TPC_E_S },
        { text: "E♯♯", value: AmbitusTypes.TPC_E_SS },
        { text: "F♭♭", value: AmbitusTypes.TPC_F_BB },
        { text: "F♭", value: AmbitusTypes.TPC_F_B },
        { text: "F", value: AmbitusTypes.TPC_F },
        { text: "F♯", value: AmbitusTypes.TPC_F_S },
        { text: "F♯♯", value: AmbitusTypes.TPC_F_SS },
        { text: "G♭♭", value: AmbitusTypes.TPC_G_BB },
        { text: "G♭", value: AmbitusTypes.TPC_G_B },
        { text: "G", value: AmbitusTypes.TPC_G },
        { text: "G♯", value: AmbitusTypes.TPC_G_S },
        { text: "G♯♯", value: AmbitusTypes.TPC_G_SS },
        { text: "A♭♭", value: AmbitusTypes.TPC_A_BB },
        { text: "A♭", value: AmbitusTypes.TPC_A_B },
        { text: "A", value: AmbitusTypes.TPC_A },
        { text: "A♯", value: AmbitusTypes.TPC_A_S },
        { text: "A♯♯", value: AmbitusTypes.TPC_A_SS },
        { text: "B♭♭", value: AmbitusTypes.TPC_B_BB },
        { text: "B♭", value: AmbitusTypes.TPC_B_B },
        { text: "B", value: AmbitusTypes.TPC_B },
        { text: "B♯", value: AmbitusTypes.TPC_B_S },
        { text: "B♯♯", value: AmbitusTypes.TPC_B_SS }
    ]

    height: childrenRect.height

    Item {
        height: childrenRect.height
        width: parent.width

        DropdownPropertyView {
            propertyItem: root.model ? root.model.topTpc : null
            titleText: qsTrc("inspector", "Top note")
            showMenuButton: false

            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 2

            model: root.tpcListModel
        }

        SpinBoxPropertyView {
            propertyItem: root.model ? root.model.topOctave : null
            showTitle: true // Show empty label for correct alignment
            showMenuButton: false

            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 2
            anchors.right: parent.right

            step: 1
            decimals: 0
            maxValue: 8
            minValue: -1
        }
    }

    Item {
        height: childrenRect.height
        width: parent.width

        DropdownPropertyView {
            propertyItem: root.model ? root.model.bottomTpc : null
            titleText: qsTrc("inspector", "Bottom note")
            showMenuButton: false

            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 2

            model: root.tpcListModel
        }

        SpinBoxPropertyView {
            propertyItem: root.model ? root.model.bottomOctave : null
            showTitle: true // Show empty label for correct alignment
            showMenuButton: false

            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 2
            anchors.right: parent.right

            step: 1
            decimals: 0
            maxValue: 8
            minValue: -1
        }
    }

    FlatButton {
        width: parent.width
        text: qsTrc("inspector", "Update to match the notes on the staff")
        onClicked: {
            if (root.model) {
                root.model.matchRangesToStaff()
            }
        }
    }

    ExpandableBlank {
        isExpanded: false

        title: isExpanded ? qsTrc("inspector", "Show less") : qsTrc("inspector", "Show more")

        width: parent.width

        contentItemComponent: Column {
            height: implicitHeight
            width: parent.width

            spacing: 12

            FlatRadioButtonGroupPropertyView {
                titleText: qsTrc("inspector", "Direction")
                propertyItem: root.model ? root.model.direction : null

                model: [
                    { iconCode: IconCode.AMBITUS, value: DirectionTypes.HORIZONTAL_AUTO },
                    { iconCode: IconCode.AMBITUS_LEANING_LEFT, value: DirectionTypes.HORIZONTAL_LEFT },
                    { iconCode: IconCode.AMBITUS_LEANING_RIGHT, value: DirectionTypes.HORIZONTAL_RIGHT }
                ]
            }

            NoteheadGroupSelector {
                propertyItem: root.model ? root.model.noteheadGroup : null
            }

            NoteheadTypeSelector {
                propertyItem: root.model ? root.model.noteheadType : null
            }

            SpinBoxPropertyView {
                anchors.left: parent.left
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 2

                titleText: qsTrc("inspector", "Line thickness")
                propertyItem: root.model ? root.model.lineThickness : null

                step: 0.1
                maxValue: 10
                minValue: 0.1
                decimals: 2
            }
        }
    }
}
