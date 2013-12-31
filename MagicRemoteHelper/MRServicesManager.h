//
//  MRServicesManager.h
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MRService <NSObject>
-(NSString *)serviceName;
//-(NSImage *)serviceImage;
-(void)performAction:(NSString *)action callback:(void (^)())callback;
-(void)requestInfoWithCallback:(void (^)(NSDictionary *info))callback;
@end

@interface MRServicesManager : NSObject
{
    
    NSArray *services;
    id <MRService> selectedService;
}
+ (id)sharedManager;
- (void)addService:(id<MRService>)service;

-(void) makeAction:(NSString *)action callback:(void (^)())callback;
-(void) infoRequestWithCallback:(void (^)(NSDictionary *dict))callback;

@property (nonatomic) NSInteger selectedServiceIndex;
@end

