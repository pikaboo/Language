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



/**
 *The locale of the language, e.g "en" , "he", "ar"
 *specific locales, such as "en-US" and others, are not supported
 */
@property (nonatomic,strong)NSString *locale;

/**
 *The bundle of the given locale
 */
@property (nonatomic,strong,readonly)NSBundle *bundle;

/**
 *The language direction, either NSLocaleLanguageDirectionLeftToRight or NSLocaleLanguageDirectionRightToLeft
 */
@property (nonatomic,assign)NSLocaleLanguageDirection languageDirection;

/**
 *The language text alignment, for RTL languages returns NSTextAlignmentRight and for LTR languages returns NSTextAlignmentLeft
 */
@property (nonatomic,assign)NSTextAlignment textAlignment;

/**
 * create a language object with a specific locale
 */
-(instancetype)initWithLocale:(NSString *)locale;
/**
 *Load a nib from the localized bundle
 */
-(NSArray *)loadNibNamed:(NSString *)name owner:(id)owner options:(NSDictionary *)options;

/**
 *Load a nib from the localized bundle
 */
-(UINib *)nibWithNibName:(NSString *)name;

/**
 *get a localized string with the given key, returns 
 *the Base bundle value if key is not found, or the key itself
 *the language specific values should appear in a file called Localizable.strings
 *for each language
 */
-(NSString *)getString:(const NSString *)key;

/**
 *Returns whether or not the language is RTL, returns true for HEBREW and ARABIC, false otherwise
 */
-(BOOL)isRTL;

/**
 *preset languages
 */
+(LBLanguage *)ENGLISH;
+(LBLanguage *)HEBREW;
+(LBLanguage *)RUSSIAN;
+(LBLanguage *)ARABIC;
+(LBLanguage *)ITALIAN;
+(LBLanguage *)SPANISH;


/**
 *set the preferred language
 */
+(void)setLanguage:(NSString *)locale;

/**
 *get the current language
 */
+(LBLanguage *)currentLanguage;
@end
