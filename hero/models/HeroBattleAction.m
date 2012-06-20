//
//  HeroBattleAction.m
//  hero
//
//  Created by Minhao Zhang on 2012-06-20.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#import "HeroBattleAction.h"

@implementation HeroBattleAction

@synthesize actionType = _actionType, action = _action, unit = _unit;
@synthesize param1 = _param1, param2 = _param2;

+ (HeroBattleAction *)actionWithType:(NSUInteger)actionType action:(NSUInteger)action unit:(NSUInteger)unit param1:(NSInteger)param1 param2:(NSInteger)param2
{
    HeroBattleAction * ret = [[self alloc] init];
    ret.actionType = actionType;
    ret.action = action;
    ret.unit = unit;
    ret.param1 = param1;
    ret.param2 = param2;
    return [ret autorelease];
}

+ (HeroBattleAction *)physicalAttackActionWithUnit:(NSUInteger)unit action:(NSUInteger)action
{
    return [self actionWithType:HERO_BA_PHYSICAL_ATTACK
                         action:action
                           unit:unit
                         param1:0
                         param2:0];
}

+ (HeroBattleAction *)physicalHitActionWithUnit:(NSUInteger)unit action:(NSUInteger)action damage:(NSInteger)damage
{
    return [self actionWithType:HERO_BA_PHYSICAL_HIT
                         action:action
                           unit:unit
                         param1:damage
                         param2:0];
}
@end
