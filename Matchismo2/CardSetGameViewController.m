//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 10.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardSetGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingSetCardDeck.h"
#import "PlayingSetCard.h"

#define GAME_MODE 3 //match 3 cards

@interface CardSetGameViewController ()
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardSetGameViewController

-(CardMatchingGame *)game
{
    if(![self currentGame])
    {
        CardMatchingGame *ame = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                                  usingDeck:[[PlayingSetCardDeck alloc]init]
                                                                   gameMode:GAME_MODE];
        [self startGame:ame];
        [self updateUI];
    }
    return [self currentGame];
}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card=[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if(card.isFaceUp)
            cardButton.backgroundColor=[UIColor grayColor];
        else
            cardButton.backgroundColor=nil;
        
        [cardButton setAttributedTitle:[self getAttributedCardContents:(PlayingSetCard*)card] forState:UIControlStateNormal];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled =!card.isUnplayable;
        cardButton.alpha =card.isUnplayable? 0.3:1.0;
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(1,-1,-1,-1)];
      }
    [super updateUI];
  
}


-(NSAttributedString *) getAttributedCardContents: (PlayingSetCard *)card
{
    NSMutableAttributedString *mat=[[NSMutableAttributedString alloc]initWithString:card.contents];
    NSRange range = [[mat string] rangeOfString: card.contents];

    UIColor *color;
    double strokeWidth=0;
    if([card.color isEqualToString:@"Green"])
        color=[UIColor greenColor];
    else if([card.color isEqualToString:@"Red"])
        color=[UIColor redColor];
    else if([card.color isEqualToString:@"Purple"])
        color=[UIColor purpleColor];
    
    if([card.shading isEqualToString:@"striped"]){
        color=[color colorWithAlphaComponent:0.3];
    }
    
    if([card.shading isEqualToString:@"solid"])
        strokeWidth=-5;
    else if([card.shading isEqualToString:@"open"])
        strokeWidth=5;
    else if([card.shading isEqualToString:@"striped"])
        strokeWidth=-5;

    [mat addAttributes:@{NSStrokeWidthAttributeName:@(strokeWidth),NSStrokeColorAttributeName:color,NSForegroundColorAttributeName:color } range:range];

    return mat;
}


@end
