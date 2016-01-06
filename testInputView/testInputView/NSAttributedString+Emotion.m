//
//  NSAttributedString+Emotion.m
//  testInputView
//
//  Created by minggo on 16/1/6.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "NSAttributedString+Emotion.h"
#import "EmotionTextAttachment.h"

@implementation NSAttributedString (Emotion)


-(NSString *) mgo_getPlainString {
    
    NSMutableString *sourceString = [NSMutableString stringWithString:self.string];
    
    __block NSUInteger index = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value && [value isKindOfClass:[EmotionTextAttachment class]]) {
            [sourceString replaceCharactersInRange:NSMakeRange(range.location + index, range.length) withString:((EmotionTextAttachment *) value).emotionStr];
            index += ((EmotionTextAttachment *) value).emotionStr.length - 1;
        }
    }];
    
    return sourceString;
}
@end
