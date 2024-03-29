//
//  PlayingCard.m
//  Matchismo
//
//  Created by Karthik on 2/5/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (NSString *) contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (NSString *) suit {
    return _suit ? _suit : @"?";
}

- (void) setSuit:(NSString *)suit {
    if ([ [PlayingCard validSuits]containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSArray *) validSuits {
    return @[@"♣︎", @"♠︎", @"♥️", @"♦️"];
}

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {
    return [[PlayingCard rankStrings] count]-1;
}

- (void) setRank:(int)rank {
    if ( rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSInteger) match:(NSArray *)cards {
    NSInteger score = 0;
    for (PlayingCard *card in cards) {
        score += [self matchCard:card];
    }
    if([cards count] > 1) {
        score += [cards[0] matchCard:cards[1]];
    }
    return score;
}

- (NSInteger)matchCard:(PlayingCard *) card {
    if (self.rank == card.rank) {
        return 4;
    } else if ([self.suit isEqualToString:card.suit]) {
        return 1;
    }
    return 0;
}

@end
