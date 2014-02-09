//
//  MRApplescriptHelper.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "MRApplescriptHelper.h"

@implementation MRApplescriptHelper

+ (NSString *)executeApplescriptWithName:(NSString *)name{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *str = [bundle pathForResource:name ofType:@"applescript"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:str];
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:url error:nil];
    NSAppleEventDescriptor *event = [script executeAndReturnError:nil];

    return event.stringValue;
}

+ (BOOL)isAppInstalled:(NSString *)appId{
    
    NSString *string = [NSString stringWithFormat:@"try \n tell application \"Finder\" \n  set appname to name of application file id \"%@\" \n return 1 \n end tell \n  on error err_msg number err_num \n  return 0\n  end try", appId];
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:string];
    NSAppleEventDescriptor *event = [script executeAndReturnError:nil];
    
    return ([event.stringValue isEqualToString:@"1"]);
}
@end
