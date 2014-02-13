//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Karthik on 2/3/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
- (Deck *) createDeck;
@end
