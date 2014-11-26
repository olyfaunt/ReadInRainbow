//
//  HangManViewController.m
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-21.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "HangmanViewController.h"
#import "Word.h"
#import "Phoneme.h"
#import "UIButton+setTag.h"
#import "WordLibrary.h"
#import "Sound.h"
#import "SoundLibrary.h"
#import "ChartCell.h"
#import "ColorBlockView.h"
#import "Util.h"
#import "AppDelegate.h"

const int numberOfChoices = 9; //number of sounds
const int numberOfLives = 8;

@interface HangmanViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *heart1;
@property (weak, nonatomic) IBOutlet UIImageView *heart2;
@property (weak, nonatomic) IBOutlet UIButton *gameOverButton;

@property (weak, nonatomic) IBOutlet UICollectionView *colorPickerCollectionView;

@property (nonatomic, strong) NSMutableArray * buttonsArray;
@property (nonatomic, strong) Word * currentWord;
@property (nonatomic, strong) NSArray * collectionViewOptions;
@property (nonatomic, assign) int lives;
@property (nonatomic) AVAudioPlayer *soundPlayer;
@property (weak, nonatomic) IBOutlet UIButton *nextWordButton;
@property (assign) int NumberOfChoices;
@property (nonatomic, assign) int placeInPhonemeArray;

- (IBAction)newGamePressed:(id)sender;
- (IBAction)playWordPressed:(id)sender;
- (IBAction)nextWordButtonPressed:(id)sender;
- (IBAction)goToMenu:(id)sender;

@end

@implementation HangmanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.buttonsArray = [[NSMutableArray alloc] init];
    [self setUpAndGetReadyToPlay];
    [self setLivesWithDisplay:numberOfLives];
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
    [self removeWordButtons];
    [self generateAndDisplayWord];
    [self makeOptionsForCollectionView];
    self.gameOverButton.hidden = YES;
    self.placeInPhonemeArray = 0;
    self.nextWordButton.hidden = YES;
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
    return self.NumberOfChoices;
}

- (void)makeOptionsForCollectionView {
    NSMutableArray *sourceArray = [[[[SoundLibrary sharedLibrary] soundLibrary] allValues] mutableCopy];
    NSMutableArray *shufflingArray = [[NSMutableArray alloc] init];
    for(Phoneme *currentPhoneme in self.currentWord.phonemeArray){
        Sound *currentSound = [[[SoundLibrary sharedLibrary] soundLibrary] objectForKey:currentPhoneme.soundIdentifier];
        [sourceArray removeObject:currentSound];
        [shufflingArray addObject:currentSound];
    }
//    int numberOfObjectsToAdd = (u_int32_t)(numberOfChoices - shufflingArray.count);
    int numberOfObjectsToAdd = 2;
    self.NumberOfChoices = (u_int32_t)(numberOfObjectsToAdd + shufflingArray.count);
    for(int i=0;i<numberOfObjectsToAdd;i++){
        int targetValue = arc4random_uniform((u_int32_t)sourceArray.count);
        [shufflingArray addObject:sourceArray[targetValue]];
        [sourceArray removeObjectAtIndex:targetValue];
    }
    NSUInteger count = [shufflingArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t)remainingCount);
        [shufflingArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    self.collectionViewOptions = shufflingArray;
    [self.colorPickerCollectionView reloadData];
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
    [newCell.colourView setNeedsDisplay]; // may or may not be the problem
    return newCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Sound * soundAtCell = self.collectionViewOptions[indexPath.item];
    NSError * error = nil;
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundAtCell.soundURL error:&error];
    self.soundPlayer.volume=1.0f;
    [self.soundPlayer prepareToPlay];
    self.soundPlayer.numberOfLoops=0; //or more if needed
    [self.soundPlayer play];
    if(self.placeInPhonemeArray >= self.currentWord.phonemeArray.count) {
        // do nothing
    } else if([[self.currentWord.phonemeArray[self.placeInPhonemeArray] soundIdentifier] isEqualToString:soundAtCell.identifier]){
        [self lightUpPhonemeInWordForSound:soundAtCell];
        self.placeInPhonemeArray++;
        if(self.placeInPhonemeArray >= self.currentWord.phonemeArray.count){
            [self displayNextWordButton];
        }
    } else {
        [self loseOneLife];
    }
}

