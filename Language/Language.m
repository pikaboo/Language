//
//  Language.m
//  Lena Brusilovski
//
//  Created by Lena Brusilovski on 4/28/14.
//  Copyright (c) 2014 Lena Brusilovski. All rights reserved.
//

#import "Language.h"
@interface Language()
@property (nonatomic,strong)NSBundle *resourceBundle;
@property (nonatomic,strong)NSBundle *base;
@end
@implementation Language
@synthesize resourceBundle;

static Language *currentLanguage;

+(void)setLanguage:(NSString *)locale{
    [[NSUserDefaults standardUserDefaults]setObject:@[[Language preferedLocalization]] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    BOOL changed =self.currentLanguage && ![locale isEqualToString:self.currentLanguage.locale];
    if([locale isEqualToString:[[Language ENGLISH]locale]]){
        currentLanguage = [Language ENGLISH];
    }else
        if([locale isEqualToString:[[Language ARABIC]locale]]){
            currentLanguage = [Language ARABIC];
        }else
            if([locale isEqualToString:[[Language HEBREW]locale]]){
                currentLanguage =[Language HEBREW];
            }else
                if([locale isEqualToString:[[Language ITALIAN]locale]]){
                    currentLanguage = [Language ITALIAN];
                }else
                    if([locale isEqualToString:[[Language RUSSIAN]locale]]){
                        currentLanguage = [Language RUSSIAN];
                    }else {
                        currentLanguage = [Language ENGLISH];
                    }
    if(changed){
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLanguageChanged object:currentLanguage];
    }
}

-(BOOL)isRTL{
    return  self.languageDirection == NSLocaleLanguageDirectionRightToLeft;
}

+(Language *)currentLanguage{
    return currentLanguage;
}
-(instancetype)initWithLocale:(NSString *)locale{
    self = [super init];
    if(self){
        self.locale = locale;
        if([locale isEqualToString:@"he"] ||[locale isEqualToString:@"ar"]){
            self.languageDirection = NSLocaleLanguageDirectionRightToLeft;
            self.textAlignment = NSTextAlignmentRight;
        }else {
            self.languageDirection = NSLocaleLanguageDirectionLeftToRight;
            self.textAlignment = NSTextAlignmentLeft;
        }
    }
    return self;
}

-(NSBundle *)bundle{
    
    if(!self.base){
        self.base = [NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"Base" ofType:@"lproj"]];
    }
    if(!resourceBundle){
        resourceBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:self.locale ofType:@"lproj"]];
        if(!resourceBundle){
            resourceBundle = [NSBundle mainBundle];
        }
    }
    
    
    return resourceBundle;
}

+(NSString *)preferedLocalization{
    return [[[NSBundle mainBundle]preferredLocalizations]objectAtIndex:0];
}

-(NSArray *)loadNibNamed:(NSString *)name owner:(id)owner options:(NSDictionary *)options{
    if(self.languageDirection == NSLocaleLanguageDirectionRightToLeft){
        //look for localized resource
        if([[[Language currentLanguage]bundle]pathForResource:name ofType:@"nib"]!=nil){
            NSLog(@"requested resource found  file:%@ exists, loading ",name);
            return [[[Language currentLanguage]bundle]loadNibNamed:name owner:owner options:options];
        }
        //asume there is an RTL layout in hebrew layouts
        if([[[Language HEBREW]bundle]pathForResource:name ofType:@"nib"] != nil)
        {
            NSLog(@"rtl orientation file:%@ exists, loading ",name);
            return [[[Language HEBREW]bundle]loadNibNamed:name owner:owner options:options];
        }
    }
    //look for base resource
    if([self.base pathForResource:name ofType:@"nib"]!=nil){
        return   [self.base loadNibNamed:name owner:owner options:options];
    }
    //load default resource
    return [[NSBundle mainBundle]loadNibNamed:name owner:owner options:options];
}
-(UINib *)nibWithNibName:(NSString *)name{
    if(self.languageDirection == NSLocaleLanguageDirectionRightToLeft){
        //look for localized resource
        if([[[Language currentLanguage]bundle]pathForResource:name ofType:@"nib"]!=nil){
            NSLog(@"requested resource found  file:%@ exists, loading ",name);
            return  [UINib nibWithNibName:name bundle:[[Language currentLanguage]bundle]];
        }
        //assume there is an RTL layout in hebrew layouts
        if([[[Language HEBREW]bundle]pathForResource:name ofType:@"nib"] != nil)
        {
            NSLog(@"rtl orientation file:%@ exists, loading ",name);
            
            return  [UINib nibWithNibName:name bundle:[[Language HEBREW]bundle]];
        }
    }
    //look for base layout
    if([self.base pathForResource:name ofType:@"nib"]!=nil){
        return   [UINib nibWithNibName:name bundle:self.base];
    }
    //load default layout
    return [UINib nibWithNibName:name bundle:[NSBundle mainBundle]];
}
+(Language *)ENGLISH{
    static Language *lang = nil;
    if(!lang){
        lang = [[Language alloc]initWithLocale:@"en"];
    }
    return lang;
}
+(Language *)HEBREW{
    static Language *lang = nil;
    if(!lang){
        lang = [[Language alloc]initWithLocale:@"he"];
    }
    return lang;
}
+(Language *)ARABIC{
    static Language *lang = nil;
    if(!lang){
        lang = [[Language alloc]initWithLocale:@"ar"];
    }
    return lang;
}
+(Language *)ITALIAN{
    static Language *lang = nil;
    if(!lang){
        lang = [[Language alloc]initWithLocale:@"it"];
    }
    return lang;
}
+(Language *)RUSSIAN{
    static Language *lang = nil;
    if(!lang){
        lang = [[Language alloc]initWithLocale:@"ru"];
    }
    return lang;
}

+(Language *)SPANISH{
    static Language *lang = nil;
    if(!lang){
        lang = [[Language alloc]initWithLocale:@"es"];
    }
    return lang;
}
-(NSString *)getString:(NSString *)key{
    NSString *defaultValue = [[NSBundle mainBundle]localizedStringForKey:key value:@"" table:nil];
    NSString *str = [self.bundle localizedStringForKey:key value:defaultValue table:nil];
    return str;
}

@end
