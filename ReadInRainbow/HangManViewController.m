//
//  HangManViewController.m
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-21.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "HangManViewController.h"
#import "Word.h"
#import "Phoneme.h"
#import "UIButton+setTag.h"
#import "WordLibrary.h"
#import "Sound.h"
#import "SoundLibrary.h"
#import "ChartCell.h"
#import "ColorBlockView.h"
#import "Util.h"

const int numberOfChoices = 47; //number of sounds
const int numberOfLives = 8;

@interface HangManViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *heart1;
@property (weak, nonatomic) IBOutlet UIImageView *heart2;
@property (weak, nonatomic) IBOutlet UIButton *gameOverButton;

@property (weak, nonatomic) IBOutlet UICollectionView *colorPickerCollectionView;

@property (nonatomic, strong) NSMutableArray * buttonsArray;
@property (nonatomic, strong) Word * currentWord;
@property (nonatomic, strong) NSArray * collectionViewOptions;
@property (nonatomic, assign) int lives;

- (IBAction)newGamePressed:(id)sender;

@end

@implementation HangManViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAndGetReadyToPlay];
    [self setUpCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setUpAndGetReadyToPlay {
    [self generateAndDisplayWord];
    [self makeOptionsForCollectionView];
    [self setLivesWithDisplay:numberOfLives];
    self.gameOverButton.hidden = YES;
}

- (void)setLivesWithDisplay:(int)lives {
    if(lives >= 4){
        self.heart1.image = [UIImage imageNamed:@"heart4"];
        self.heart2.image = [UIImage imageNamed:[NSString stringWithFormat:@"heart%d", (lives-4)]];
    } else {
        self.heart2.image = nil;
        self.heart1.image = [UIImage imageNamed:[NSString stringWithFormat:@"heart%d", lives]];
    }
    self.lives = lives;
}

- (void)setUpCollectionView {
    self.colorPickerCollectionView.delegate = self;
    self.colorPickerCollectionView.dataSource = self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return numberOfChoices;
}

- (void)makeOptionsForCollectionView {
    NSMutableArray * shufflingArray = [self.collectionViewOptions mutableCopy];
    NSUInteger count = [shufflingArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [shufflingArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    self.collectionViewOptions = shufflingArray;
}

-(ChartCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChartCell * newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Sound * soundForCell = self.collectionViewOptions[indexPath.item];
    newCell.colourView.firstColor = soundForCell.soundColor;
    if(soundForCell.hasSecondaryColor) {
        newCell.colourView.secondColor = soundForCell.secondaryColor;
    } else {
        newCell.colourView.secondColor = nil;
    }
    return newCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Sound * soundAtCell = self.collectionViewOptions[indexPath.item];
    if([self isSoundInWord:soundAtCell]){
        [self lightUpPhonemeInWordForSound:soundAtCell];
    } else {
        [self loseOneLife];
    }
}

-(BOOL)isSoundInWord:(Sound *)sound {
    for(Phoneme * currentPhoneme in self.currentWord.phonemeArray){
        if([currentPhoneme.soundIdentifier isEqualToString:sound.identifier]) {
            return YES;
        }
    }
    return NO;
}

-(void)lightUpPhonemeInWordForSound:(Sound *)sound {
    for(UIButton * currentButton in self.buttonsArray){
        if([currentButton.tagString isEqualToString:sound.identifier]){
            NSAttributedString * attributedTitle;
            if(sound.hasSecondaryColor){
                /////// boldSystemFontOfSize:FontSize]
                attributedTitle = [[NSAttributedString alloc] initWithString:currentButton.tagString attributes:@{
                                                                                                    NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],
                                                                                                    NSForegroundColorAttributeName:sound.soundColor,
                                                                                                    NSStrokeWidthAttributeName:[NSNumber numberWithFloat:StrokeWidth],
                                                                                                    NSStrokeColorAttributeName:sound.secondaryColor
                                                                                                    }];
            } else {
                attributedTitle = [[NSAttributedString alloc] initWithString:currentButton.tagString attributes:@{
                                                                                                    NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],NSForegroundColorAttributeName:sound.soundColor}];
            }
            
            [currentButton setTitle:nil forState:UIControlStateNormal];
            [currentButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
        }
    }
}

-(void)loseOneLife {
    if(self.lives > 1){
        [self setLivesWithDisplay:(self.lives - 1)];
    } else {
        [self gameOver];
    }
}

- (void)gameOver {
    [self.gameOverButton setNeedsDisplay];
    self.gameOverButton.alpha = 0;
    self.gameOverButton.hidden = NO;
    [UIView transitionWithView:nil duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.gameOverButton.alpha = 1;
    }completion:^(BOOL finished) {
        [self.gameOverButton setNeedsDisplay];
    }];
}

- (void)generateAndDisplayWord {
    NSArray * wordArray = [[WordLibrary sharedLibrary] allValues];
    self.currentWord = wordArray[arc4random_uniform(wordArray.count)];
    [self createButtonForWord:self.currentWord];
}

-(void) createButtonForWord:(Word*)word {
    UIButton *lastButton;
    for (Phoneme *phoneme in word.phonemeArray) {
        UIButton *justMadeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [justMadeButton setTagString:phoneme.soundIdentifier];
        [justMadeButton setTitle:phoneme.letters forState:UIControlStateNormal];
        if (lastButton ==nil) {
            //first button/phoneme of the word is placed at X half of the word's width leftwards from half of the screen's width (so the word is centered) - its Y is at half of the frame's height minus half of the phoneme's stringSize height
            [justMadeButton setFrame:CGRectMake(self.view.frame.size.width/2-word.stringSize.width/2,self.view.frame.size.height/2-(phoneme.stringSize.height/2),phoneme.stringSize.width, phoneme.stringSize.height)];
        } else {
            //each consecutive button after the first button is placed just after it
            [justMadeButton setFrame:CGRectMake(lastButton.center.x+lastButton.frame.size.width/2,self.view.frame.size.height/2-(phoneme.stringSize.height/2),phoneme.stringSize.width, phoneme.stringSize.height)];
        }
        [justMadeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArray addObject:justMadeButton];
        [self.view addSubview:justMadeButton];
        lastButton = justMadeButton;
    }
}

- (IBAction)newGamePressed:(id)sender {
    self.gameOverButton.hidden = YES;
    [self setUpAndGetReadyToPlay];
}

@end
