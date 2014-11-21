//
//  Game2ViewController.m
//  ReadInRainbow
//
//  Created by Elia Kauffman on 2014-11-19.
//  Copyright (c) 2014 ajek. All rights reserved.
//

#import "Game2ViewController.h"
#import "Word.h"
#import "Phoneme.h"
#import "Sound.h"
#import "SoundLibrary.h"
#import "ColorBlockView.h"
#import "UIButton+setTag.h"
#import "AppDelegate.h"

const int numberOfButtons = 3;

@interface Game2ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *isCorrectImageView;
@property (weak, nonatomic) IBOutlet ColorBlockView *answerOptionOne;
@property (nonatomic, strong) NSString * answerOneIdentifier;
@property (weak, nonatomic) IBOutlet ColorBlockView *answerOptionTwo;
@property (nonatomic, strong) NSString * answerTwoIdentifier;
@property (weak, nonatomic) IBOutlet ColorBlockView *answerOptionThree;
@property (nonatomic, strong) NSString * answerThreeIdentifier;
@property (nonatomic, strong) NSString * correctAnswerIdentifier;
@property (weak, nonatomic) IBOutlet UIButton *nextQuestionButton;
@property (nonatomic, assign) BOOL hasCorrectAnswer;
@property (nonatomic, assign) int lives;
@property (nonatomic, assign) int soundIndex;
@property (nonatomic, assign) int soundIndexTwo;

- (IBAction)answerOptionOnePressed:(id)sender;
- (IBAction)answerOptionTwoPressed:(id)sender;
- (IBAction)answerOptionThreePressed:(id)sender;

- (IBAction)playCurrentSound:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;

- (IBAction)returnToMenu:(id)sender;

@end

