//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 15.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong,nonatomic) CardMatchingGame *game;
@property (weak,nonatomic) IBOutlet UILabel *lastFippedResultLabel;

@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}
-(void)setFlipCount:(int)flipCount
{
    _flipCount=flipCount;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons=cardButtons;
    [self updateUI];
}

-(NSAttributedString *)lastFlipResult:(CardMatchingGame *)cardMatchingGame
{
    NSString *result=@"";
  
    NSMutableAttributedString *mat;
   
    if(cardMatchingGame.lastScore ==(0-FLIP_COST)){
        
        Card *lastFlippedCard=[cardMatchingGame.lastFlippedCards lastObject];
        if(lastFlippedCard!=nil){
            result = [NSString stringWithFormat:@"Flipped up "];
            mat=[[NSMutableAttributedString alloc]initWithString:result];
            
           [mat appendAttributedString:[self getAttributedCardContents:lastFlippedCard]];
            
            return mat;
        }
    }
    else
        if(cardMatchingGame.lastScore>0)
        {
            mat = [[NSMutableAttributedString alloc]init];
            NSMutableAttributedString *matPom = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            [mat appendAttributedString:matPom];
            for(Card *card in cardMatchingGame.lastFlippedCards){
                [mat appendAttributedString:[self getAttributedCardContents:card]];
                if([cardMatchingGame.lastFlippedCards lastObject]!= card)
                     [mat appendAttributedString:[matPom initWithString:@" & "]];
                
            }
            [mat appendAttributedString:[matPom initWithString:[NSString stringWithFormat:@" for %d points",cardMatchingGame.lastScore]]];
        }else if(cardMatchingGame.lastScore<0)
        {
            mat = [[NSMutableAttributedString alloc]init];
            NSMutableAttributedString *matPom =[[NSMutableAttributedString alloc]init];
            for(Card *card in cardMatchingGame.lastFlippedCards){
                [mat appendAttributedString:[self getAttributedCardContents:card]];
                if([cardMatchingGame.lastFlippedCards lastObject]!=card)
                    [mat appendAttributedString:[matPom initWithString:@" & "]];
               
            }
            [mat appendAttributedString:[matPom initWithString:[NSString stringWithFormat:@" don't match! %d points",cardMatchingGame.lastScore]]];
        }
    
    return mat;
}


- (IBAction)Deal:(UIButton *)sender {
    
    self.game=nil;
    self.flipCount=0;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender {
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    
    [self updateUI];
}

-(void)startGame:(CardMatchingGame *)game
{
    _game=game;
    
}
-(CardMatchingGame *)currentGame
{
    return _game;
}

-(void) updateUI
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",_game.score];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips : %d",self.flipCount];
    self.lastFippedResultLabel.attributedText = [self lastFlipResult:self.game];
}

-(NSAttributedString *) getAttributedCardContents: (Card *)card{
    [ NSException raise:@"Abstract method" format:@"Abstract method"];
    return nil;
}

@end
