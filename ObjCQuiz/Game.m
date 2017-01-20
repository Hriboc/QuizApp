//
//  Game.m
//  ObjCQuiz
//
//  Created by Hristijan Bocevski on 2017-01-18.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

#import "Game.h"


static int const TotalNumOfQuestions = 10;
static int const QuestionsToPlay = 5;


// local stuff
@interface Game()

@property (nonatomic) NSMutableArray<Question*> *questions;

@end


@implementation Game

- (Question*) getQuestion{
    Question *q = self.questions[(arc4random() % self.questions.count)];
    [self.questions removeObject:q];
    return q;
}

- (BOOL) checkAnswear:(NSString*)answer forQuestion:(Question*)question{
    BOOL result = NO;
    
    for (Answer *a in question.answers) {
        if (a.text == answer) {
            if(a.correct){
                self.score += question.score;
                result = YES;
            }
            else self.score--;;
        }
    }
    return result;
}

- (BOOL) isGameOver{
    return self.questions.count <= QuestionsToPlay;
}

- (int) getNumOfQuestion{
    return TotalNumOfQuestions - self.questions.count;
}

- (void) createQuestions{
    self.questions = @[].mutableCopy;
    
    // [Question : [Score, Ans1, Ans2, Ans2, Ans4, Ans1_Corr, Ans2_Corr, Ans3_Corr, Ans4_Corr]]
    NSDictionary *lookUpQues = @{
        @"Vilket är världens största levande däggdjur?" :
            @[@"1",@"Valhaj",@"Blåval",@"Megalodon",@"Kaskelot", @"0",@"1",@"0",@"0"],
        @"Vilken planet är närmast solen?" :
            @[@"3",@"Venus",@"Neptunus",@"Merkurius",@"Uranus", @"0",@"0",@"1",@"0"],
        @"Vilken år upptäckte Colombus America?" :
            @[@"2",@"1283",@"1368",@"1492",@"1576", @"0",@"0",@"1",@"0"],
        @"Vad heter protestantismens grundare?" :
            @[@"2",@"Martin Luther",@"Philipp Melanchtons",@"Huldrych Zwingli",@"Johann Reuchlin", @"1",@"0",@"0",@"0"],
        @"Vilken av föjande Romerska kejsare var galen?" :
            @[@"3",@"Julius",@"Augustus",@"Claudius",@"Caligula", @"0",@"0",@"0",@"1"],
        @"Vilken språkstam tillhör Makedonska språket?" :
            @[@"1",@"Östslaviska",@"Västslaviska",@"Vlasiska",@"Sydslaviska", @"0",@"0",@"0",@"1"],
        @"Från vilken film är rollkaraktären Vincent Vega?" :
            @[@"1",@"Street Fighter 2",@"Pulp Fiction",@"Gladiator",@"Star Wars 5", @"0",@"1",@"0",@"0"],
        @"Vad heter A- Vitamin med ett annat namn?" :
            @[@"3",@"Askorbibsyra",@"Retinol",@"Kalciforol",@"Kobolamin", @"0",@"1",@"0",@"0"],
        @"I vilken tv-serie hör karaktärer Jack Killian hemma?" :
            @[@"2",@"Midnight Caller",@"That 70s show",@"Baywatch",@"Falcon Crest", @"1",@"0",@"0",@"0"],
        @"Vilket land har inte varit värdsmästare i herrfotboll?" :
            @[@"3",@"Uruguay",@"Frankrike",@"Nederländerna",@"England", @"0",@"0",@"1",@"0"]
    };
    
    NSArray *questions = lookUpQues.allKeys;
    
    for (NSString *qKey in questions) {
        // - 1:st question
        Question *q = [[Question alloc] init];
        q.text = qKey;
        q.score = [lookUpQues[qKey][0] intValue];
        
        // create answears
        Answer *a1 = [[Answer alloc] init];
        a1.text = lookUpQues[qKey][1];
        a1.correct = [lookUpQues[qKey][5] boolValue];
        
        Answer *a2 = [[Answer alloc] init];
        a2.text = lookUpQues[qKey][2];
        a2.correct = [lookUpQues[qKey][6] boolValue];
        
        Answer *a3 = [[Answer alloc] init];
        a3.text = lookUpQues[qKey][3];
        a3.correct = [lookUpQues[qKey][7] boolValue];
        
        Answer *a4 = [[Answer alloc] init];
        a4.text = lookUpQues[qKey][4];
        a4.correct = [lookUpQues[qKey][8] boolValue];
        
        // add answears to question
        NSArray<Answer*> *a = @[a1,a2,a3,a4];
        q.answers = a;
        
        // add question to questions
        [self.questions addObject:q];
    }
}

@end
