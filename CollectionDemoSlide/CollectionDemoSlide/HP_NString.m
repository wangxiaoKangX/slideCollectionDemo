//
//  NNString.m
//  AllBelieve
//
//  Created by fengxiaoguang on 14-3-25.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import "HP_NString.h"

#define queding @"确定"

#define PassWordRegex @"^[0-9a-zA-Z!@#$%^&_]{6,16}$"// 数字或字母或特殊字符
#define PhoneNoRegex @"^(1(([3578][0-9])|(47)))\\d{8}$"

@implementation HP_NString

+ (NSString *)getRightString_BysortArray_dic:(NSDictionary *)dic
{
    NSMutableString *rightString =[NSMutableString stringWithString:@""];
    NSArray *_sortedArray= [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in _sortedArray)
    {
        [rightString appendFormat:@"%@",[dic objectForKey:key]];
    }
    return rightString;
}

//判断字符串为空和只为空格解决办法
+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+(NSString*)delStringNull:(id)object
{
    
    if ([object isEqual:[NSNull null]])
    {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if (object==nil)
    {
        return @"";
    }
    return object;
    
}

+(id)delObjectNull:(id)object
{
    
    if ([object isEqual:[NSNull null]])
    {
        return nil;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    else if (object==nil)
    {
        return nil;
    }
    return object;
    
}


+(NSMutableDictionary* )delStringNullOfDictionary:(NSDictionary *)object
{
    if(![object isKindOfClass:[NSDictionary class]])
    {
        return object;
    }
    NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
    
    for (NSString *key in object)
    {
        [Dict setObject:[self delStringNull:[object objectForKey:key]] forKey:key];
    }
    
    return Dict;
}

+(NSData *) getDataFromString:(NSString *) string encoding:(NSStringEncoding)encoding{
    //NSUTF32BigEndianStringEncoding
    return [string dataUsingEncoding:encoding];
}



+(CGSize) sizeOfText:(NSString *) text withFont:(UIFont *) font andSize:(CGSize) size andLineSpace:(CGFloat) lineSpace andColor:(UIColor *) color
{
    CGSize resSize = CGSizeZero;
    NSMutableAttributedString *attStr = [HP_NString createAttributeStringWithText:text LineSpace:lineSpace andFont:font andColor:color];
    resSize = [attStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return  resSize;
}


+ (NSMutableAttributedString *) createAttributeStringWithText:(NSString *) text LineSpace:(CGFloat) lineSpace andFont:(UIFont *) font andColor:(UIColor *) color
{
    if(nil == text)
        return nil;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    //设置字体颜色
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length)];
    //设置行距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;//行距
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    return attStr;
}

+(BOOL)isNumber:(NSString *) string
{
    NSArray *numbers = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    if([numbers indexOfObject:string] != NSNotFound)
    {
        return YES;
    }
    return NO;
}

//iOS 算法之：阿拉伯数字转化为汉语数字
+ (NSString *) translation:(NSString *)arebic

{   NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    NSLog(@"%@",str);
    NSLog(@"%@",chinese);
    return chinese;
}


+ (NSString *) getCurrentTimeWithSpecialFormat:(NSString* )string
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:string];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return  currentDateStr;
}

+ (NSString *) getTimeWithTime:(NSString *)time andOrigFormat:(NSString *) origFormat andFormat:(NSString *) format
{
     NSDateFormatter* formater = [[NSDateFormatter alloc] init];
     [formater setDateFormat:origFormat];
     NSDate *date = [formater dateFromString:time];
     NSTimeInterval interval = [date timeIntervalSince1970];
     return [self getTimeWithTimestamp:interval andFormat:format];
}

+ (NSString *)getTimeWithTimestamp:(NSTimeInterval)timestamp andFormat:(NSString *) format
{
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:publishDate];
}

+ (BOOL)checkshenfenzhengString:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        return NO;
    }
    if (msgstring.length!=18)
    {
        return NO;
    }
    
    for (int i=0; i<str.length-1; i++)
    {
        if (!isdigit([str characterAtIndex:i]))
        {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)checkMobileString:(NSString *)string
{
    NSString* msgstring=[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        return NO;
    }
    //1[0-9]{10}
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    //    NSString *regex = @"[0-9]{11}";
    NSString *regex = PhoneNoRegex;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if (!isMatch)
    {
        return NO;
    }
    return YES;
    
}

+ (BOOL) checkPasswordString:(NSString *) pwd
{
    NSString* msgstring = [pwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        return NO;
    }
    NSString *regex = PassWordRegex;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:pwd];
    if (!isMatch)
    {
        return NO;
    }
    return YES;

}

+ (BOOL)checkEmailString:(NSString *)EmailString
{
    NSString* msgstring=[EmailString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        return NO;
    }

    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    if (![emailTest evaluateWithObject:EmailString])
    {
        return NO;
    }
    return YES;
}

+ (BOOL)checkPostcodeString:(NSString *)string
{
    
    NSString* msgstring=[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        return NO;
    }
    if (msgstring.length!=6)
    {
        return NO;
    }
    if ([msgstring intValue]<0)
    {
        return NO;
    }
    return YES;
}

/**
 * 校验银行卡卡号
 * @param cardId
 * @return
 */
+ (BOOL)checkBankCard:(NSString *)cardId
{
    // 验证数字：^[0-9]*$
    NSString *regex  = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if(nil == cardId || cardId.length <= 0||![pred evaluateWithObject:cardId])
    {
        return NO;
    }
    char bit = [self getBankCardCheckCode:[cardId substringWithRange:NSMakeRange(0, cardId.length - 1)]];
    
    BOOL res = bit == [cardId characterAtIndex:cardId.length - 1];
    return  res;
}

/**
 * 从不含校验位的银行卡卡号采用 Luhm 校验算法获得校验位
 * @param nonCheckCodeCardId
 * @return
 */
+ (char)getBankCardCheckCode:(NSString *)nonCheckCodeCardId
{
    // 验证数字：^[0-9]*$
    NSString *regex  = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if(nil == nonCheckCodeCardId || nonCheckCodeCardId.length <= 0||![pred evaluateWithObject:nonCheckCodeCardId])
    {
        return '0';
    }
    const char *chs = [nonCheckCodeCardId UTF8String];
    int luhmSum = 0;
    for(int i = nonCheckCodeCardId.length - 1,j = 0; i >= 0; i--,j++)
    {
        int k = chs[i] - '0';
        if(j % 2 == 0) {
            k *= 2;
            k = k / 10 + k % 10;
        }
        luhmSum += k;
    }
    char res = (luhmSum % 10 == 0) ? '0' : (char)((10 - luhmSum % 10) + '0');
    return res;
    
}

+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet {
    NSString *returnVal = @"";
    if (val)
    {
        returnVal = [val stringByTrimmingCharactersInSet:characterSet];
    }
    return returnVal;
}

+ (NSString *)trimWhitespace:(NSString *)val
{
    
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]]; //去掉前后空格
}

+ (NSString *)trimNewline:(NSString *)val
{
    
    return [self trim:val trimCharacterSet:[NSCharacterSet newlineCharacterSet]]; //去掉前后回车符
}

+ (NSString *)trimWhitespaceAndNewline:(NSString *)val
{
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去掉前后空格和回车符
}

@end
