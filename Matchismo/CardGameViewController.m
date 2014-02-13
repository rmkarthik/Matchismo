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
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardMode;
@property (weak, nonatomic) IBOutlet UIButton *startGame;
@end

@implementation CardGameViewController

@synthesize game = _game;

- (CardMatchingGame *) game {
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cards count] usingDeck:[self createDeck]];
    return _game;
}

- (void) setGame:(CardMatchingGame *)game {
    _game = game;
}

- (void)viewDidLoad {
    [self resetGame];
}

- (IBAction)resetGame {
    self.game = nil;
    [self updateUI:YES];
    self.cardMode.enabled = true;
    self.cardMode.selectedSegmentIndex = 0;
    self.startGame.enabled = true;
}
- (IBAction)startGame:(UIButton *) sender {
    self.cardMode.enabled = false;
    sender.enabled = false;
    [self updateUI:NOTRESET];
}

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)selectMode:(UISegmentedControl *)sender {
    self.game.twoCardMode = sender.selectedSegmentIndex ? YES : NO;
    NSLog(@"Selected Mode is %hhd", self.game.twoCardMode );
}

static const BOOL NOTRESET = NO;

- (IBAction)touchButton:(UIButton *)sender {
    int chooseButtonIndex = [self.cards indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI: NOTRESET];
}

- (void) updateUI:(BOOL) reset {
    for (UIButton *cardButton in self.cards) {
        int chooseButtonIndex = [self.cards indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:chooseButtonIndex];
        if (card) {
            [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        }
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        if(!reset)  cardButton.enabled = !card.matched;
        else cardButton.enabled = false;
    }
}

- (NSString *) titleForCard:(Card *) card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end
