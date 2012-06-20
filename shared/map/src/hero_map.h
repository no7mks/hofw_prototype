//
//  hero_map.h
//  hero
//
//  Created by Minhao Zhang on 2012-06-20.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#ifndef hero_hero_map_h
#define hero_hero_map_h

#include "astar.h"

class HeroMap_c : public ztt::AIAStarSquareMap_i
{
public:
    HeroMap_c(int w, int h);
    virtual ~HeroMap_c();
    
    char** terrain;
public:
    virtual float realCost(int32_t node, int32_t target);
};

#endif
