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
#include "palmmutesettingsmodel.h"

using namespace mu::inspector;

PalmMuteSettingsModel::PalmMuteSettingsModel(QObject* parent, IElementRepositoryService* repository)
    : LineSettingsModel(parent, repository, Ms::ElementType::PALM_MUTE)
{
    setModelType(InspectorModelType::TYPE_PALM_MUTE);
    setTitle(qtrc("inspector", "Palm mute"));

    createProperties();
}

void PalmMuteSettingsModel::createProperties()
{
    LineSettingsModel::createProperties();

    startHookType()->setIsVisible(false);
    endHookType()->setIsVisible(false);

    beginingTextHorizontalOffset()->setIsVisible(false);
    continiousTextHorizontalOffset()->setIsVisible(false);
}
