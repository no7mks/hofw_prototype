//
//  HeroBattleFieldView.m
//  hero
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright 2012 Zentertain. All rights reserved.
//

#import "HeroBattleFieldScene.h"

#import <vector>
#import <map>

using namespace std;

static HeroBattleFieldScene * g_cnode = nil;

@interface HeroBattleFieldScene ()
- (void)onFrameTicked;
- (void)performAction:(HeroBattleAction *)action;
@end

@implementation HeroBattleFieldScene
{
    NSTimer * _timer;
    
    NSUInteger _currentFrame;
    
    map<NSUInteger, vector<HeroBattleAction *> > _pendingRounds;
}

+ (HeroBattleFieldScene *)currentNode 
{
    return g_cnode;
}

@synthesize maxFrame = _maxFrame;

- (id)init
{
    if (self = [super init])
    {
        CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(0, 180, 0, 255)];
        [self addChild:layer];
    }
    return self;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    NSAssert(g_cnode == nil, @"only one instance allowed!");
    
    g_cnode = self;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                              target:self
                                            selector:@selector(onFrameTicked)
                                            userInfo:nil
                                             repeats:YES];
    _currentFrame = 0;

    [self setup];
}

- (void)onExitTransitionDidStart
{
    [_timer invalidate];
    _timer = nil;
    
    for (map<NSUInteger, vector<HeroBattleAction *> >::iterator iter1 = _pendingRounds.begin();
         iter1 != _pendingRounds.end();
         ++iter1)
    {
        vector<HeroBattleAction *> actions = iter1->second;
        for (vector<HeroBattleAction *>::iterator iter2 = actions.begin();
             iter2 != actions.end();
             ++iter2)
        {
            [(*iter2) autorelease];
        }
    }
    _pendingRounds.clear();

    g_cnode = nil;
    [super onExitTransitionDidStart];
}

- (void)onFrameTicked
{
    if (_currentFrame >= self.maxFrame) return;
    
    _currentFrame++;
    
    if (_pendingRounds.find(_currentFrame) != _pendingRounds.end())
    {
        vector<HeroBattleAction *> actions = _pendingRounds[_currentFrame];
        for (vector<HeroBattleAction *>::iterator iter = actions.begin();
             iter != actions.end();
             ++iter)
        {
            HeroBattleAction * action = *iter;
            [self performAction:action];
        }
        
        _pendingRounds.erase(_currentFrame);
    }
}

- (void)setup
{
    int x, y;
    x = 10, y = 10;
    for (size_t i = 1; i <= 3; ++i)
    {
        for (size_t j = 1; j <= 3; ++j)
        {
            x = 10 + i * 60;
            y = 50 + j * 60;
            CCLabelTTF * label = [CCLabelTTF labelWithString:@"A" fontName:@"futura" fontSize:12];
            label.position = ccp(x, y);
            label.color = ccBLACK;
            [self addChild:label];
        }
    }
    for (size_t i = 1; i <= 3; ++i)
    {
        for (size_t j = 1; j <= 3; ++j)
        {
            x = 240 + i * 60;
            y = 50 + j * 60;
            CCLabelTTF * label = [CCLabelTTF labelWithString:@"B" fontName:@"futura" fontSize:12];
            label.position = ccp(x, y);
            label.color = ccWHITE;
            [self addChild:label];
        }
    }

    self.maxFrame = 60;
    
    HeroBattleAction * action;
    
    action = [HeroBattleAction physicalAttackActionWithUnit:1 action:1];
    [self pushAction:action frame:5];
    action = [HeroBattleAction physicalHitActionWithUnit:11 action:1 damage:20];
    [self pushAction:action frame:5];
    
    action = [HeroBattleAction physicalAttackActionWithUnit:12 action:1];
    [self pushAction:action frame:10];
    action = [HeroBattleAction physicalHitActionWithUnit:2 action:1 damage:30];
    [self pushAction:action frame:10];
    
    action = [HeroBattleAction physicalAttackActionWithUnit:3 action:1];
    [self pushAction:action frame:15];
    action = [HeroBattleAction physicalHitActionWithUnit:10 action:1 damage:20];
    [self pushAction:action frame:15];
    action = [HeroBattleAction physicalHitActionWithUnit:13 action:1 damage:22];
    [self pushAction:action frame:15];
    action = [HeroBattleAction physicalHitActionWithUnit:16 action:1 damage:25];
    [self pushAction:action frame:15];
    
    action = [HeroBattleAction physicalAttackActionWithUnit:12 action:1];
    [self pushAction:action frame:20];
    action = [HeroBattleAction physicalHitActionWithUnit:2 action:1 damage:30];
    [self pushAction:action frame:20];

    action = [HeroBattleAction actionWithType:HERO_BA_PHYSICAL_HIT_AND_DIE action:0 unit:2 param1:0 param2:0];
    [self pushAction:action frame:24];
    
}

