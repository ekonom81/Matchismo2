//
//  PlayingCard.m
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 03.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards
{
    int matchType=0;
    int score = 0;
    if(otherCards.count > 0){
    
    for(PlayingCard *otherCard in otherCards){
        if([otherCard.suit isEqualToString:self.suit]&&matchType!=2){
            score=1;
            matchType=1;
        }else if(otherCard.rank==self.rank&&matchType!=1){
            score=4;
            matchType=2;
        }else
        {
            return 0;
        }
    }
    
    }
    
    return score*otherCards.count;
}

-(NSString *)contents
{
    NSArray *rankStrings= [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+(NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit=suit;
    }
}
-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count-1; }


- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}



@end
