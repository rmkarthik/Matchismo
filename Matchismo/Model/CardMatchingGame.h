//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Karthik on 2/6/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject
@property (nonatomic, readonly) NSInteger score;

- (instancetype) initWithCardCount:(NSUInteger) count
                         usingDeck:(Deck *) deck;
- (void) chooseCardAtIndex:(NSUInteger) index;
- (Card *) cardAtIndex:(NSUInteger) index;
@end
