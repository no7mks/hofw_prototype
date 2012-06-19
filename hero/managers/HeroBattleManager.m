//
//  HeroBattleManager.m
//  hero
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright (c) 2012 Zentertain. All rights reserved.
//

#import "HeroBattleManager.h"
@interface HeroBattleManager ()
- (void)onFrameTicked;
@end
@implementation HeroBattleManager

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
        [NSTimer scheduledTimerWithTimeInterval:0.1f
                                         target:self
                                       selector:@selector(onFrameTicked)
                                       userInfo:nil
                                        repeats:YES];
        
    }
    return self;
}

- (void)onFrameTicked
{
    
}
@end
