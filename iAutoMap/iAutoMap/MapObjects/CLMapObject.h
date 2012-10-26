//
//  CLMapObject.h
//  iAutoMap
//
//  Created by Oleg Kalashnik on 26.10.12.
//  Copyright (c) 2012 Oleg Kalashnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum
{
    CLMapObjectTypeMVD = 660,
    CLMapObjectTypeAvaria = 661,
    CLMapObjectTypeOther = 662,
    
}CLMapObjectType;

@interface CLMapObject : NSObject<MKAnnotation>
{
    NSString *name_;
    NSString *address_;
    CLMapObjectType type_;
    CLLocationCoordinate2D coordinate_;
    UIImage *image_;
}

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, assign)CLMapObjectType type;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic, retain)UIImage *image;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;


@end
