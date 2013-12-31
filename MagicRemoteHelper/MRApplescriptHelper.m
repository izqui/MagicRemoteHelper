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
    NSLog(@"path %@", str);
    NSURL *url = [[NSURL alloc] initFileURLWithPath:str];
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:url error:nil];
    NSAppleEventDescriptor *event = [script executeAndReturnError:nil];
    
    return event.stringValue;
}
@end
