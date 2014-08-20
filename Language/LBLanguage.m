//
//  Language.m
//  Lena Brusilovski
//
//  Created by Lena Brusilovski on 4/28/14.
//  Copyright (c) 2014 Lena Brusilovski. All rights reserved.
//

#import "LBLanguage.h"
@interface LBLanguage()
@property (nonatomic,strong)NSBundle *resourceBundle;
@property (nonatomic,strong)NSBundle *base;
@end
@implementation LBLanguage
@synthesize resourceBundle;

static LBLanguage *currentLanguage;

+(void)setLanguage:(NSString *)locale{
    [[NSUserDefaults standardUserDefaults]setObject:@[[LBLanguage preferedLocalization]] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    BOOL changed =self.currentLanguage && ![locale isEqualToString:self.currentLanguage.locale];
    if([locale isEqualToString:[[LBLanguage ENGLISH]locale]]){
        currentLanguage = [LBLanguage ENGLISH];
    }else
        if([locale isEqualToString:[[LBLanguage ARABIC]locale]]){
            currentLanguage = [LBLanguage ARABIC];
        }else
            if([locale isEqualToString:[[LBLanguage HEBREW]locale]]){
                currentLanguage =[LBLanguage HEBREW];
            }else
                if([locale isEqualToString:[[LBLanguage ITALIAN]locale]]){
                    currentLanguage = [LBLanguage ITALIAN];
                }else
                    if([locale isEqualToString:[[LBLanguage RUSSIAN]locale]]){
                        currentLanguage = [LBLanguage RUSSIAN];
                    }else {
                        currentLanguage = [LBLanguage ENGLISH];
                    }
    if(changed){
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLanguageChanged object:currentLanguage];
    }
}

-(BOOL)isRTL{
    return  self.languageDirection == NSLocaleLanguageDirectionRightToLeft;
}

+(LBLanguage *)currentLanguage{
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
        if([[[LBLanguage currentLanguage]bundle]pathForResource:name ofType:@"nib"]!=nil){
            NSLog(@"requested resource found  file:%@ exists, loading ",name);
            return [[[LBLanguage currentLanguage]bundle]loadNibNamed:name owner:owner options:options];
        }
        //asume there is an RTL layout in hebrew layouts
        if([[[LBLanguage HEBREW]bundle]pathForResource:name ofType:@"nib"] != nil)
        {
            NSLog(@"rtl orientation file:%@ exists, loading ",name);
            return [[[LBLanguage HEBREW]bundle]loadNibNamed:name owner:owner options:options];
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
        if([[[LBLanguage currentLanguage]bundle]pathForResource:name ofType:@"nib"]!=nil){
            NSLog(@"requested resource found  file:%@ exists, loading ",name);
            return  [UINib nibWithNibName:name bundle:[[LBLanguage currentLanguage]bundle]];
        }
        //assume there is an RTL layout in hebrew layouts
        if([[[LBLanguage HEBREW]bundle]pathForResource:name ofType:@"nib"] != nil)
        {
            NSLog(@"rtl orientation file:%@ exists, loading ",name);
            
            return  [UINib nibWithNibName:name bundle:[[LBLanguage HEBREW]bundle]];
        }
    }
    //look for base layout
    if([self.base pathForResource:name ofType:@"nib"]!=nil){
        return   [UINib nibWithNibName:name bundle:self.base];
    }
    //load default layout
    return [UINib nibWithNibName:name bundle:[NSBundle mainBundle]];
}
+(LBLanguage *)ENGLISH{
    static LBLanguage *lang = nil;
    if(!lang){
        lang = [[LBLanguage alloc]initWithLocale:@"en"];
    }
    return lang;
}
+(LBLanguage *)HEBREW{
    static LBLanguage *lang = nil;
    if(!lang){
        lang = [[LBLanguage alloc]initWithLocale:@"he"];
    }
    return lang;
}
+(LBLanguage *)ARABIC{
    static LBLanguage *lang = nil;
    if(!lang){
        lang = [[LBLanguage alloc]initWithLocale:@"ar"];
    }
    return lang;
}
+(LBLanguage *)ITALIAN{
    static LBLanguage *lang = nil;
    if(!lang){
        lang = [[LBLanguage alloc]initWithLocale:@"it"];
    }
    return lang;
}
+(LBLanguage *)RUSSIAN{
    static LBLanguage *lang = nil;
    if(!lang){
        lang = [[LBLanguage alloc]initWithLocale:@"ru"];
    }
    return lang;
}

+(LBLanguage *)SPANISH{
    static LBLanguage *lang = nil;
    if(!lang){
        lang = [[LBLanguage alloc]initWithLocale:@"es"];
    }
    return lang;
}
-(NSString *)getString:(NSString *)key{
    NSString *defaultValue = [[NSBundle mainBundle]localizedStringForKey:key value:@"" table:nil];
    NSString *str = [self.bundle localizedStringForKey:key value:defaultValue table:nil];
    return str;
}

@end
