//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Juan Mignaco on 18/05/13.
//  Copyright (c) 2013 Juan Mignaco. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL decimalPointPressed;
@property (nonatomic) BOOL isEqualPrinted;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize decimalPointPressed;
@synthesize brain = _brain;
@synthesize historyDisplay;

- (CalculatorBrain *)brain{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (void) deleteEqualSign {
    if ([self.historyDisplay.text length] > 0 && self.isEqualPrinted) {
        self.historyDisplay.text = [self.historyDisplay.text substringToIndex: [self.historyDisplay.text length] - 1];
        self.isEqualPrinted = NO;
    }
}

- (IBAction)decimalPressed:(UIButton *)sender {
    if (!self.decimalPointPressed) {
        [self deleteEqualSign];
        self.decimalPointPressed = YES;
        if (self.userIsInTheMiddleOfEnteringANumber) {
            self.display.text = [self.display.text stringByAppendingString:@"."];
        } else {
            self.display.text = @"0.";
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
    }
}
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    [self deleteEqualSign];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }else{
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed {
    [self deleteEqualSign];
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.historyDisplay.text = [[self.historyDisplay.text stringByAppendingString:@" "] stringByAppendingString:self.display.text];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.decimalPointPressed = NO;
}
- (IBAction)operationPressed:(UIButton *)sender {
    [self deleteEqualSign];
    if(self.userIsInTheMiddleOfEnteringANumber){
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    self.historyDisplay.text = [[self.historyDisplay.text stringByAppendingString:@" "] stringByAppendingString:operation];
    self.historyDisplay.text = [self.historyDisplay.text stringByAppendingString:@" ="];
    self.isEqualPrinted = YES;
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}
- (IBAction)clearPressed {
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.decimalPointPressed = NO;
    self.isEqualPrinted = NO;
    self.display.text = @"0";
    self.historyDisplay.text = @"";
    [self.brain clearData];
}
- (IBAction)backspacePressed {
    if(self.userIsInTheMiddleOfEnteringANumber){
        self.display.text = [self.display.text substringToIndex: [self.display.text length] - 1];
    }
}
- (IBAction)changeSignPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) self.display.text = [@"-" stringByAppendingString:self.display.text];
    else [self operationPressed:sender];
    
}


@end