@implementation Game2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSoundAndColorAndChoices];
    self.livesImageView.image = [UIImage imageNamed:@"heart4"];
    self.lives = 4;
    self.gameOverButton.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSoundAndColorAndChoices {
    self.hasCorrectAnswer = NO;
    self.nextQuestionButton.hidden = YES;
    self.soundIndex = arc4random_uniform(self.soundsArray.count);
    Sound * correctSound = self.soundsArray[self.soundIndex];
    self.correctAnswerIdentifier = correctSound.identifier;
    int correctButton = arc4random_uniform(numberOfButtons);
    switch(correctButton){
        case 0:{
            [self setViewColorsWithSoundOnView:self.answerOptionOne andSound:correctSound];
            self.answerOneIdentifier = correctSound.identifier;
            
            self.soundIndexTwo = [self getRandomArrayIndexButNotThis:self.soundIndex];
            Sound *decoySoundOne = self.soundsArray[self.soundIndexTwo];
            [self setViewColorsWithSoundOnView:self.answerOptionTwo andSound:decoySoundOne];
            self.answerTwoIdentifier = decoySoundOne.identifier;
            
            Sound *decoySoundTwo = self.soundsArray[[self getRandomArrayIndexButNotThis:self.soundIndex orThis:self.soundIndexTwo]];
            [self setViewColorsWithSoundOnView:self.answerOptionThree andSound:decoySoundTwo];
            self.answerThreeIdentifier = decoySoundTwo.identifier;
            
            break;
        }
        case 1:{
            [self setViewColorsWithSoundOnView:self.answerOptionTwo andSound:correctSound];
            self.answerTwoIdentifier = correctSound.identifier;
            
            self.soundIndexTwo = [self getRandomArrayIndexButNotThis:self.soundIndex];
            Sound *decoySoundOne = self.soundsArray[self.soundIndexTwo];
            [self setViewColorsWithSoundOnView:self.answerOptionOne andSound:decoySoundOne];
            self.answerOneIdentifier = decoySoundOne.identifier;
            
            Sound *decoySoundTwo = self.soundsArray[[self getRandomArrayIndexButNotThis:self.soundIndex orThis:self.soundIndexTwo]];
            [self setViewColorsWithSoundOnView:self.answerOptionThree andSound:decoySoundTwo];
            self.answerThreeIdentifier = decoySoundTwo.identifier;
            
            break;
        }
        case 2:{
            [self setViewColorsWithSoundOnView:self.answerOptionThree andSound:correctSound];
            self.answerThreeIdentifier = correctSound.identifier;
            
            self.soundIndexTwo = [self getRandomArrayIndexButNotThis:self.soundIndex];
            Sound *decoySoundOne = self.soundsArray[self.soundIndexTwo];
            [self setViewColorsWithSoundOnView:self.answerOptionTwo andSound:decoySoundOne];
            self.answerTwoIdentifier = decoySoundOne.identifier;
            
            Sound *decoySoundTwo = self.soundsArray[[self getRandomArrayIndexButNotThis:self.soundIndex orThis:self.soundIndexTwo]];
            [self setViewColorsWithSoundOnView:self.answerOptionOne andSound:decoySoundTwo];
            self.answerOneIdentifier = decoySoundTwo.identifier;
            
            break;
        }
    }
    
    self.isCorrectImageView.image = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setViewColorsWithSoundOnView:(ColorBlockView *)view andSound:(Sound *)sound {
    if(sound.hasSecondaryColor){
        view.firstColor = sound.soundColor;
        view.secondColor = sound.secondaryColor;
    } else {
        view.firstColor = sound.soundColor;
        view.secondColor = nil;
    }
    [view setNeedsDisplay];
}

- (int)getRandomArrayIndex {
    return arc4random_uniform(self.soundsArray.count);
}

- (int)getRandomArrayIndexButNotThis:(int)number {
    int returnvalue;
    do {
        returnvalue = [self getRandomArrayIndex];
    } while(returnvalue == number);
    return returnvalue;
}

- (int)getRandomArrayIndexButNotThis:(int)number orThis:(int)number2 {
    int returnvalue;
    do {
        returnvalue = [self getRandomArrayIndex];
    } while(returnvalue == number||returnvalue == number2);
    return returnvalue;
}

- (IBAction)answerOptionOnePressed:(id)sender {
    if([self.answerOneIdentifier isEqualToString:self.correctAnswerIdentifier]){
        self.isCorrectImageView.image = [UIImage imageNamed:@"smiling36"];
        self.hasCorrectAnswer = YES;
        self.nextQuestionButton.hidden = NO;
    } else {
        self.isCorrectImageView.image = [UIImage imageNamed:@"sad39"];
        
        
        self.lives--;
        [self setHeartImage];
        if(self.lives == 0){
            [self showGameOver];
        }
    }
}

- (IBAction)answerOptionTwoPressed:(id)sender {
    if([self.answerTwoIdentifier isEqualToString:self.correctAnswerIdentifier]){
        self.isCorrectImageView.image = [UIImage imageNamed:@"smiling36"];
        self.hasCorrectAnswer = YES;
        self.nextQuestionButton.hidden = NO;
    } else {
        self.isCorrectImageView.image = [UIImage imageNamed:@"sad39"];
        self.lives--;
        [self setHeartImage];
        if(self.lives == 0){
            [self showGameOver];
        }
    }
}

- (IBAction)answerOptionThreePressed:(id)sender {
    if([self.answerThreeIdentifier isEqualToString:self.correctAnswerIdentifier]){
        self.isCorrectImageView.image = [UIImage imageNamed:@"smiling36"];
        self.hasCorrectAnswer = YES;
        self.nextQuestionButton.hidden = NO;
    } else {
        self.isCorrectImageView.image = [UIImage imageNamed:@"sad39"];
        self.lives--;
        [self setHeartImage];
        if(self.lives == 0){
            [self showGameOver];
        }
    }
}

-(void)showGameOver {
    self.gameOverButton.hidden = NO;
    self.lives = 4;
    [self.gameOverButton setNeedsDisplay];
}

-(void) setHeartImage {
    NSString *heartImage = [NSString stringWithFormat:@"heart%d",self.lives];
    self.livesImageView.image = [UIImage imageNamed:heartImage];
    [self.livesImageView setNeedsDisplay];
}

- (IBAction)playCurrentSound:(id)sender {
    [[[SoundLibrary sharedLibrary] soundLibrary][self.correctAnswerIdentifier] playSound];
}

- (IBAction)nextButtonPressed:(id)sender {
    if(self.hasCorrectAnswer){
        [self setUpSoundAndColorAndChoices];
    }
}

- (IBAction)returnToMenu:(id)sender {
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

- (IBAction)gameOver:(id)sender {
    self.gameOverButton.hidden = YES;
    [self setHeartImage];
    [self setUpSoundAndColorAndChoices];
}
@end
