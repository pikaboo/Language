//
//  Language.h
//  Lena Brusilovski
//
//  Created by Lena Brusilovski on 4/28/14.
//  Copyright (c) 2014 Lena Brusilovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBLanguagePrefs.h"

#define TextAlignment [[Language currentLanguage]textAlignment]

#define NotificationLanguageChanged @"languageChanged"
@interface LBLanguage : NSObject




@property (nonatomic,strong)NSString *locale;
@property (nonatomic,strong,readonly)NSBundle *bundle;
@property (nonatomic,assign)NSLocaleLanguageDirection languageDirection;
@property (nonatomic,assign)NSTextAlignment textAlignment;
-(instancetype)initWithLocale:(NSString *)locale;
-(NSArray *)loadNibNamed:(NSString *)name owner:(id)owner options:(NSDictionary *)options;
-(UINib *)nibWithNibName:(NSString *)name;
-(NSString *)getString:(const NSString *)key;
-(BOOL)isRTL;
+(LBLanguage *)ENGLISH;
+(LBLanguage *)HEBREW;
+(LBLanguage *)RUSSIAN;
+(LBLanguage *)ARABIC;
+(LBLanguage *)ITALIAN;
+(LBLanguage *)SPANISH;

+(void)setLanguage:(NSString *)locale;
+(LBLanguage *)currentLanguage;
@end
