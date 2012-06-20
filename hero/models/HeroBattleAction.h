//
//  HeroBattleAction.h
//  hero
//
//  Created by Minhao Zhang on 2012-06-20.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "hero_battle_defines.h"

@interface HeroBattleAction : NSObject

@property (nonatomic) NSUInteger actionType;
@property (nonatomic) NSUInteger action;
@property (nonatomic) NSUInteger unit;
@property (nonatomic) NSInteger param1;
@property (nonatomic) NSInteger param2;


+ (HeroBattleAction *)actionWithType:(NSUInteger)actionType
                              action:(NSUInteger)action
                                unit:(NSUInteger)unit
                              param1:(NSInteger)param1
                              param2:(NSInteger)param2;

+ (HeroBattleAction *)physicalAttackActionWithUnit:(NSUInteger)unit
                                            action:(NSUInteger)action;
+ (HeroBattleAction *)physicalHitActionWithUnit:(NSUInteger)unit
                                         action:(NSUInteger)action
                                         damage:(NSInteger)damage;

@end
