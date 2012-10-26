//
//  CLViewController.m
//  iAutoMap
//
//  Created by Oleg Kalashnik on 26.10.12.
//  Copyright (c) 2012 Oleg Kalashnik. All rights reserved.
//

#import "CLViewController.h"
#import "CLMapObject.h"


#define METERS_PER_MILE 1609.344

@interface CLViewController (Private)

- (void)zoomWithLocation:(CLLocationDegrees)theLatitude longitude:(CLLocationDegrees)theLongitude anim:(BOOL)isAnim;
- (void)addAnnotationType:(CLMapObjectType)theType latitude:(CLLocationDegrees)theLatitude longitude:(CLLocationDegrees)theLongitude;
- (void)removeAllAnnotation;

@end

@implementation CLViewController
@synthesize mapView = mapView_;

#pragma mark - DEALLOC

- (void)dealloc
{
    [annotationsArray_ release];
    
    [super dealloc];
}

#pragma mark - INIT


#pragma mark - LIFECYRCLE

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self zoomWithLocation:39.28 longitude:-76.58 anim:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    annotationsArray_ = [[NSMutableArray alloc] init];
    
    [[self mapView] setFrame:[[self view]bounds]];
    [[self mapView] setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CUSTOM

- (void)zoomWithLocation:(CLLocationDegrees)theLatitude longitude:(CLLocationDegrees)theLongitude anim:(BOOL)isAnim
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = theLatitude;
    zoomLocation.longitude= theLongitude;

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5f *METERS_PER_MILE, 0.5f * METERS_PER_MILE);
    
    MKCoordinateRegion adjustedRegion = [mapView_ regionThatFits:viewRegion];

    NSLog (@"%@", mapView_);
    [mapView_ setRegion:adjustedRegion animated:YES];
}

- (void)removeAllAnnotation
{
    
}

- (void)addAnnotationType:(CLMapObjectType)theType latitude:(CLLocationDegrees)theLatitude longitude:(CLLocationDegrees)theLongitude
{
    NSString * name = nil;
    NSString * address = nil;
    UIImage * image = nil;
    
    switch (theType) {
        case CLMapObjectTypeMVD:
        {
            name = @"GAI";
            address = [NSString stringWithFormat:@"Date: %@", [NSDate date]];
            image = [UIImage imageNamed:@"gai_icon.png"];
        }
            break;
        case CLMapObjectTypeAvaria:
        {
            name = @"Avariya";
            address = [NSString stringWithFormat:@"Date: %@", [NSDate date]];
            image = [UIImage imageNamed:@"avariya_icon.png"];
        }
            break;
            
        default:
        {
            name = @"Other";
            address = [NSString stringWithFormat:@"Date: %@", [NSDate date]];
            image = [UIImage imageNamed:@"other_icon.png"];
        }
            break;
    }
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = theLatitude;
    coordinate.longitude = theLongitude;
    CLMapObject *annotation = [[CLMapObject alloc] initWithName:name address:address coordinate:coordinate];
    [annotation setImage:image];
    [mapView_ addAnnotation:annotation];
    [annotationsArray_ addObject:annotation];
}

#pragma mark - Touch 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint locationPoint = [[touches anyObject] locationInView:[self mapView]];
    currentCoordinate_ = [[self mapView] convertPoint:locationPoint toCoordinateFromView:[self mapView]];

    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Type"
                                                             delegate:self
                                                    cancelButtonTitle:@"Отмена"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"ГАИ", @"Авария", @"Прочее" ,nil];
    
    [actionSheet showInView:[self view]];
    
    [actionSheet release];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"CLMapObject";
    if ([annotation isKindOfClass:[CLMapObject class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView_ dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil)
        {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        else
        {
            [annotationView setAnnotation: annotation];
        }
        
        [annotationView setEnabled:YES];
        [annotationView setCanShowCallout:YES];
        [annotationView setImage:[(CLMapObject*)annotation image]];
        
        return annotationView;
    }
    
    return nil;    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Index: %d", buttonIndex);
    
    switch (buttonIndex) {
        case 0:
        {
            [self addAnnotationType:CLMapObjectTypeMVD latitude:currentCoordinate_.latitude longitude:currentCoordinate_.longitude];
        }
            break;
        case 1:
        {
            [self addAnnotationType:CLMapObjectTypeAvaria latitude:currentCoordinate_.latitude longitude:currentCoordinate_.longitude];
        }
            break;
        case 2:
        {
            [self addAnnotationType:CLMapObjectTypeOther latitude:currentCoordinate_.latitude longitude:currentCoordinate_.longitude];
        }
            break;
            
        default:
            break;
    }
}
@end
