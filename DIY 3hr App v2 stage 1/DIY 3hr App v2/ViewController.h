//
//  ViewController.h
//  DIY 3hr App v2
//
//  Created by Aditya Narayan on 11/21/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface ViewController : UIViewController{
    
    
    int questionNumber;
    NSString * picFileName;
    int score;
    NSArray * photoList ;
    NSArray * answerList;
    BOOL userSaysNYC;
    BOOL answeredCorrectly;
    BOOL gameOver;
    int totalPhotos;
    SystemSoundID soundIDApplause, soundIDOO;

    
}

@property (retain, nonatomic) IBOutlet UIImageView *imageHolder;

@property (retain, nonatomic) IBOutlet UISegmentedControl *answerSelector;

@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;

@property (retain, nonatomic) IBOutlet UILabel *gameOverMessage;

- (IBAction)answerSelected:(id)sender;

@end
