//
//  hero_battle_action.h
//  cc20test
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#ifndef cc20test_hero_battle_action_h
#define cc20test_hero_battle_action_h

#include "hero_battle_defines.h"
#include <list>

#include "buffer.h"
class HeroBattleAction_c : public ztt::Bufferable_c
{
public:
    uint8_t actionType;
    uint32_t action;
    uint32_t unit;
    int32_t param1;
    int32_t param2;

public:
    virtual void serialize(ztt::Buffer_c& buf) const;
    virtual void deserialize(const ztt::Buffer_c& buf);
};

#endif
