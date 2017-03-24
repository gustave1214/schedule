//
//  AppController.m


#import "AppController.h"

static AppController *_appController;

@implementation AppController

+ (AppController *)sharedInstance {
    static dispatch_once_t predicate;
    if (_appController == nil) {
        dispatch_once(&predicate, ^{
            _appController = [[AppController alloc] init];
        });
    }
    return _appController;
}

- (id)init {
    self = [super init];
    if (self) {
        self.vAlert = [[DoAlertView alloc] init];
        self.vAlert.nAnimationType = 3;  // there are 5 type of animation
        self.vAlert.dRound = 7.0;
        self.vAlert.bDestructive = NO;  // for destructive mode
        
        self.studingDays = [[NSArray alloc] init];
        self.hour = 0;
        self.minute = 0;
        
        self.subjects = [[NSArray alloc] initWithObjects:@"Art", @"English", @"Geography", @"History", @"IT", @"Maths", @"Music", @"Science", @"Technology", nil];
        
    }
    return self;
}

@end
