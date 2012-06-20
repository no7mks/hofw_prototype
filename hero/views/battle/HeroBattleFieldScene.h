//
//  HeroBattleFieldView.h
//  hero
//
//  Created by Minhao Zhang on 2012-06-19.
//  Copyright 2012 Zentertain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HeroBattleAction.h"

@interface HeroBattleFieldScene : CCNode {
    
}
+ (HeroBattleFieldScene *)currentNode;

@property (nonatomic) NSUInteger maxFrame;

- (void)setup;
- (void)pushAction:(HeroBattleAction *)action frame:(NSUInteger)frame;

@end
