Language
========

Change IOS Language On the fly


Adding this allows changing your App's language on the fly.


You need to add the Language folder into your files, and add these methods into your app delegate

    @interface AppDelegate()
    @property (nonatomic,strong)Prefs *prefs;
    @end
    @implementation AppDelegate

      - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
        {
        // Override point for customization after application launch.
           _prefs = [[Prefs alloc]init];
            [Language setLanguage:[_prefs userLanguage]];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLanguage:)   name:NotificationLanguageChanged  object:nil];
            return YES;
         }
 
    
    -(void)changeLanguage:(NSNotification *)note{
    Language *lang  = [note object];
    [self.prefs saveLanguage:lang.locale];
    UIViewController *currentScreen =[_window.rootViewController.storyboard   instantiateViewControllerWithIdentifier:@"someidentifier"];
       //    [currentScreen setTheNeededState];
       //  or put the needed state in view will appear of that view controller
    self.window.rootViewController = currentScreen;
    }


then in the view controller that allows changing the language you put:

    -(IBAction)changeLanguage:(id)sender{
             
        NSInteger index = self.segmentedControl.selectedSegmentIndex;  //<- get the changed language
        NSString *newLocale = [@[@"base",@"he",@"ar",@"ru"] objectAtIndex:index];  <-- get its locale name
        [Language setLanguage:newLocale]; <-- just set the language. A notification to your app's delegate will be sent if the language has changed
           
       }
