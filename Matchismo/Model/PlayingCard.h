//
//  PlayingCard.h
//  Matchismo
//
//  Created by Karthik on 2/5/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) int rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
