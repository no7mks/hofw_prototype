//
//  HeroBattleManager.h
//  hero
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroBattleManager : NSObject
+ (HeroBattleManager *)sharedInstance;


- (void)startBattle;
- (void)endBattle;

@end

#define BATTLE_MAN ([HeroBattleManager sharedInstance])
