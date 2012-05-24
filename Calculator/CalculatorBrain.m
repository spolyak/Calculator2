//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Steve Polyak on 5/10/12.
//  Copyright (c) 2012 Pearson. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;

@end
@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void) pushOperand:(double)operand 
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
    
}

- (double)performOperation:(NSString *)operation {

    //calculate result
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id) program 
{
    return [self.programStack copy];
}

+ (NSString *) descriptionOfProgram:(id)program 
{
    return @"Implement this in assignment 2";
}

+ (double) popOperandOffStack:(NSMutableArray *)stack {
    double result = 0; 

    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeObject:topOfStack];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        
        if([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([@"/" isEqualToString:operation]) {
            double divisor = [self popOperandOffStack:stack];
            if (divisor) result = [self popOperandOffStack:stack] / divisor;
        } else if ([@"-" isEqualToString:operation]) {
            double subtrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrahend;
        } else if ([@"sin" isEqualToString:operation]) {
            double theta = [self popOperandOffStack:stack] * M_PI/180;
            result = sin(theta);
        } else if ([@"cos" isEqualToString:operation]) {
            double theta = [self popOperandOffStack:stack] * M_PI/180;
            result = cos(theta);
        } else if ([@"√" isEqualToString:operation]) {
            result = sqrt([self popOperandOffStack:stack]);
        } else if ([@"π" isEqualToString:operation]) {
            result = M_PI;
        }        
    }
    
    return result;
}

+ (double) runProgram:(id)program {
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy]; 
    }
    return [self popOperandOffStack:stack];
}
  
- (void) clear {
    [self.programStack removeAllObjects];   
}

@end
