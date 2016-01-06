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
    //最终纯文本
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    
    //替换下标的偏移量
    __block NSUInteger base = 0;
    
    //遍历
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
                      
        //检查类型是否是自定义NSTextAttachment类
        if (value && [value isKindOfClass:[EmotionTextAttachment class]]) {
            //替换
            [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length) withString:((EmotionTextAttachment *) value).emotionStr];
            //增加偏移量
            base += ((EmotionTextAttachment *) value).emotionStr.length - 1;
        }
    }];
    
    return plainString;
}
@end
