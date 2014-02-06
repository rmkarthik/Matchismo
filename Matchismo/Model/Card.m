//
//  Card.m
//  Matchismo
//
//  Created by Karthik on 2/3/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import "Card.h"

@implementation Card
- (int)match:(NSArray *)cards {
    int score = 0;
    
    for(Card *card in cards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}
@end
