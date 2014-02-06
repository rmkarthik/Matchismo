//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Karthik on 2/3/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "Card.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cards;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game {
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cards count] usingDeck:[self createDeck]];
    return _game;
}

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchButton:(UIButton *)sender {
    int chooseButtonIndex = [self.cards indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}

- (void) updateUI {
    for (UIButton *cardButton in self.cards) {
        int chooseButtonIndex = [self.cards indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:chooseButtonIndex];
        if (card) {
            [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        }
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        cardButton.enabled = !card.matched;
    }
}

- (NSString *) titleForCard:(Card *) card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
