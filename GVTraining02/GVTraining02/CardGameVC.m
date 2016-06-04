//
//  CardGameVC.m
//  GVTraining02
//
//  Created by Cassiano Monteiro on 03/06/16.
//  Copyright © 2016 Guichê Virtual. All rights reserved.
//

#import "CardGameVC.h"
#import "PokerDeck.h"

@interface CardGameVC ()
@property (nonatomic, assign) NSUInteger flipsCount;

@end

@implementation CardGameVC

// Override no setter para atualizar a tela toda vez que a propriedade é alterada.
- (void)setFlipsCount:(NSUInteger)flipsCount
{
    _flipsCount = flipsCount;
    self.flipsCounter.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
}

// Ação executada quando a carta é clicada
- (IBAction)cardTapped:(UIButton *)sender
{
    UIImage *cardImage;
    NSString *cardText;
    
    // Este IF verifica se o currentTitle não é nulo
    if (!sender.currentTitle) {
        // O nome da imagem vem do conjunto de Assets do projeto.
        // NÃO é o nome do arquivo, mas sim do asset.
        cardImage = [UIImage imageNamed:@"cardfront"];
        PokerDeck *a = [[PokerDeck alloc] init];
        cardText = [a drawCard].contents;
    }
    else {
        cardImage = [UIImage imageNamed:@"cardback"];
    }
    
    [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
    [sender setTitle:cardText forState:UIControlStateNormal];
    
    if (_card.currentTitle && _card2.currentTitle) {
        NSString *rank1 = [_card.currentTitle substringToIndex:1];
        NSString *suit1 = [_card.currentTitle substringFromIndex:1];
        
        NSString *rank2 = [_card2.currentTitle substringToIndex:1];
        NSString *suit2 = [_card2.currentTitle substringFromIndex:1];
        
        NSInteger score = 0;
        if ([rank1 isEqualToString:rank2]) {
            score += 2;
        }
        
        if ([suit1 isEqualToString:suit2]) {
            score += 1;
        }
    
        self.score.text = [NSString stringWithFormat:@"Score: %d", score];
    } else {
        self.score.text = @"Turn the card!";
    }
    
    self.flipsCount++;
}

@end
