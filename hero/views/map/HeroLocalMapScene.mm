//
//  HeroLocalMapScene.m
//  hero
//
//  Created by Minhao Zhang on 2012-06-20.
//  Copyright 2012 Zentertain. All rights reserved.
//

#import "HeroLocalMapScene.h"

#import "hero_map.h"

using namespace std;
using namespace ztt;

@interface HeroLocalMapScene ()
- (void)onTapped:(UIGestureRecognizer *)recognizer;
@end

@implementation HeroLocalMapScene
{
    HeroMap_c * _map;
    UITapGestureRecognizer * _gr;
    
    CCSprite * _tapTarget;
    
    CCSprite * _player;
    MapPoint_st _playerLocation;
    NSTimeInterval _playerMoveCD;

    list<int32_t> _route;
}

- (id)init
{
    if (self = [super init])
    {
        CCLayerColor * bg = [CCLayerColor layerWithColor:ccc4(0, 190, 0, 255)];
        [self addChild:bg z:INT_MIN];
        
        _map = new HeroMap_c(48, 32);
        
        _tapTarget = [CCLabelTTF labelWithString:@"X" fontName:@"futura" fontSize:10];
        _tapTarget.color = ccRED;
        _tapTarget.visible = NO;
        [self addChild:_tapTarget z:1];
        
        _player = [CCLabelTTF labelWithString:@"P" fontName:@"futura" fontSize:10];
        _player.anchorPoint = ccp (0, 0);
        _player.color = ccBLUE;
        _playerLocation.x = _playerLocation.y = 0;
        
        [self addChild:_player z:2];
        
        _playerMoveCD = 0;
    }
    return self;
}

- (void)dealloc
{
    delete _map;
    [super dealloc];
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    srand(time(NULL));
    for (size_t i = 0; i < _map->width; ++i)
    {
        for (size_t j = 0; j < _map->height; ++j)
        {
            _map->terrain[i][j] = (rand() % 4 == 0) ? 1 : 0;
            
            if (_map->terrain[i][j])
            {
                CCLabelTTF * label = [CCLabelTTF labelWithString:@"M" fontName:@"futura" fontSize:10];
                label.color = ccMAGENTA;
                label.anchorPoint = ccp (0, 0);
                label.position = ccp (i * 10, j * 10);
                [self addChild:label z:-1];
            }
        }
    }
    
    _gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    _gr.numberOfTapsRequired = 1;

    [[CCDirector sharedDirector].view addGestureRecognizer:_gr];
    
    [self scheduleUpdate];
}

- (void)onExitTransitionDidStart
{
    [[CCDirector sharedDirector].view removeGestureRecognizer:_gr];
    [super onExitTransitionDidStart];
}

- (void)onTapped:(UIGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        CCDirector * director = [CCDirector sharedDirector];
        CGPoint uipoint = [recognizer locationInView:director.view];
        CGPoint loc = [director convertToGL:uipoint];
        NSLog(@"touches at ui: %.0f,%.0f, gl is %.0f,%.0f", uipoint.x, uipoint.y, loc.x, loc.y);
        
        [_tapTarget stopAllActions];
        _tapTarget.position = loc;

        CCHide * hide = [CCHide action];
        CCShow * show = [CCShow action];
        CCDelayTime * delay = [CCDelayTime actionWithDuration:.6f];
        CCSequence * seq = [CCSequence actions:show, delay, hide, delay, nil];
        CCRepeat * rep = [CCRepeat actionWithAction:seq times:3];
        CCSequence * all = [CCSequence actions:rep, hide, nil];
        
        [_tapTarget runAction:all];
        
        MapPoint_st pt = {floorf(loc.x / 10), floorf(loc.y / 10)};
        AIAStar_c ai;
        _route = ai.search(*_map, PT2ID(_playerLocation), PT2ID(pt));
    }
}

- (void)update:(ccTime)time
{
    if (_route.size())
    {
        if (_playerMoveCD > 0)
        {
            _playerMoveCD -= time;
        }
        else
        {
            _playerMoveCD = .3f;
            int32_t pid = _route.front();
            _route.pop_front();
            MapPoint_st pt = ID2PT(pid);
            _playerLocation = pt;
            _player.position = ccp (pt.x * 10, pt.y * 10);
        }
        
    }
}
@end
