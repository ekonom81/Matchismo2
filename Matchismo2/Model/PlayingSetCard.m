//
//  PlayingSetCard.m
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 11.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingSetCard.h"
@interface PlayingSetCard()
@property (nonatomic) int suitCount;
@property (nonatomic) int colorCount;
@property (nonatomic) int rankCount;
@property (nonatomic) int shadingCount;
@end;

@implementation PlayingSetCard

-(NSString *)contents
{
    NSString *myString=@"";
    for(int i =1;i<=self.rank;++i){
        myString =[ myString stringByAppendingString:self.suit];
    }
    return myString;
}

-(int)match:(NSArray *)otherCards
{
    _colorCount=0;
    _suitCount=0;
    _shadingCount=0;
    _rankCount=0;
    
    int score = 0;
    if(otherCards.count > 1){
        
        // compare card - otherCards
        for(PlayingSetCard *otherCard in otherCards){
            [self compareCards:otherCard secondCard:self];
        }
        // compare card from otherCards with each other card from otherCards;
        for(int i=0;i<otherCards.count-1;++i){
            for(int j=i+1;j<otherCards.count;++j){
                PlayingSetCard *cardI=otherCards[i];
                PlayingSetCard *cardJ=otherCards[j];
                [self compareCards:cardI secondCard:cardJ];
            }
        }
    }
    
    int allCards=otherCards.count+1;
    if((abs(_rankCount) == allCards)&&(abs(_colorCount)==allCards)&&(abs(_shadingCount)==allCards)&&(abs(_suitCount )==allCards)){
        score=1;
    }
    
    return score*otherCards.count;
    
}
-(void) compareCards:(PlayingSetCard*)firstCard secondCard:(PlayingSetCard*)secondCard
{
    if([firstCard.suit isEqualToString:secondCard.suit]){
        _suitCount++;
    }
    else
    {
        _suitCount--;
    }
    if([firstCard.color isEqualToString:secondCard.color]){
        _colorCount++;
    }else
    {
        _colorCount--;
    }
    if([firstCard.shading isEqualToString:secondCard.shading]){
        _shadingCount++;
    }
    else{
        _shadingCount--;
    }
    if(firstCard.rank ==secondCard.rank){
        _rankCount++;
    }
    else{
        _rankCount--;
    }
}
@synthesize suit=_suit;

-(void)setSuit:(NSString *)suit
{
    if([[PlayingSetCard validSuits] containsObject:suit]){
        _suit=suit;
    }
}
+(NSArray *)validSuits
{
    return @[@"▲",@"■",@"●"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"1",@"2",@"3"];
}

+ (NSArray *)validColors
{
    return @[@"Green",@"Red",@"Purple"];
}

+ (NSArray *)validShadings
{
    return @[@"solid",@"open",@"striped"];
}
@end
