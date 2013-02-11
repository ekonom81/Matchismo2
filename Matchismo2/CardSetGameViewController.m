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

#define GAME_MODE 3 //match 3 cards

@interface CardSetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong,nonatomic) CardMatchingGame *game;
@end

@implementation CardSetGameViewController


-(CardMatchingGame *)game
{
    if(!_game)_game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                        usingDeck:[[PlayingSetCardDeck alloc]init]
                                                         gameMode:GAME_MODE];
    
    return _game;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
