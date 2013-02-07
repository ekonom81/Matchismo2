//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 03.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentUI;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong,nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipResultLabel;
@property (weak,nonatomic) UIImage *cardBackImage;
@end

@implementation CardGameViewController
- (IBAction)gameModeSegmented:(UISegmentedControl *)sender
{
    self.game=nil;
    [self updateUI];
    
}

-(UIImage *)cardBackImage
{
    if(!_cardBackImage){
        _cardBackImage = [UIImage imageNamed:@"CardBack.png"];
    }
    return _cardBackImage;
}

-(CardMatchingGame *)game
{
    if(!_game)_game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                        usingDeck:[[PlayingCardDeck alloc]init]
                                                         gameMode:self.gameModeSegmentUI.selectedSegmentIndex+2];

    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
    
}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card=[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled =!card.isUnplayable;
        cardButton.alpha =card.isUnplayable? 0.3:1.0;
        //[cardButton setTitle:card.contents forState:UIControlStateNormal];
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(1,-1,-1,-1)];
        if(!card.isFaceUp)
            [cardButton setImage: self.cardBackImage forState:UIControlStateNormal];
        else
         [cardButton setImage: nil forState:UIControlStateNormal];
     
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.lastFlipResultLabel.text = [self lastFlipResult:self.game];
}

- (IBAction)Deal:(UIButton *)sender {
    self.gameModeSegmentUI.enabled=YES;
    self.game=nil;
    self.flipCount=0;
    [self updateUI];
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount=flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips : %d",self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    self.gameModeSegmentUI.enabled=NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    
    [self updateUI];
}

-(NSString *)lastFlipResult:(CardMatchingGame *)cardMatchingGame
{
    NSString *result=@"";
    NSMutableArray *resultArrayStr = [[NSMutableArray alloc]init];
    
    if(cardMatchingGame.lastScore ==(0-FLIP_COST)){
        
        Card *lastFlippedCard=[cardMatchingGame.lastFlippedCards lastObject];
        if(lastFlippedCard!=nil){
           
            result = [NSString stringWithFormat:@"Flipped up %@",lastFlippedCard];
            return result;
        }
    }
    else
        if(cardMatchingGame.lastScore>0)
        {
            [resultArrayStr addObject:@"Matched "];
            //if(self.gameModeSegmentUI.selectedSegmentIndex==0&&cardMatchingGame.lastFlippedCards.count>1){
            for(Card *card in cardMatchingGame.lastFlippedCards){
                [resultArrayStr addObject:card.contents];
                [resultArrayStr addObject:@" & "];
            }
            [resultArrayStr removeLastObject];
            [resultArrayStr addObject:[NSString stringWithFormat:@" for %d points",cardMatchingGame.lastScore]];
        }else if(cardMatchingGame.lastScore<0)
            {
                for(Card *card in cardMatchingGame.lastFlippedCards){
                    [resultArrayStr addObject:card.contents];
                    [resultArrayStr addObject:@" & "];
                }
                [resultArrayStr removeLastObject];
                [resultArrayStr addObject:[NSString stringWithFormat:@" don't match! %d points",cardMatchingGame.lastScore]];
            }
    
    return [resultArrayStr componentsJoinedByString:@" "];
}
@end
