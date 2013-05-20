//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Juan Mignaco on 19/05/13.
//  Copyright (c) 2013 Juan Mignaco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void)pushOperand: (double)operand;
- (double)performOperation: (NSString *)operation;
- (void) clearData;
@end
