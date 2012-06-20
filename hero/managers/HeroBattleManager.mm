//
//  HeroBattleManager.m
//  hero
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#import "HeroBattleManager.h"

#import "HeroNotificationDefines.h"

#import "HeroBattleFieldScene.h"

@interface HeroBattleManager ()
@end

@implementation HeroBattleManager
{
}

+ (HeroBattleManager *)sharedInstance
{
    static HeroBattleManager * s = nil;
    if (s == nil)
    {
        s = [[HeroBattleManager alloc] init];
    }
    return s;
}


- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)startBattle
{
    
}

- (void)endBattle
{
    
}
@end
