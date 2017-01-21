//
//  ViewController.m
//  ObjCQuiz
//
//  Created by Hristijan Bocevski on 2017-01-18.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

#import "ViewController.h"
#import "Game.h"

@interface ViewController ()

// View
@property (weak, nonatomic) IBOutlet UILabel *lblNumQuestion;
@property (weak, nonatomic) IBOutlet UITextView *tvQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblRightWrong;
@property (weak, nonatomic) IBOutlet UIButton *btnAnswer1;
@property (weak, nonatomic) IBOutlet UIButton *btnAnswer2;
@property (weak, nonatomic) IBOutlet UIButton *btnAnswer3;
@property (weak, nonatomic) IBOutlet UIButton *btnAnswer4;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

// Model
@property (nonatomic) Game *game;
@property (nonatomic) Question *question;

// help methods
- (void) setAnswerRightOrWrong:(NSString*)answer;
- (void) updateViewWithQuestion;
- (void) checkShowScore;
- (void) hideUIElements:(BOOL)hide;
- (void) disableAnswerUIButtons:(BOOL)disable;
- (void) makeCoolUIElements;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create and init game
    self.game = [[Game alloc] init];
    [self.game createQuestions];
    
    // Show question
    [self updateViewWithQuestion];
    
    // Make buttons and text view look nice
    [self makeCoolUIElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickBtnAnswer:(id)sender {
    UIButton *btnAnswer = (UIButton*) sender;
    [self setAnswerRightOrWrong:btnAnswer.titleLabel.text];
    [self disableAnswerUIButtons:YES];
    [self checkShowScore];
}

- (IBAction)btnNext:(id)sender {
    // Enable answer buttons
    [self disableAnswerUIButtons:NO];
    
    // Show question
    [self updateViewWithQuestion];
    
    // If new game has started make changes to the UI
    if([self.btnNext.titleLabel.text isEqualToString:@"Nytt Spel"]){
        
        [self.btnNext setTitle:@"Nästa Fråga" forState:UIControlStateNormal];
        
        // show answer buttons and question num label
        [self hideUIElements:NO];
    }
}

- (void) updateViewWithQuestion{
    // Get Question
    Question *q = [self.game getQuestion];
    
    // Set question
    self.tvQuestion.text = q.text;
    // Set answer 1
    [self.btnAnswer1 setTitle:q.answers[0].text forState:UIControlStateNormal];
    // Set answer 2
    [self.btnAnswer2 setTitle:q.answers[1].text forState:UIControlStateNormal];
    // Set answer 3
    [self.btnAnswer3 setTitle:q.answers[2].text forState:UIControlStateNormal];
    // Set answer 4
    [self.btnAnswer4 setTitle:q.answers[3].text forState:UIControlStateNormal];
    
    self.question = q;
    
    // Set the number of the question
    self.lblNumQuestion.text = [NSString stringWithFormat:@"Fråga %i", [self.game getNumOfQuestion]];
    
    // Clear label for Right/Wrong answer
    self.lblRightWrong.text = @"";
}

- (void) setAnswerRightOrWrong:(NSString*)answer{
    BOOL correctAnswer = [self.game checkAnswear:answer forQuestion:self.question];
    
    if(correctAnswer){
        [self.lblRightWrong setTextColor:[UIColor greenColor]];
        self.lblRightWrong.text = @"Right";
    }
    else{
        [self.lblRightWrong setTextColor:[UIColor redColor]];
        self.lblRightWrong.text = @"Wrong";
    }
}

- (void) checkShowScore{
    if([self.game isGameOver]){
        // Set final score
        self.tvQuestion.text = [NSString stringWithFormat:@"Score: %i", self.game.score];
        
        // Change title of button Next to New Game
        [self.btnNext setTitle:@"Nytt Spel" forState:UIControlStateNormal];
        
        // hide buttons and label
        [self hideUIElements:YES];

        // Create Questions
        [self.game createQuestions];
        
        // Reset score
        self.game.score = 0;
    }
}

- (void) hideUIElements:(BOOL)hide{
    // hide/show answer buttons
    self.btnAnswer1.hidden = hide;
    self.btnAnswer2.hidden = hide;
    self.btnAnswer3.hidden = hide;
    self.btnAnswer4.hidden = hide;
    // Hide label number of question
    self.lblNumQuestion.hidden = hide;
}

- (void) disableAnswerUIButtons:(BOOL)disable{
    // disable/enable answer buttons
    self.btnAnswer1.enabled = !disable;
    self.btnAnswer2.enabled = !disable;
    self.btnAnswer3.enabled = !disable;
    self.btnAnswer4.enabled = !disable;
}

- (void) makeCoolUIElements{
    [[self.btnNext layer] setBorderWidth:1.0f];
    [[self.btnNext layer] setCornerRadius:7.0f];
    [[self.btnNext layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[self.btnAnswer1 layer] setBorderWidth:1.0f];
    [[self.btnAnswer1 layer] setCornerRadius:7.0f];
    [[self.btnAnswer1 layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[self.btnAnswer2 layer] setBorderWidth:1.0f];
    [[self.btnAnswer2 layer] setCornerRadius:7.0f];
    [[self.btnAnswer2 layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[self.btnAnswer3 layer] setBorderWidth:1.0f];
    [[self.btnAnswer3 layer] setCornerRadius:7.0f];
    [[self.btnAnswer3 layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[self.btnAnswer4 layer] setBorderWidth:1.0f];
    [[self.btnAnswer4 layer] setCornerRadius:7.0f];
    [[self.btnAnswer4 layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[self.tvQuestion layer] setBorderWidth:1.0f];
    [[self.tvQuestion layer] setCornerRadius:7.0f];
    [[self.tvQuestion layer] setBorderColor:[UIColor blackColor].CGColor];
}

@end
