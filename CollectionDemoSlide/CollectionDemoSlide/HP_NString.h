//
//  NNString.h
//  AllBelieve
//
//  Created by fengxiaoguang on 14-3-25.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HP_NString : NSString

//字典正序排序
+ (NSString *) getRightString_BysortArray_dic:(NSDictionary *)dic;

//判断字符串为空和只为空格解决办法
+ (BOOL) isBlankString:(NSString *)string;

//清除对象里的<NULL>
+(NSString*)delStringNull:(id)object;

+(id)delObjectNull:(id)object;

//清除对象里的<NULL>
+(NSMutableDictionary *)delStringNullOfDictionary:(NSDictionary*)object;

//NSString类型转NSDate类型
+(NSData *) getDataFromString:(NSString *) string encoding:(NSStringEncoding)encoding;

// 根据字符串、字体、行间距、颜色获得字体所占空间大小CGSize，限制在size大小范围内
+(CGSize) sizeOfText:(NSString *) text withFont:(UIFont *) font andSize:(CGSize) size andLineSpace:(CGFloat) lineSpace andColor:(UIColor *) color;

+(NSMutableAttributedString *) createAttributeStringWithText:(NSString *) text LineSpace:(CGFloat) lineSpace andFont:(UIFont *) font andColor:(UIColor *) color;

+(BOOL)isNumber:(NSString *) string;

//iOS 算法之：阿拉伯数字转化为汉语数字
+(NSString *) translation:(NSString *)arebic;

+ (NSString *) getCurrentTimeWithSpecialFormat:(NSString* )string;

// 按照format格式 获取时间time对应的时间
+ (NSString *) getTimeWithTime:(NSString *)time andOrigFormat:(NSString *) origFormat andFormat:(NSString *) format;

// 按照format格式 获取时间戳对应的时间
+ (NSString *) getTimeWithTimestamp:(NSTimeInterval)timestamp andFormat:(NSString *) format;

//验证身份证
+ (BOOL)checkshenfenzhengString:(NSString *)str;

//验证手机号
+ (BOOL)checkMobileString:(NSString *)string;

// 验证密码（数字或字母或特殊字符）
+ (BOOL) checkPasswordString:(NSString *) pwd;

//验证邮箱
+ (BOOL)checkEmailString:(NSString *)EmailString;

//验证邮编
+ (BOOL)checkPostcodeString:(NSString *)string;
/**
 * 校验银行卡卡号
 */
+ (BOOL)checkBankCard:(NSString *)cardId;
// 去掉前后空格
+ (NSString *)trimWhitespace:(NSString *)val;

// 去掉前后回车符
+ (NSString *)trimNewline:(NSString *)val;

// 去掉前后空格、回车符
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;

@end
