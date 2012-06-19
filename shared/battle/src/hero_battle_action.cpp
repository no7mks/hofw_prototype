//
//  hero_battle_action.cpp
//  cc20test
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#include "hero_battle_action.h"

void HeroBattleAction_c::serialize(ztt::Buffer_c &buf) const
{
    buf << actionType
    << action
    << unit
    << param1
    << param2
    ;
}

void HeroBattleAction_c::deserialize(const ztt::Buffer_c &buf)
{
    buf >> actionType
    >> action
    >> unit
    >> param1
    >> param2
    ;
}