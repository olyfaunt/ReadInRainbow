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
#import "Util.h"

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
@property (nonatomic) UIVisualEffectView *blurEffectView;
@property (nonatomic, assign) BOOL soundHasPlayed;

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
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    self.view.autoresizesSubviews = YES;
    [self setUpBlurView];
    [self setUpSoundAndColorAndChoices];
    [self setUpGameSounds];
    self.livesImageView.image = [UIImage imageNamed:@"heart4"];
    self.lives = 4;
    self.gameOverButton.hidden = YES;
    self.soundHasPlayed = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        // orientation is landscape
        NSLog(@"init to wide");
        [self doSameAdjust:true size:self.view.frame.size];
//        [self setUpBlurView];
        
    }  else {
        // orientation is portrait
        NSLog(@"init to tall");
        [self doSameAdjust:false size:self.view.frame.size];
//        [self setUpBlurView];
    }
}

- (void)grayButtons {
    self.answerOptionOne.alpha = 0;
    self.answerOptionOne.layer.masksToBounds = YES;
    self.answerOptionOne.layer.cornerRadius = 10;
    self.answerOptionTwo.alpha = 0;
    self.answerOptionTwo.layer.masksToBounds = YES;
    self.answerOptionTwo.layer.cornerRadius = 10;
    self.answerOptionThree.alpha = 0;
    self.answerOptionThree.layer.masksToBounds = YES;
    self.answerOptionThree.layer.cornerRadius = 10;
}

- (void)showOptionButtons {
    [UIView transitionWithView:self.answerOptionOne duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.answerOptionOne.alpha = 1;
                    }completion:nil];
    [UIView transitionWithView:self.answerOptionTwo duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.answerOptionTwo.alpha = 1;
                    }completion:nil];
    [UIView transitionWithView:self.answerOptionThree duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.answerOptionThree.alpha = 1;
                    }completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSoundAndColorAndChoices {
    self.hasCorrectAnswer = NO;
    self.nextQuestionButton.hidden = YES;
    self.soundIndex = arc4random_uniform((uint32_t)self.soundsArray.count);
    Sound *correctSound = self.soundsArray[self.soundIndex];
    self.correctAnswerIdentifier = correctSound.identifier;
    int correctButton = arc4random_uniform(NumberOfButtons);
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
    [self grayButtons];
    self.isCorrectImageView.image = nil;
}

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
    return arc4random_uniform((uint32_t)self.soundsArray.count);
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
        [self showSmileyFace];
    } else {
        [self showSadFace];
    }
}

- (IBAction)answerOptionTwoPressed:(id)sender {
    if([self.answerTwoIdentifier isEqualToString:self.correctAnswerIdentifier]){
        [self showSmileyFace];
    } else {
        [self showSadFace];
    }
}

- (IBAction)answerOptionThreePressed:(id)sender {
    if([self.answerThreeIdentifier isEqualToString:self.correctAnswerIdentifier]){
        [self showSmileyFace];
    } else {
        [self showSadFace];
    }
}

-(void)showGameOver {
    [self.view addSubview:self.blurEffectView];
    
    self.lives = 4;
    [self.gameOverButton setNeedsDisplay];
    [self.view bringSubviewToFront:self.gameOverButton];
    self.gameOverButton.alpha = 0;
    self.gameOverButton.hidden = NO;
    [UIView transitionWithView:nil duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.gameOverButton.alpha = 1;
    }completion:^(BOOL finished) {
        [self.gameOverButton setNeedsDisplay];
    }];
    
}

-(void) setHeartImage {
    NSString *heartImageString = [NSString stringWithFormat:@"heart%d",self.lives];
    UIImage *heartImage = [UIImage imageNamed:heartImageString];
    [UIView transitionWithView:self.livesImageView
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        self.livesImageView.image = heartImage;
                    } completion:^(BOOL finished) {
                        [self.livesImageView setNeedsDisplay];
                    }];
}

-(void) showSmileyFace {
    [self playCurrentSound:self];
    self.hasCorrectAnswer = YES;
    UIImage *smileImage = [UIImage imageNamed:@"smiling36"];
    [UIView transitionWithView:self.isCorrectImageView
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.isCorrectImageView.image = smileImage;
                    } completion:^(BOOL finished) {
                        [self.isCorrectImageView setNeedsDisplay];
                    }];
    self.nextQuestionButton.alpha = 0;
    self.nextQuestionButton.hidden = NO;
    [UIView transitionWithView:nil duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
        self.nextQuestionButton.alpha = 1;
    }completion:^(BOOL finished) {
        [self.nextQuestionButton setNeedsDisplay];
    }];
}

