//
//  RFSerializableDate.h
//  ROADSerialization
//
//  Copyright (c) 2013 Epam Systems. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this
// list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//  Neither the name of the EPAM Systems, Inc.  nor the names of its contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// See the NOTICE file and the LICENSE file distributed with this work
// for additional information regarding copyright ownership and licensing

#import <ROAD/ROADAttribute.h>

/**
 * Serialization attribute. Can be used either as a class attribute to set date format for all properties of a class. Can be used as individual property attribute to specify format date for this property or to override general format of date for whole class. Default value specify both encoding and decoding format, for specifying format for concrete direction set this format string to decodingFormat or encodingFormat.
 */
@interface RFSerializableDate : NSObject

/**
 * Format for both encoding and decoding date. Format of string described here https://developer.apple.com/library/mac/documentation/cocoa/conceptual/DataFormatting/Articles/dfDateFormatting10_4.html
 */
@property(nonatomic, strong) NSString *format;

/**
 * Format for decoding string to NSDate object. Format rules the same as format property. Takes precedences over format.
 */
@property(nonatomic, strong) NSString *decodingFormat;
/**
 * Format for encoding NSDate object to string. Format rules the same as format property. Takes precedences over format.
 */
@property(nonatomic, strong) NSString *encodingFormat;

/**
 * Marks property as Unix Timestamp. It will be deserialized with [NSDate dateWithTimeIntervalSince1970:]. Set unixTimestampMultiplier for specefying other multipliers.
 */
@property(nonatomic, assign) BOOL unixTimestamp;
/**
 * If unixTimestamp is YES, then allows to change default multiplier. Default value is 1000 to match difference between seconds indateWithTimeIntervalSince1970: method and milliseconds in unix timestamp.
 */
@property (nonatomic, assign) float unixTimestampMultiplier;

@end
