//
//  AttributeTest.m
//  ObjCAttrPerformanceTest
//
//  Copyright (c) 2014 EPAM Systems, Inc. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this
//  list of conditions and the following disclaimer in the documentation and/or
//  other materials provided with the distribution.
//  Neither the name of the EPAM Systems, Inc.  nor the names of its contributors
//  may be used to endorse or promote products derived from this software without
//  specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  See the NOTICE file and the LICENSE file distributed with this work
//  for additional information regarding copyright ownership and licensing


#import <ROAD/ROADAttribute.h>
#import <ROAD/ROADReflection.h>
#import "AttributeTest.h"
#import "Functions.h"

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

@implementation AttributeTest

- (AttributeTestResult *)runTest {
    AttributeTestResult *result = [[AttributeTestResult alloc] init];

    size_t numberOfIteration = 1000;
    uint64_t retrievingClassAttributesTime = dispatch_benchmark(numberOfIteration, ^{
        for (Class class in self.classes) {
            if ([[class RF_attributesForClass] count] != self.params.numberOfClassAttributes) {
                NSLog(@"Error retrieving attributes - %@", [class RF_attributesForClass]);
            }
        }
    });
    result.retrievingClassAttributes = retrievingClassAttributesTime;
    
    uint64_t retrievingPropertyAttributesTime = dispatch_benchmark(numberOfIteration, ^{
        for (Class class in self.classes) {
            for (RFPropertyInfo *property in [class RF_properties]) {
                if ([[property attributes] count] != self.params.numberOfPropertyAttributes) {
                    NSLog(@"Error retrieving attributes");
                }
            }
        }
    });
    result.retrievingPropertyAttributes = retrievingPropertyAttributesTime;
    
    uint64_t retrievingMethodAttributesTime = dispatch_benchmark(numberOfIteration, ^{
        for (Class class in self.classes) {
            for (RFMethodInfo *method in [class RF_methods]) {
                if ([[method attributes] count] != self.params.numberOfMethodAttributes) {
                    NSLog(@"Error retrieving attributes");
                }
            }
            [class RF_attributesForClass];
        }
    });
    result.retrievingMethodAttributes = retrievingMethodAttributesTime;
    
    uint64_t retrievingIvarAttributesTime = dispatch_benchmark(numberOfIteration, ^{
        for (Class class in self.classes) {
            for (RFIvarInfo *ivar in [class RF_ivars]) {
                if ([[ivar attributes] count] != self.params.numberOfIvarAttributes) {
                    NSLog(@"Error retrieving attributes");
                }
            }
            [class RF_attributesForClass];
        }
    });
    result.retrievingIvarAttributes = retrievingIvarAttributesTime;

    return result;
}

@end