-(void) showSadFace {
    UIImage *sadImage = [UIImage imageNamed:@"sad39"];
    [UIView transitionWithView:self.isCorrectImageView
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.isCorrectImageView.image = sadImage;
                    } completion:^(BOOL finished) {
                        [self.isCorrectImageView setNeedsDisplay];
                    }];
    self.lives--;
    [self setHeartImage];
    if(self.lives == 0){
        [self.gameOverPlayer play];
        [self showGameOver];
    } else {
        [self.losePlayer play];
    }
}

- (IBAction)playCurrentSound:(id)sender {
//    NSLog(@"width: %f, height: %f", self.view.frame.size.width, self.view.frame.size.height);
//    return;
    
    Sound *myCurrentSound = [[SoundLibrary sharedLibrary] soundLibrary][self.correctAnswerIdentifier];
    NSError *error;
    self.soundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:myCurrentSound.soundURL error:&error];
    self.soundPlayer.volume=1.0f;
    [self.soundPlayer prepareToPlay];
    self.soundPlayer.numberOfLoops=0; //or more if needed
    [self.soundPlayer play];
    [self showOptionButtons];
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
    [self.gameOverPlayer stop];
    [self.blurEffectView removeFromSuperview];
    self.gameOverButton.hidden = YES;
    [self setHeartImage];
    [self setUpSoundAndColorAndChoices];
}

-(void)setUpGameSounds {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"GameOver" withExtension:@"wav"];
    self.gameOverPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.gameOverPlayer.numberOfLoops = 0;
    [self.gameOverPlayer prepareToPlay];
    
    NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"Lose" withExtension:@"wav"];
    self.losePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    self.losePlayer.numberOfLoops = 0;
    [self.losePlayer prepareToPlay];
    
//    NSURL *url3 = [[NSBundle mainBundle] URLForResource:@"Win" withExtension:@"wav"];
//    self.winPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url3 error:nil];
//    self.winPlayer.numberOfLoops = 0;
//    [self.winPlayer prepareToPlay];
    
}

-(void)setUpBlurView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    [self.blurEffectView setFrame:self.view.frame];
    self.blurEffectView.frame = self.view.bounds;
    NSLog(@"bounds: %f, frame: %f", self.view.bounds.size.width, self.view.frame.size.height);
}


#pragma mark - Rotation Constraints

//delegate - rotate
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"transition to :%f and heigh %f",size.width, size.height);
    BOOL transitionToWide = size.width > size.height;
    if (transitionToWide){
        NSLog(@"rotate to wide");
//        [self.blurEffectView sizeToFit];
        [self doSameAdjust:true size:size];
    }
    else {
        NSLog(@"rotate to tall");
//        [self.blurEffectView sizeToFit];
        [self doSameAdjust:false size:size];
    }
}

-(void)doSameAdjust:(BOOL)isWide size:(CGSize)size
{
    if (isWide){
        self.livesImageViewToBottom.constant = 40;
        self.colorBlock1ToBottom.constant = 240;
        self.colorBlock2ToBottom.constant = 240;
        self.colorBlock3ToBottom.constant = 240;
        [self.view setNeedsUpdateConstraints];
//        [self.blurEffectView setFrame:CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
//    self.blurEffectView.frame = self.view.bounds;
        NSLog(@"isWide boundsWidth: %f", self.view.bounds.size.width);

        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
//            self.blurEffectView.frame = self.view.bounds;
        } completion:nil];
    }
    else {
        self.livesImageViewToBottom.constant = 180;
        self.colorBlock1ToBottom.constant = 420;
        self.colorBlock2ToBottom.constant = 420;
        self.colorBlock3ToBottom.constant = 420;
        [self.view setNeedsUpdateConstraints];
//        self.blurEffectView.frame = self.view.bounds;
//        [self.blurEffectView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        NSLog(@"isNOTWide boundsWidth: %f", self.view.bounds.size.width);
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
//            self.blurEffectView.frame = self.view.bounds;
        }];
    }
    NSLog(@"width: %f, height: %f", self.view.frame.size.width, self.view.frame.size.height);
    [self.blurEffectView setFrame:CGRectMake(0, 0, size.width, size.height)];
}



- (IBAction)playMovie:(id)sender {
    if (!self.moviePlayer) {
        self.moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gameone480" ofType:@"mov"]]];
    }
    [self presentViewController:self.moviePlayer animated:NO completion:^{
        [self.moviePlayer.moviePlayer play];
    }];
}
@end
