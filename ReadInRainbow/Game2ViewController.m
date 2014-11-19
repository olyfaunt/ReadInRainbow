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

@interface Game2ViewController ()

@property (weak, nonatomic) IBOutlet UIView *WordView;

@end

@implementation Game2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    Word * theWord = [[Word alloc] initWithPhonemeArray:@[[Phoneme phonemeWithLetters:@"d" andSoundIdentifier:@"d"], [Phoneme phonemeWithLetters:@"ay" andSoundIdentifier:@"longa"]]];
//    for(Phoneme * currentPhoneme in theWord.phonemeArray){
//        Sound * phonemeSound = [[SoundLibrary sharedLibrary] soundLibrary][currentPhoneme.soundIdentifier];
//        UIButton * newButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        newButton.translatesAutoresizingMaskIntoConstraints = NO;
//        [newButton setAttributedTitle:[currentPhoneme buildAttributedString] forState:UIControlStateNormal];
//        [newButton sizeToFit];
//        newButton.center = CGPointMake(100, 100);
//        [self.view addSubview:newButton];
//    }
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

@end
