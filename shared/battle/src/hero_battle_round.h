//
//  hf_battle_round.h
//  cc20test
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#ifndef cc20test_hf_battle_round_h
#define cc20test_hf_battle_round_h

#include <stdint.h>
#include <vector>

class HeroBattleAction_c;

class HeroBattleRound_c
{
public:
    int32_t frame;
    std::vector<HeroBattleAction_c> actions;
};



#endif
