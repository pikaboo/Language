//
//  Prefs.h
//  LanguageChangeApp
//
//  Created by Dev1 on 5/28/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kLanguage @"language"
@interface Prefs : NSObject

- (void)saveLanguage:(NSString*)language;
- (NSString*)userLanguage;
@end
