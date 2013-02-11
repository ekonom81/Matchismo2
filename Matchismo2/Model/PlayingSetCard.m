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
