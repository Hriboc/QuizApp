//
//  Game.h
//  ObjCQuiz
//
//  Created by Hristijan Bocevski on 2017-01-18.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"
#import "Question.h"

@interface Game : NSObject

@property (nonatomic) int score;

- (void) createQuestions;
- (Question*) getQuestion;
- (BOOL) checkAnswear:(NSString*)answear forQuestion:(Question*)question;
- (BOOL) isGameOver;
- (int) getNumOfQuestion;

@end
