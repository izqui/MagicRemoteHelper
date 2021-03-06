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
-(NSString *)appIdentifier;

-(void)performAction:(NSString *)action callback:(void (^)())callback;
-(void)requestInfoWithCallback:(void (^)(NSDictionary *info))callback;
@optional
-(void)requestMediaCurrentImage:(void (^)(NSData *data, NSString *ext))callback;

@end


@interface MRServicesManager : NSObject
{
    
    NSArray *services;
    id <MRService> selectedService;
}
+ (id)sharedManager;
- (void)addService:(id<MRService>)service;
- (NSArray *)getServices;


-(void) makeAction:(NSString *)action callback:(void (^)())callback;
-(void) infoRequestWithCallback:(void (^)(NSDictionary *dict))callback;
-(void) getImageWithCallback:(void (^)(NSData *data, NSString *ext))callback;

-(NSInteger) getCurrentVolume;
-(NSInteger) turnVolume:(NSString *)level;

@property (nonatomic) NSInteger selectedServiceIndex;
@end

