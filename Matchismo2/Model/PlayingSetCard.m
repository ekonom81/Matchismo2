//
//  PlayingSetCard.m
//  Matchismo
//
//  Created by Marcin Ekonomiuk on 11.02.2013.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingSetCard.h"

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
    int theSameColor=0;
    int theSameRank=0;
    int theSameSuit=0;
    int theSameShading=0;
    
    int score = 0;
    if(otherCards.count > 1){
        
        // compare card - otherCards
        for(PlayingSetCard *otherCard in otherCards){
            if([otherCard.suit isEqualToString:self.suit]){
                theSameSuit++;
            }
            else
            {
                theSameSuit--;
            }
            if([otherCard.color isEqualToString:self.color]){
                theSameColor++;
            }else
            {
                theSameColor--;
            }
            if([otherCard.shading isEqualToString:self.shading]){
                theSameShading++;
            }
            else{
                theSameShading--;
            }
            if(otherCard.rank ==self.rank){
                theSameRank++;
            }
            else{
                theSameRank--;
            }
        }
        // compare card from otherCards with each other card from otherCards;
        for(int i=0;i<otherCards.count-1;++i){
            for(int j=i+1;j<otherCards.count;++j){
                PlayingSetCard *cardI=otherCards[i];
                PlayingSetCard *cardJ=otherCards[j];
                if([cardI.suit isEqualToString:cardJ.suit]){
                    theSameSuit++;
                }
                else
                {
                    theSameSuit--;
                }
                if([cardI.color isEqualToString:cardJ.color]){
                    theSameColor++;
                }else
                {
                    theSameColor--;
                }
                if([cardI.shading isEqualToString:cardJ.shading]){
                    theSameShading++;
                }
                else{
                    theSameShading--;
                }
                if(cardI.rank ==cardJ.rank){
                    theSameRank++;
                }
                else{
                    theSameRank--;
                }
            }
        }
    }
    
    int allCards=otherCards.count+1;
    if((abs(theSameRank) == allCards)&&(abs(theSameColor)==allCards)&&(abs(theSameShading)==allCards)&&(abs(theSameSuit)==allCards)){
        score=1;
    }
    
    return score*otherCards.count;
    
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
    return @[@"0,0",@"0,5",@"1,0"];
}
@end
