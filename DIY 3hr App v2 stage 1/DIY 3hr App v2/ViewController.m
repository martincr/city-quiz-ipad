//
//  ViewController.m
//  DIY 3hr App v2
//
//  Created by Aditya Narayan on 11/21/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    
    
    [super viewDidLoad];
    
    int TOTAL_PHOTOS = 11;
    
    photoList =  [@[@"0.jpg",   @"1.jpg",   @"2.jpg",   @"3.jpg",   @"4.jpg",   @"5.jpg",   @"6.jpg",   @"7.jpg",   @"8.jpg",   @"9.jpg",   @"10.jpg"] retain];
    
    answerList = [@[@NO,        @YES,       @YES,       @YES,       @YES,       @YES,       @YES,       @YES,       @YES,       @NO,        @NO ] retain];
    
    questionNumber = 0; totalPhotos = TOTAL_PHOTOS;
    
    //Audio setup
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *soundPathApplause = [bundle pathForResource:@"applause" ofType:@"wav"];
    NSString *soundPathOO =  [bundle pathForResource:@"uh-oh" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:soundPathApplause], &soundIDApplause);
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:soundPathOO], &soundIDOO);

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageHolder release];

    [_answerSelector release];
    [_scoreLabel release];
    [_gameOverMessage release];
    [super dealloc];
}


// This block of code is called each time a user selects an answer

- (IBAction)answerSelected:(UISegmentedControl *)answerSelectorControl {
    
    //1. Get the correct answer for the question ( from answerList above)
    BOOL correctAnswerForQuestion = [answerList[questionNumber] boolValue];
    
    //2. Get the user's selection from UI (0 for NYC, 1 for Not in NYC)
    int selectedSegment = answerSelectorControl.selectedSegmentIndex;
    
    //3. Convert from a 0/1 to YES/NO
    if (selectedSegment == 0)  userSaysNYC = NO;    else  userSaysNYC = YES;
    
    //4.Compare with correct answer
    if (userSaysNYC == correctAnswerForQuestion) answeredCorrectly = TRUE;
    else answeredCorrectly = FALSE;
    
    //5. If answer is OK, add +1 to score, update score on screen, and applause!
    if (answeredCorrectly == YES) {
        
        score = score + 1;
        
        //Update score on screen
        self.scoreLabel.text = [NSString stringWithFormat:@"%d",score ];
        
        //Applause!
        AudioServicesPlaySystemSound(soundIDApplause);
        
    }// 6. Answer not correct
    else {
        AudioServicesPlaySystemSound(soundIDOO);
    }
    
    //7. Check if game over
    
    if (questionNumber == (totalPhotos-1))    gameOver = TRUE;
    
    //8. Show next photo if game is not over
    if (!gameOver) {
        
        
        //9. Game still on.
        //Change question number to the next one
        
        questionNumber = questionNumber + 1;
        
        //10. Get name of next photograph
        picFileName = [NSString stringWithFormat:@"%d.jpg",questionNumber ];
        
        //11. Load next photo
        self.imageHolder.image = [UIImage imageNamed:picFileName];
        
    } else {
        //12. Gamve over. Show message and disable answer selector.
        self.gameOverMessage.hidden = FALSE;
        self.answerSelector.enabled = FALSE;
    }
}



@end
