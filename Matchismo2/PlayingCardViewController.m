//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 03.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"

#define GAME_MODE 2 //match 2 cards

@interface PlayingCardViewController ()
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak,nonatomic) UIImage *cardBackImage;

@end

@implementation PlayingCardViewController


-(UIImage *)cardBackImage
{
    if(!_cardBackImage){
        _cardBackImage = [UIImage imageNamed:@"CardBack.png"];
    }
    return _cardBackImage;
}

-(CardMatchingGame *)game
{
    if(![self currentGame])
    {
     CardMatchingGame *ame = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                        usingDeck:[[PlayingCardDeck alloc]init]
                                                         gameMode:GAME_MODE];
     [self startGame:ame];
    }
    return [self currentGame];
}


-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card=[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:[self getAttributedCardContents:(PlayingCard*)card] forState:UIControlStateNormal];
        [cardButton setAttributedTitle:[self getAttributedCardContents:(PlayingCard*)card] forState:UIControlStateNormal|UIControlStateDisabled];
     
        cardButton.selected = card.isFaceUp;
        cardButton.enabled =!card.isUnplayable;
        cardButton.alpha =card.isUnplayable? 0.3:1.0;
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(1,-1,-1,-1)];
        if(!card.isFaceUp)
            [cardButton setImage: self.cardBackImage forState:UIControlStateNormal];
        else
         [cardButton setImage: nil forState:UIControlStateNormal];
    }
    [super updateUI];
      
}

-(NSAttributedString *) getAttributedCardContents: (PlayingCard *)card
{
 NSMutableAttributedString *mat=[[NSMutableAttributedString alloc]initWithString:card.contents];
 NSRange range = [[mat string] rangeOfString: card.contents];
 
 UIColor *color;
 
 if([card.suit isEqualToString:@"♥"]|| [card.suit isEqualToString:@"♦"])
     color=[UIColor redColor];
 else if([card.suit isEqualToString:@"♠"] || [card.suit isEqualToString:@"♣"])
     color=[UIColor blackColor];
 
 [mat addAttributes:@{NSForegroundColorAttributeName:color } range:range];
 
 return mat;
}

@end