- (void)pushAction:(HeroBattleAction *)action frame:(NSUInteger)frame
{
    [action retain];
    _pendingRounds[frame].push_back(action);
}

- (void)performAction:(HeroBattleAction *)action
{
    NSLog(@"We should perform action, unit = %d, actionType = %d, action = %d", action.unit, action.actionType, action.action);
    
    BOOL isAttack = (action.unit < 10);
    NSUInteger unit = action.unit;
    if (!isAttack) unit -= 10;
    
    int row = unit / 3;
    int col = unit % 3;
    int x, y;
    x = (row + 1) * 60;
    y = (col + 1) * 60;
    if (isAttack)
    {
        x += 10; y += 50;
    }
    else
    {
        x += 240; y += 50;
    }
    
    switch (action.actionType) {
        case HERO_BA_PHYSICAL_ATTACK:
        {
            CCLabelTTF * label = [CCLabelTTF labelWithString:@"Attack!" fontName:@"futura" fontSize:18];
            label.color = ccRED;
            label.position = ccp(x, y);
            
            CCMoveBy * moveby = [CCMoveBy actionWithDuration:1.f position:ccp(0, y+20)];
            CCCallBlockN * callback = [CCCallBlockN actionWithBlock:^(CCNode *node) {
                [node removeFromParentAndCleanup:YES];
            }];
            CCSequence * seq = [CCSequence actions:moveby, callback, nil];
            [self addChild:label];
            [label runAction:seq];
        }
            break;
        case HERO_BA_PHYSICAL_HIT:
        {
            CCLabelTTF * label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Hit: %d", action.param1] fontName:@"futura" fontSize:18];
            label.color = ccYELLOW;
            label.position = ccp(x, y);
            
            CCHide * hide = [CCHide action];
            CCDelayTime * delay = [CCDelayTime actionWithDuration:.5f];
            CCShow * show = [CCShow action];
            CCMoveBy * moveby = [CCMoveBy actionWithDuration:1.f position:ccp(0, y+20)];
            CCCallBlockN * callback = [CCCallBlockN actionWithBlock:^(CCNode *node) {
                [node removeFromParentAndCleanup:YES];
            }];
            CCSequence * seq = [CCSequence actions:hide, delay, show, moveby, callback, nil];
            [self addChild:label];
            [label runAction:seq];
        }
            break;
        case HERO_BA_PHYSICAL_HIT_AND_DIE:
        {
            CCLabelTTF * label = [CCLabelTTF labelWithString:@"DIE" fontName:@"futura" fontSize:18];
            label.color = ccGRAY;
            label.position = ccp(x, y);
            
            CCHide * hide = [CCHide action];
//            CCDelayTime * delay = [CCDelayTime actionWithDuration:.5f];
            CCShow * show = [CCShow action];
            CCMoveBy * moveby = [CCMoveBy actionWithDuration:1.f position:ccp(0, y+20)];
            CCCallBlockN * callback = [CCCallBlockN actionWithBlock:^(CCNode *node) {
                [node removeFromParentAndCleanup:YES];
            }];
            CCSequence * seq = [CCSequence actions:hide, show, moveby, callback, nil];
            [self addChild:label];
            [label runAction:seq];
        }
            break;
            
        default:
            break;
    }
}

@end
