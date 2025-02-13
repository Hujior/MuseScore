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

#include "mixerpanelcontextmenumodel.h"

#include "translation.h"

using namespace mu::playback;
using namespace mu::ui;
using namespace mu::actions;

static const ActionCode TOGGLE_MIXER_SECTION_ACTION("toggle-mixer-section");

static const QString VIEW_MENU_ID("view-menu");

static QString mixerSectionTitle(MixerSectionType type)
{
    switch (type) {
    case MixerSectionType::Labels: return mu::qtrc("playback", "Labels");
    case MixerSectionType::Sound: return mu::qtrc("playback", "Sound");
    case MixerSectionType::AudioFX: return mu::qtrc("playback", "Audio FX");
    case MixerSectionType::Balance: return mu::qtrc("playback", "Pan");
    case MixerSectionType::Volume: return mu::qtrc("playback", "Volume");
    case MixerSectionType::Title: return mu::qtrc("playback", "Name");
    case MixerSectionType::Unknown: break;
    }

    return QString();
}

MixerPanelContextMenuModel::MixerPanelContextMenuModel(QObject* parent)
    : AbstractMenuModel(parent)
{
}

bool MixerPanelContextMenuModel::labelsSectionVisible() const
{
    return isSectionVisible(MixerSectionType::Labels);
}

bool MixerPanelContextMenuModel::soundSectionVisible() const
{
    return isSectionVisible(MixerSectionType::Sound);
}

bool MixerPanelContextMenuModel::audioFxSectionVisible() const
{
    return isSectionVisible(MixerSectionType::AudioFX);
}

bool MixerPanelContextMenuModel::balanceSectionVisible() const
{
    return isSectionVisible(MixerSectionType::Balance);
}

bool MixerPanelContextMenuModel::volumeSectionVisible() const
{
    return isSectionVisible(MixerSectionType::Volume);
}

bool MixerPanelContextMenuModel::titleSectionVisible() const
{
    return isSectionVisible(MixerSectionType::Title);
}

void MixerPanelContextMenuModel::load()
{
    dispatcher()->reg(this, TOGGLE_MIXER_SECTION_ACTION, this, &MixerPanelContextMenuModel::toggleMixerSection);

    MenuItemList viewMenuItems;
    for (const MixerSectionType& sectionType : allMixerSectionTypes()) {
        viewMenuItems << buildViewMenuItem(sectionType);
    }

    MenuItemList viewMenu {
        makeMenu(qtrc("playback", "View"), viewMenuItems, true /*enabled*/, VIEW_MENU_ID)
    };

    setItems(viewMenu);
}

bool MixerPanelContextMenuModel::isSectionVisible(MixerSectionType sectionType) const
{
    return configuration()->isMixerSectionVisible(sectionType);
}

MenuItem MixerPanelContextMenuModel::buildViewMenuItem(MixerSectionType sectionType) const
{
    int sectionTypeInt = static_cast<int>(sectionType);

    MenuItem item;
    item.id = QString::number(sectionTypeInt);
    item.title = mixerSectionTitle(sectionType);
    item.code = TOGGLE_MIXER_SECTION_ACTION;
    item.state.enabled = true;
    item.state.checked = isSectionVisible(sectionType);
    item.args = ActionData::make_arg1<int>(sectionTypeInt);
    item.checkable = Checkable::Yes;

    return item;
}

void MixerPanelContextMenuModel::toggleMixerSection(const actions::ActionData& args)
{
    if (args.empty()) {
        return;
    }

    int sectionTypeInt = args.arg<int>(0);
    MixerSectionType sectionType = static_cast<MixerSectionType>(sectionTypeInt);

    bool newVisibilityValue = !isSectionVisible(sectionType);
    configuration()->setMixerSectionVisible(sectionType, newVisibilityValue);

    switch (sectionType) {
    case MixerSectionType::Labels:
        emit labelsSectionVisibleChanged();
        break;
    case MixerSectionType::Sound:
        emit soundSectionVisibleChanged();
        break;
    case MixerSectionType::AudioFX:
        emit audioFxSectionVisibleChanged();
        break;
    case MixerSectionType::Balance:
        emit balanceSectionVisibleChanged();
        break;
    case MixerSectionType::Volume:
        emit volumeSectionVisibleChanged();
        break;
    case MixerSectionType::Title:
        emit titleSectionVisibleChanged();
        break;
    case MixerSectionType::Unknown:
        break;
    }

    QString sectionItemId = QString::number(sectionTypeInt);
    MenuItem& viewMenu = findMenu(VIEW_MENU_ID);

    for (MenuItem& item : viewMenu.subitems) {
        if (item.id == sectionItemId) {
            item.state.checked = newVisibilityValue;
            break;
        }
    }

    emit itemChanged(viewMenu);
}
