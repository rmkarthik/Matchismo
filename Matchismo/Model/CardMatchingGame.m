//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Karthik on 2/6/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) NSUInteger chosenCardCount;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    
    self = [super init];
    
    if( self ){
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
    
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int CHOOSE_COST = 1;

- (void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.chosenCardCount --;
        } else {
            self.chosenCardCount ++;
            card.chosen = YES;
            if(self.isTwoCardMode) {
                if (self.chosenCardCount == 2 ) {
                    [self calculateScore:card];
                }
            } else {
                if (self.chosenCardCount == 3 ) {
                    [self calculateScore:card];
                }
            }
        }
    }
    self.score -= CHOOSE_COST;
}

- (void) calculateScore:(Card *) selectedCard {
    NSMutableArray* alreadySelectedCards = [[NSMutableArray alloc] init];
    
    for (Card *otherCard in self.cards) {
        if (selectedCard != otherCard && otherCard.isChosen && !otherCard.isMatched) {
            [alreadySelectedCards addObject:otherCard];
        }
    }
    int matchScore = [selectedCard match:alreadySelectedCards];
    if (matchScore) {
        self.score += matchScore * MATCH_BONUS;
        selectedCard.matched = YES;
        ((Card*)alreadySelectedCards[0]).matched = YES;
        if(!self.twoCardMode && [alreadySelectedCards count] > 1) {
            ((Card*)alreadySelectedCards[1]).matched = YES;
        }
        self.chosenCardCount = 0;
    } else {
        self.score -= MISMATCH_PENALTY;
        ((Card*)alreadySelectedCards[0]).chosen = NO;
        self.chosenCardCount --;
        if(!self.twoCardMode && [alreadySelectedCards count] > 1) {
            ((Card*)alreadySelectedCards[1]).chosen = NO;
            self.chosenCardCount --;
        }
    }
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? self.cards[index] : nil;
}

@end
