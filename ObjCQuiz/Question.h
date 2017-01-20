//
//  Question.h
//  ObjCQuiz
//
//  Created by Hristijan Bocevski on 2017-01-18.
//  Copyright © 2017 Hristijan Bocevski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"

@interface Question : NSObject

@property (nonatomic) NSString* text;
@property (nonatomic) NSArray<Answer*> *answers;
@property (nonatomic) int score;

@end
