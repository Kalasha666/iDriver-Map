//
//  CLMapObject.m
//  iAutoMap
//
//  Created by Oleg Kalashnik on 26.10.12.
//  Copyright (c) 2012 Oleg Kalashnik. All rights reserved.
//

#import "CLMapObject.h"

@implementation CLMapObject

@synthesize name = name_;
@synthesize address = address_;
@synthesize type = type_;
@synthesize coordinate = coordinate_;
@synthesize image = image_;

#pragma mark - DEALLOC

- (void)dealloc
{
    [name_ release]; name_ = nil;
    [address_ release]; address_ = nil;
    [image_ release]; image_ = nil;
    
    [super dealloc];
}

#pragma mark - INIT

- (id)init
{
    self = [super init];
    if (self)
    {
        name_ = [[NSString alloc] init];
        address_ = [[NSString alloc] init];
        type_ = CLMapObjectTypeOther;
        image_ = [[UIImage alloc] init];
    }
    return self;
}

- (id)initWithName:(NSString*)theName address:(NSString*)theAddress coordinate:(CLLocationCoordinate2D)theCoordinate
{
    self = [super init];
    if (self)
    {
        name_ = [theName copy];
        address_ = [theAddress copy];
        coordinate_ = theCoordinate;
        image_ = [[UIImage alloc] init];
    }
    return self;
}

#pragma mark - MKAnnotation

- (NSString *)title
{
    return [self name];
}

- (NSString *)subtitle
{
    return [self address];
}
@end
