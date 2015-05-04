//
//  MyAdditions.h
//  testhttpconnect
//
//  Created by panda on 27/4/15.
//  Copyright (c) 2015 360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(MyAdditions)
-(NSString *)md5;
-(id)JSONValue;
// Strips HTML tags & comments, removes extra whitespace and decodes HTML character entities.
- (NSString *)stringByConvertingHTMLToPlainText;

// Decode all HTML entities using GTM.
- (NSString *)stringByDecodingHTMLEntities;

// Encode all HTML entities using GTM.
- (NSString *)stringByEncodingHTMLEntities;

// Minimal unicode encoding will only cover characters from table
// A.2.2 of http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
// which is what you want for a unicode encoded webpage.
- (NSString *)stringByEncodingHTMLEntities:(BOOL)isUnicode;

// Replace newlines with <br /> tags.
- (NSString *)stringWithNewLinesAsBRs;

// Remove newlines and white space from string.
- (NSString *)stringByRemovingNewLinesAndWhitespace;
@end

@interface NSData (MyAdditions)
-(NSString *)md5;
- (id)toArrayOrNSDictionary;
@end