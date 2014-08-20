//
//  Prefs.h
//  LanguageChangeApp
//
//  Created by Lena Brusilovski on 5/28/14.
//  Copyright (c) 2014  Lena Brusilovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kLanguage @"language"
@interface LBLanguagePrefs : NSObject

/**
 *Saves the preferred language to the user defaults
 */
- (void)saveLanguage:(NSString*)language;

/**
 *get the last saved language from the user defaults
 */
- (NSString*)userLanguage;
@end
