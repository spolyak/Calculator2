//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Steve Polyak on 5/10/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void) clear;

@end
