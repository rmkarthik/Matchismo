//
//  Card.h
//  Matchismo
//
//  Created by Karthik on 2/3/14.
//  Copyright (c) 2014 Karthik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)cards;
@end