-(void)displayNextWordButton {
    [self.nextWordButton setNeedsDisplay];
    self.nextWordButton.alpha = 0;
    [self.view bringSubviewToFront:self.nextWordButton];
    self.nextWordButton.hidden = NO;
    [UIView transitionWithView:nil duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.nextWordButton.alpha = 1;
    }completion:^(BOOL finished) {
        [self.nextWordButton setNeedsDisplay];
    }];
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
    UIButton * currentButton = self.buttonsArray[self.placeInPhonemeArray];
    if([currentButton.tagString isEqualToString:sound.identifier]){
        NSAttributedString * attributedTitle;
        if(sound.hasSecondaryColor){
            /////// boldSystemFontOfSize:FontSize]
            attributedTitle = [[NSAttributedString alloc] initWithString:currentButton.titleLabel.text attributes:@{
                                                                                                NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],
                                                                                                NSForegroundColorAttributeName:sound.soundColor,
                                                                                                NSStrokeWidthAttributeName:[NSNumber numberWithFloat:StrokeWidth],
                                                                                                NSStrokeColorAttributeName:sound.secondaryColor
                                                                                                }];
        } else {
            attributedTitle = [[NSAttributedString alloc] initWithString:currentButton.titleLabel.text attributes:@{
                                                                                                NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize],NSForegroundColorAttributeName:sound.soundColor}];
        }
        
        [currentButton setTitle:nil forState:UIControlStateNormal];
        [currentButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
        return;
    }
}

-(void)loseOneLife {
    [self setLivesWithDisplay:(self.lives - 1)];
    if(self.lives == 0){
        [self gameOver];
    }
}

- (void)gameOver {
    [self.gameOverButton setNeedsDisplay];
    self.gameOverButton.alpha = 0;
    [self.view bringSubviewToFront:self.gameOverButton];
    self.gameOverButton.hidden = NO;
    [UIView transitionWithView:nil duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.gameOverButton.alpha = 1;
    }completion:^(BOOL finished) {
        [self.gameOverButton setNeedsDisplay];
    }];
}

- (void)generateAndDisplayWord {
    NSArray * wordArray = [[[WordLibrary sharedLibrary] wordLibrary] allValues];
    self.currentWord = wordArray[arc4random_uniform((u_int32_t)wordArray.count)];
    [self createButtonForWord:self.currentWord];
}

-(void) createButtonForWord:(Word*)word {
    UIButton *lastButton;
    for (Phoneme *phoneme in word.phonemeArray) {
        UIButton *justMadeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [justMadeButton setTagString:phoneme.soundIdentifier];
        NSAttributedString * attributedTitle = [[NSAttributedString alloc] initWithString:phoneme.letters attributes:@{
                                                                                                                       NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:FontSize]}];
        [justMadeButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
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
    [self setLivesWithDisplay:numberOfLives];
    [self setUpAndGetReadyToPlay];
}

- (IBAction)playWordPressed:(id)sender {
    NSError * error = nil;
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.currentWord.soundURL error:&error];
    self.soundPlayer.volume=1.0f;
    [self.soundPlayer prepareToPlay];
    self.soundPlayer.numberOfLoops=0; //or more if needed
    [self.soundPlayer play];
}

- (IBAction)nextWordButtonPressed:(id)sender {
    [self setUpAndGetReadyToPlay];
}

- (IBAction)goToMenu:(id)sender {
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

- (void)removeWordButtons {
    for(UIButton * currentButton in self.buttonsArray){
        [currentButton removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
}

- (void)buttonClicked:(UIButton *)sender {
    Sound * theSound = [[[SoundLibrary sharedLibrary] soundLibrary] objectForKey:sender.tagString];
    NSError * error = nil;
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:theSound.soundURL error:&error];
    self.soundPlayer.volume=1.0f;
    [self.soundPlayer prepareToPlay];
    self.soundPlayer.numberOfLoops=0; //or more if needed
    [self.soundPlayer play];
}

@end
