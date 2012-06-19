//
//  HeroBattleFieldView.m
//  hero
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright 2012 Zentertain. All rights reserved.
//

#import "HeroBattleFieldScene.h"


@implementation HeroBattleFieldScene
- (id)init
{
    if (self = [super init])
    {
        CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(0, 180, 0, 255)];
        [self addChild:layer];
    }
    return self;
}
@end
