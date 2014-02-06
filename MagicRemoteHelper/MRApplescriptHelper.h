//
//  MRApplescriptHelper.h
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRApplescriptHelper : NSObject
+ (NSString *)executeApplescriptWithName:(NSString *)name;
+ (BOOL)isAppInstalled:(NSString *)appId;
@end
