//
//  ConcentrationGame.m
//  GVTraining03
//
//  Created by Cassiano Monteiro on 10/06/16.
//  Copyright © 2016 Guichê Virtual. All rights reserved.
//

#import "ConcentrationGame.h"

@interface ConcentrationGame()

@property (nonatomic, strong) NSMutableArray<Card *> *cards;
@property (nonatomic, strong) NSMutableArray<Card *> *scoredCards;
@property (nonatomic, strong) Card *firstCard;
@property (nonatomic, strong) NSNumber *score;
@end

@implementation ConcentrationGame

- (instancetype)initWithCardsCount:(NSUInteger)cardsCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        
        self.score = @0;
        self.scoredCards = [NSMutableArray arrayWithCapacity:cardsCount];
        self.cards = [NSMutableArray arrayWithCapacity:cardsCount];
        
        for (NSUInteger i = 0; i < (cardsCount/2); i++) {
            Card *card = [deck drawCard];
            [self.cards addObject:card];
            
            // Adicionamos uma cópia para que sejam instâncias diferentes na memória.
            [self.cards addObject:[card copy]];
            [self shuffle: self.cards];
            
        }
        
    }
    return self;
}

- (void)pickCard:(Card *)card
{
    if (!self.firstCard) {
        self.firstCard = card;
        [self.delegate showCard:card];
    }
    else {
        
        [self.delegate showCard:card];
        
        NSInteger score = [self.firstCard matchCard:card];
        
        
        if (score > 0) {
            self.score = @(self.score.integerValue + [self.firstCard calculateScore:card]);
            [self.scoredCards addObject:card];
            [self.scoredCards addObject:self.firstCard];
            [self.delegate disableCard1:self.firstCard andCard2:card];
        }
        else {
            [self.delegate hideCard:card];
            [self.delegate hideCard:self.firstCard];
        }
        
        [self.delegate showScore:self.score];
        self.firstCard = nil;
    }
}

- (BOOL)shouldPickCard:(Card *)card
{
    return ![self.scoredCards containsObject:card] && card != self.firstCard;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return [self.cards objectAtIndex:index];
}

- (NSUInteger)indexOfCard:(Card *)card
{
    return [self.cards indexOfObject:card];
}

-(void)shuffle:(NSMutableArray<Card *> *)cards
{
    NSInteger count = [cards count];
    for (NSInteger i = 0; i < count - 1; ++i) {
        NSInteger range = count - i;
        NSInteger index = i + arc4random_uniform((u_int32_t) range);
        [cards exchangeObjectAtIndex:i withObjectAtIndex:index];
    }
}

@end
