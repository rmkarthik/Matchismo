//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Karthik on 2/13/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
