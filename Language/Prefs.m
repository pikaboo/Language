//
//  Prefs.m
//  LanguageChangeApp
//
//  Created by  Lena Brusilovski on 5/28/14.
//  Copyright (c) 2014  Lena Brusilovski. All rights reserved.
//

#import "Prefs.h"

@implementation Prefs

- (void)saveLanguage:(NSString*)language
{
    [self saveObject:language
              forKey:kLanguage];
}
- (NSString*)userLanguage
{
    NSArray* locales = [NSLocale preferredLanguages];
    NSString* locale;
    if (locales.count > 0) {
        locale = [locales objectAtIndex:0];
    }
    
    NSArray* localizedLanguages = [[NSBundle mainBundle] localizations];
    NSString* defaultValue = [localizedLanguages indexOfObject:locale] == NSNotFound ? @"en" : locale;
    NSString* language = [self getObjectForKey:kLanguage
                                  defaultValue:defaultValue];
    return language;
}

- (id)getObjectForKey:(NSString*)aKey defaultValue:(id)value
{
    id object = [[NSUserDefaults standardUserDefaults] objectForKey:aKey];
    if (!object) {
        return value;
    }
    return object;
}

- (void)saveObject:(id)object forKey:(NSString*)aKey
{
    if (aKey && object) {
        [[NSUserDefaults standardUserDefaults] setObject:object
                                                  forKey:aKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
