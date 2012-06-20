//
//  hero_map.cpp
//  hero
//
//  Created by Minhao Zhang on 2012-06-20.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#include "hero_map.h"

using namespace ztt;

HeroMap_c::HeroMap_c(int w, int h)
{
    width = w;
    height = h;
    
    terrain = new char*[w];
    for (size_t i=0; i<w; ++i)
    {
        terrain[i] = new char[h];
    }
}

HeroMap_c::~HeroMap_c()
{
    for (size_t i=0; i<width; ++i)
    {
        delete [] terrain[i];
    }
    delete [] terrain;
}

float HeroMap_c::realCost(int32_t node, int32_t target)
{
    MapPoint_st pt1 = ID2PT(node);
    MapPoint_st pt2 = ID2PT(target);
    
    float scale = 1.414f;
    if (pt1.x == pt2.x || pt1.y == pt2.y) scale = 1.f;
    
    switch (terrain[pt2.x][pt2.y]) {
        case 0:
            return scale * 1.f;
            break;
            
        default:
            return 1000.f;
            break;
    }
}
