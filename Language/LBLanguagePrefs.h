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

- (void)saveLanguage:(NSString*)language;
- (NSString*)userLanguage;
@end
