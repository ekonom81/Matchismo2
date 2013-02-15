//
//  PlayingCardViewController.h
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 15.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController
-(NSAttributedString *)lastFlipResult:(CardMatchingGame *)cardMatchingGame;
-(void)updateUI;
-(void)startGame:(CardMatchingGame *)game;
-(CardMatchingGame *)currentGame;
-(NSAttributedString *) getAttributedCardContents: (Card *)card;
-(void)setCardButtons:(NSArray *)cardButtons;
-(NSArray *)cardButtons;
@end
